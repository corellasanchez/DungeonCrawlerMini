extends Node2D


var manejando_dano = false
onready var animacion = $animacion

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


func manejar_dano(_ataque_recibido, _pos_enemigo):
	manejando_dano = true
	animacion.play('explosion')
	manejando_dano = false


func _on_animacion_animation_finished():
	self.queue_free()
