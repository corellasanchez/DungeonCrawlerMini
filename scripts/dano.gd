extends Node


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func flash(body: KinematicBody2D, material: Material):
	material.set_shader_param("intensidad_golpe", 0)
	material.set_shader_param("intensidad_golpe", 0.4)
	yield(body.get_tree().create_timer(0.1), "timeout")
	material.set_shader_param("intensidad_golpe", 0.8)
	yield(body.get_tree().create_timer(0.1), "timeout")
	material.set_shader_param("intensidad_golpe", 0)

func retroceso(body: KinematicBody2D, pos_enemigo: Vector2):
	var pos_x
	var pos_y
	
	if(body.global_position.x > pos_enemigo.x):
		pos_x = body.global_position.x + 50
	else:
		pos_x = body.global_position.x -50
	
	if(body.global_position.y > pos_enemigo.y):
		pos_y = body.global_position.y + 50
	else:
		pos_y = body.global_position.y -50
	
	var pos_objetivo = Vector2(pos_x, pos_y)
	var direccion = body.global_position.direction_to(pos_objetivo).normalized() * 10
	var _movimiento = body.move_and_collide(direccion)
