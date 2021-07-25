extends KinematicBody2D

var objetivo = null
var pos_objetivo: Vector2
const acceleracion = 50
var ultima_pos_x
var estado = 'normal'
onready var animacion = $animacion
var orientaciones = ['izquierda', 'derecha']
var orientacion = '' 

func _physics_process(delta):
	if (estado == 'normal'):
		estado_normal(delta)
	if (estado == 'alerta'):
		estado_alerta(delta)

func _on_Area2D_body_entered(body):
	print(body.name)
	if (body.name == "personaje"):
		objetivo = body
		estado = 'alerta'

func _on_Area2D_body_exited(body):
	if body.name == "personaje":
		objetivo = null
		estado = 'normal'
		
func estado_alerta(delta):
	if(objetivo):
		animacion.speed_scale = 2
		ultima_pos_x =  lerp(ultima_pos_x, global_position.x, 0.5)
		pos_objetivo = lerp(pos_objetivo, objetivo.global_position, 0.5)
		var direccion = global_position.direction_to(pos_objetivo)
		calcular_direccion()
		if(animacion.animation != 'caminar'):
			animacion.play('caminar')
		move_and_collide(direccion * acceleracion * delta)
		# look_at(objetivo.global_position)

func estado_normal(delta):
	animacion.speed_scale = 1.1
	animacion.play("espera")
	yield(get_tree().create_timer(3.0), "timeout")

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
