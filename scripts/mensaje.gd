extends CanvasLayer

onready var animacion = $AnimationPlayer
onready var label = $Control/NinePatchRect/VBoxContainer/Label

func mostrar_mensaje():
	label.text = Globales.texto_dialogo
	animacion.play("aparecer")
	
func ocultar_mensaje():
	animacion.play("desaparecer")
