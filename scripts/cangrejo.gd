extends KinematicBody2D

const acceleracion = 50
onready var animacion = $animacion
var estado = 'espera'
var objetivo = null
var orientacion = '' 
var orientaciones = ['izquierda', 'derecha']
var pos_objetivo: Vector2
var ultima_pos_x
var caminando = false

func _physics_process(delta):
	if (estado == 'espera'):
		estado_espera()
	if (estado == 'alerta'):
		estado_alerta(delta)
	if (estado == 'patrullar'):
		estado_patrullar(delta)
	if (estado == 'atacar'):
		estado_atacar(delta)
		
func estado_alerta(delta):
	if(objetivo):
		animacion.speed_scale = 2
		ultima_pos_x =  lerp(ultima_pos_x, global_position.x, 0.5)
		pos_objetivo = lerp(pos_objetivo, objetivo.global_position, 0.5)
		var direccion = global_position.direction_to(pos_objetivo)
		calcular_direccion()
		if(animacion.animation != 'caminar'):
			animacion.play('caminar')
		var _mover = move_and_collide(direccion * acceleracion * delta)
		#if(_mover):
		#	detectar_colisiones(_mover.collider.name)
	
func estado_espera():
	#var val = randi() % 1
	#print(val)
	animacion.speed_scale = 1.1
	animacion.play("espera")
	yield(get_tree().create_timer(2.0), "timeout")

func estado_patrullar(delta):
	animacion.speed_scale = 1.1
	if(animacion.scale.x > 0):
		pos_objetivo = lerp(pos_objetivo, Vector2(global_position.x + 100 , global_position.y), 0.5)
	else:
		pos_objetivo = lerp(pos_objetivo, Vector2(global_position.x - 100 , global_position.y), 0.5)
	var direccion = global_position.direction_to(pos_objetivo)
	var _mover = move_and_collide(direccion * acceleracion * delta)
	animacion.play('caminar')

func estado_atacar(delta):
	if(objetivo):
		animacion.speed_scale = 3
		ultima_pos_x =  global_position.x
		pos_objetivo =  objetivo.global_position
		var direccion = global_position.direction_to(pos_objetivo)
		calcular_direccion()
		if(animacion.animation != 'atacar'):
			animacion.play('atacar')
		var _mover = move_and_collide(direccion * acceleracion * delta)

func calcular_direccion():
	if(ultima_pos_x < objetivo.global_position.x):
		#derecha
		animacion.scale.x = 1
	else:
		#izquierda
		animacion.scale.x = -1

func _on_cangrejo_ready():
	ultima_pos_x = global_position.x
	orientacion = RNGTools.pick(orientaciones)
	
func _on_Timer_timeout():
	$Timer.wait_time =  RNGTools.pick([2,3,4])
	if(estado != 'alerta'):
		if(estado == 'espera'):
			estado = 'patrullar'
			animacion.scale.x = animacion.scale.x * -1
		else:
			estado = 'espera'
			
func _on_area_ataque_body_entered(body):
	if(body.name == 'personaje'):
		estado = 'atacar'
	else:
		estado = 'espera'

func _on_area_ataque_body_exited(body):
	if(body.name == 'personaje'):
		estado = 'alerta'

func _on_area_alerta_body_entered(body):
	if (body.name == "personaje"):
		objetivo = body
		estado = 'alerta'

func _on_area_alerta_body_exited(body):
	if body.name == "personaje":
		objetivo = null
		estado = 'espera'
