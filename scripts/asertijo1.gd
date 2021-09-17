extends Node2D

var acertijoResuelto = false
var verificandoAntorchas = false
var cajaTLpos = Vector2()
var cajaTRpos = Vector2()
var cajaBLpos = Vector2()


func _ready():
	cajaTLpos = $cajaTL.global_position
	cajaTRpos = $cajaTR.global_position
	cajaBLpos = $cajaBL.global_position
	
func _process(_delta):
	if (!verificandoAntorchas && !acertijoResuelto):
		verificarAntorchas()
	
func verificarAntorcha(antorcha, boton):
	if(antorcha.estado == 'apagada' && boton.encendido):
		antorcha.establecerEstado('encendida')
	if(antorcha.estado == 'encendida' && !boton.encendido):
		antorcha.establecerEstado('apagada')

func verificarAntorchas():
	verificandoAntorchas = true
	verificarAntorcha($antorcha_piedraTL,$botonTL)
	verificarAntorcha($antorcha_piedraTR,$botonTR)
	verificarAntorcha($antorcha_piedraBL,$botonBL)
	verificarAntorcha($antorcha_piedraBR,$botonBR)
	acertijoResuelto = verificarAcertijo($antorcha_piedraTL,$antorcha_piedraTR, $antorcha_piedraBL,$antorcha_piedraBR)
	print(acertijoResuelto);
	if($botonReset.encendido):
		resetearCajas()
	yield(get_tree().create_timer(0.3), "timeout")
	verificandoAntorchas = false
	
func verificarAcertijo(a1,a2,a3,a4):
	return a1.estado == 'encendida' && a2.estado == 'encendida' && a3.estado == 'encendida' && a4.estado == 'encendida'

func resetearCajas():
	$cajaTL.global_position = cajaTLpos 
	$cajaTR.global_position = cajaTRpos  
	$cajaBL.global_position = cajaBLpos
	
	
	
