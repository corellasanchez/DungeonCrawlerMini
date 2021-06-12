extends KinematicBody2D

onready var animacion = get_node("animacion")

#variables de movimiento
var velocidad_maxima = 75
var aceleracion = 600
var movimiento = Vector2.ZERO
var orientacion = 'derecha'

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.
	
func _physics_process(delta):
	establecer_orientacion()
	var eje = obtener_eje()
	if eje == Vector2.ZERO:
		aplicar_friccion(aceleracion * delta)
	else:
		mover(eje * aceleracion * delta)
	movimiento = move_and_slide(movimiento)

func obtener_eje():
	var eje = Vector2.ZERO
	eje.x = int(Input.is_action_pressed("ui_right")) - int(Input.is_action_pressed("ui_left"))
	eje.y = int(Input.is_action_pressed("ui_down")) - int(Input.is_action_pressed("ui_up"))
	return eje.normalized()

func aplicar_friccion(cantidad):
	if movimiento.length() > cantidad:
		movimiento -= movimiento.normalized() * cantidad
	else:
		movimiento = Vector2.ZERO
		
func mover(aceleracion):
	movimiento += aceleracion
	movimiento = movimiento.clamped(velocidad_maxima)	

func establecer_orientacion():
	#caminar
	if 	Input.is_action_pressed("ui_right") :
		orientacion = 'derecha'
		animacion.scale.x = 1
		animacion.play("caminarLado")
	if 	Input.is_action_pressed("ui_left") :
		orientacion = 'izquierda'
		animacion.scale.x = -1
		animacion.play("caminarLado")
	if 	Input.is_action_pressed("ui_up") :
		orientacion = 'arriba'
		animacion.play("caminarArriba")
	if 	Input.is_action_pressed("ui_down") :
		orientacion = 'abajo'
		animacion.play("caminarAbajo")
		if (Input.is_action_pressed("ui_left")) :
			animacion.play("caminarAbajo")
			return true

	#descanso
	if Input.is_action_just_released("ui_right") :
		animacion.play("descansoLado")
	if Input.is_action_just_released("ui_left") :
		animacion.play("descansoLado")
	if Input.is_action_just_released("ui_up") :
		animacion.play("descansoArriba")
	if Input.is_action_just_released("ui_down") :
		animacion.play("descansoAbajo")
		
