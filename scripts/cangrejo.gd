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
export var ataque = 10

func _physics_process(delta):
	if (estado == 'espera'):
		estado_espera()
	if (estado == 'alerta'):
		estado_alerta(delta)
	if (estado == 'patrullar'):
		estado_patrullar(delta)
	if (estado == 'atacar'):
		estado_atacar(delta)
		
# el cangrejo persigue al jugador
func estado_alerta(delta):
	if(objetivo):
		animacion.speed_scale = 2
		ultima_pos_x =  lerp(ultima_pos_x, global_position.x, 0.5)
		pos_objetivo = lerp(pos_objetivo, objetivo.global_position, 0.5)
		var direccion = global_position.direction_to(pos_objetivo)
		calcular_direccion()
		if(animacion.animation != 'caminar'):
			animacion.play('caminar')
		var _colision = move_and_collide(direccion * acceleracion * delta)
		if(_colision):
			print('colide')
			hacer_dano(_colision.collider)

# el cangrejo descansa
func estado_espera():
	#var val = randi() % 1
	#print(val)
	animacion.speed_scale = 1.1
	animacion.play("espera")
	yield(get_tree().create_timer(2.0), "timeout")

# el cangrejo se mueve hacia la derecha y luego a la izquierda
func estado_patrullar(delta):
	animacion.speed_scale = 1.1
	if(animacion.scale.x > 0):
		pos_objetivo = lerp(pos_objetivo, Vector2(global_position.x + 100 , global_position.y), 0.5)
	else:
		pos_objetivo = lerp(pos_objetivo, Vector2(global_position.x - 100 , global_position.y), 0.5)
	var direccion = global_position.direction_to(pos_objetivo)
	var _mover = move_and_collide(direccion * acceleracion * delta)
	animacion.play('caminar')

#el cangrejo ataca con la pinza
func estado_atacar(delta):
	if(objetivo):
		animacion.speed_scale = 3
		ultima_pos_x =  global_position.x
		pos_objetivo =  objetivo.global_position
		var direccion = global_position.direction_to(pos_objetivo)
		calcular_direccion()
		if(animacion.animation != 'atacar'):
			animacion.play('atacar')
		var _colision = move_and_collide(direccion * acceleracion * delta)
		if(_colision):
			print('colide')
			hacer_dano(_colision.collider)

# detecta si el cangrejo se esta moviendo a la derecha o a la izquierda
func calcular_direccion():
	if(ultima_pos_x <= objetivo.global_position.x):
		#derecha
		animacion.scale.x = 1
	else:
		#izquierda
		animacion.scale.x = -1

func _on_cangrejo_ready():
	ultima_pos_x = global_position.x
	orientacion = RNGTools.pick(orientaciones)
	
# cambia la direccion del patrullaje hacia la derecha o la izquierda
func _on_Timer_timeout():
	$Timer.wait_time =  RNGTools.pick([2,3,4])
	if(estado != 'alerta' && estado !='atacar'):
		if(estado == 'espera'):
			estado = 'patrullar'
			animacion.scale.x = animacion.scale.x * -1
		else:
			estado = 'espera'
			
# el cangrejo comienza a atacar
func _on_area_ataque_body_entered(body):
	if(body.name == 'personaje'):
		estado = 'atacar'
	else:
		estado = 'espera'

# el personaje sale del area de ataque pero aun es perseguido
func _on_area_ataque_body_exited(body):
	if(body.name == 'personaje'):
		estado = 'alerta'

# el cangrejo comienza a perseguir al jugador
func _on_area_alerta_body_entered(body):
	if (body.name == "personaje"):
		objetivo = body
		estado = 'alerta'

# el cangrejo deja de seguir al jugador 
func _on_area_alerta_body_exited(body):
	if body.name == "personaje":
		objetivo = null
		estado = 'espera'

# activa el hitbox durante la animacion de ataque
func _on_animacion_frame_changed():
	if(animacion.animation == 'atacar'):
		$pinzas/colision_pinzas.disabled = false
	else:
		$pinzas/colision_pinzas.disabled = true

# lastima al jugador
func _on_pinzas_body_entered(body):
	hacer_dano(body)

# le hace dano al jugador
func hacer_dano(body):
	if(body.has_method("manejar_dano")):
		body.manejar_dano(ataque, global_position)
