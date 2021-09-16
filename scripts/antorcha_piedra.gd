extends Node2D
export(String, "encendida", "apagada") var estado = 'encendida'

func _ready():
	$KinematicBody2D/fuego.visible =  (estado == "encendida")
	
func establecerEstado(estadoNuevo):
	estado = estadoNuevo
	$KinematicBody2D/fuego.visible =  (estado == "encendida")
