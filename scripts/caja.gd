extends KinematicBody2D

var velocidad = 50

func empujar(direccion: Vector2) -> void:
	print('me empujan')
	print(direccion)
	move_and_slide(direccion.normalized() * velocidad , Vector2())
