extends TextureProgress

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	value = Globales.vida
	if(value > 50):
		set_tint_progress(Color8(255,255,255,255))
	else:
		set_tint_progress(Color8(255,0,0,255))
