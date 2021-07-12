extends HBoxContainer


onready var monedas = $NinePatchRect/HBoxContainer/cantidad
onready var animacion = $AnimationPlayer

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	if(monedas.text != str(Globales.monedas)):
		monedas.text = str(Globales.monedas)
		animacion.play("cambio")
