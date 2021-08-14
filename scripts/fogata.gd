extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_area_body_entered(body):
	hacer_dano(body)

# le hace dano al jugador
func hacer_dano(body):
	print(body.name)
	if(body.has_method("manejar_dano")):
		if(!body.manejando_dano):
			body.manejar_dano(5, global_position)
			$particulas.emitting = true
			yield(get_tree().create_timer(0.7), "timeout")
			$particulas.emitting = false
			
