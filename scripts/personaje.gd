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
	if get_slide_count() > 0:
		verificar_colision_caja(eje,get_slide_collision(0).collider)

func verificar_colision_caja(mov: Vector2, collider) -> void:
	if abs(mov.x) + abs(mov.y) > 1:
		return
	if(collider.is_in_group("empujable")):
		print(collider.name)
		print('es empujable')
		collider.empujar(mov)
		
#	var box : = get_slide_collision(0).collider as Box
#	if box:
#		box.push(push_speed * movimiento)

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

func establecerAnimacionAtaque():
	estaAtacando = true
	if(orientacion == "derecha"):
		animacion.scale.x = 1
		$animaciones_herramienta.play('atacar_derecha')
	if(orientacion == "izquierda"):
		animacion.scale.x = -1
		$animaciones_herramienta.play('atacar_izquierda')
	if(orientacion == "arriba"):
		$animaciones_herramienta.play('atacar_arriba')
	if(orientacion == "abajo"):
		$animaciones_herramienta.play('atacar_abajo')
		
func manejar_dano(ataque_recibido, pos_enemigo):
	manejando_dano = true
	Globales.vida -= ataque_recibido
	dano.flash(self, animacion.material)
	dano.retroceso(self, pos_enemigo)
	yield(get_tree().create_timer(0.2), "timeout")
	manejando_dano = false
	
func _on_animaciones_herramienta_animation_finished(anim_name):
	estaAtacando = false
	$arma/area_arma/colision.disabled = true
	if(anim_name == "atacar_derecha" || anim_name == "atacar_izquierda" ):
		animacion.play("descansoLado")
	if(anim_name == "atacar_arriba"):
		animacion.play("descansoArriba")
	if(anim_name == "atacar_abajo"):
		animacion.play("descansoAbajo")

func _on_area_arma_body_entered(body):
	hacer_dano(body)
	
# le hace dano al jugador
func hacer_dano(body):
	if(body.name !="personaje" && body.has_method("manejar_dano")):
		if(!body.manejando_dano):
			body.manejar_dano(Globales.ataque, global_position)

func _on_animaciones_herramienta_animation_started(anim_name):
	if(anim_name == "atacar_derecha" || anim_name == "atacar_izquierda" || anim_name == "atacar_arriba" || anim_name == "atacar_abajo"):
		estaAtacando = true
		$arma/area_arma/colision.disabled = false
