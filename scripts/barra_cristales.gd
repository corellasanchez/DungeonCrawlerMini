extends HBoxContainer


onready var cristales = $NinePatchRect/cantidad
onready var animacion = $AnimationPlayer

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	if(cristales.text != str(Globales.cristales)):
		cristales.text = str(Globales.cristales)
		animacion.play("cambio")
