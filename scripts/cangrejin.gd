extends Node2D

var velocidad = 20;
onready var ruta = $Path2D/PathFollow2D
onready var animacion = $Path2D/PathFollow2D/KinematicBody2D/animacion
var direccion = "derecha"

# Called when the node enters the scene tree for the first time.
func _ready():
	pass
	

func _physics_process(delta):
	patrullar(delta)
	
func patrullar(delta):
	if direccion == "derecha" :
		if (ruta.unit_offset == 1):
			animacion.play("espera")
			yield(get_tree().create_timer(3.0), "timeout")
			animacion.scale.x = -1
			direccion = "izquierda"
		else:
			if (animacion.animation != "caminar"):
				animacion.play("caminar")
			ruta.offset += velocidad * delta
	else:
		if (ruta.unit_offset == 0):
				animacion.play("espera")
				yield(get_tree().create_timer(3.0), "timeout")
				animacion.scale.x = 1
				direccion = "derecha"
		else:
			if (animacion.animation != "caminar"):
				animacion.play("caminar")
			ruta.offset -= velocidad * delta

		
		
		
	
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
