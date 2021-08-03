extends KinematicBody2D

onready var animacion = get_node("animacion")

#variables de movimiento
var velocidad_maxima = 75
var aceleracion = 600
var movimiento = Vector2.ZERO
var orientacion = 'abajo'
var estaAtacando = false
const danoClass = preload("res://scripts/dano.gd")
var dano
var manejando_dano = false


# Called when the node enters the scene tree for the first time.
func _ready():
	dano = danoClass.new()
	
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
		
func mover(aceleracionTotal):
	movimiento += aceleracionTotal
	movimiento = movimiento.clamped(velocidad_maxima)	

func establecer_orientacion():
	
	if Input.is_action_just_pressed("atacar"):
		establecerAnimacionAtaque()
		return
	
	if (estaAtacando == false):
		#caminar
		if 	Input.is_action_pressed("ui_right") :
			orientacion = 'derecha'
			animacion.scale.x = 1
			animacion.play("caminarLado")
			return 
		if 	Input.is_action_pressed("ui_left") :
			orientacion = 'izquierda'
			animacion.scale.x = -1
			animacion.play("caminarLado")
			return
		if 	Input.is_action_pressed("ui_up") :
			orientacion = 'arriba'
			animacion.play("caminarArriba")
			return
		if 	Input.is_action_pressed("ui_down") :
			orientacion = 'abajo'
			animacion.play("caminarAbajo")
			return

		#descanso
		if Input.is_action_just_released("ui_right") :
			animacion.play("descansoLado")
		if Input.is_action_just_released("ui_left") :
			animacion.play("descansoLado")
		if Input.is_action_just_released("ui_up") :
			animacion.play("descansoArriba")
		if Input.is_action_just_released("ui_down") :
			animacion.play("descansoAbajo")


func _on_animacion_animation_finished():
	estaAtacando = false
	if(animacion.animation == "atacarLado"):
		animacion.play("descansoLado")
		$ataque/derecha.disabled = true
		$ataque/izquierda.disabled = true
	if(animacion.animation == "atacarArriba"):
		animacion.play("descansoArriba")
		$ataque/arriba.disabled = true
	if(animacion.animation == "atacarAbajo"):
		animacion.play("descansoAbajo")
		$ataque/abajo.disabled = true

func establecerAnimacionAtaque():
	estaAtacando = true
	if(orientacion == "derecha"):
		animacion.scale.x = 1
		animacion.play("atacarLado")
	if(orientacion == "izquierda"):
		animacion.scale.x = -1
		animacion.play("atacarLado")
	if(orientacion == "arriba"):
		animacion.play("atacarArriba")
	if(orientacion == "abajo"):
		animacion.play("atacarAbajo")

func manejar_dano(ataque_recibido, pos_enemigo):
	manejando_dano = true
	Globales.vida -= ataque_recibido
	dano.flash(self, animacion.material)
	dano.retroceso(self, pos_enemigo)
	yield(get_tree().create_timer(0.2), "timeout")
	manejando_dano = false


func _on_ataque_body_entered(body):
	hacer_dano(body)
	
# le hace dano al jugador
func hacer_dano(body):
	if(body.has_method("manejar_dano")):
		print(body.name)
		if(!body.manejando_dano):
			body.manejar_dano(Globales.ataque, global_position)


func _on_animacion_frame_changed():
	if(animacion.frame == 1 && estaAtacando == true):
		if(animacion.animation == "atacarLado" && animacion.scale.x == 1):
			$ataque/derecha.disabled = false
		if(animacion.animation == "atacarLado" && animacion.scale.x == -1):	
			$ataque/izquierda.disabled = false
		if(animacion.animation == "atacarArriba"):
			$ataque/arriba.disabled = false
		if(animacion.animation == "atacarAbajo"):
			$ataque/abajo.disabled = false
	
	

