extends HBoxContainer

onready var llaves = $NinePatchRect/llaves
onready var animacion = $AnimationPlayer

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	if(llaves.text != str(Globales.llaves)):
		llaves.text = str(Globales.llaves)
		animacion.play("cambio")
