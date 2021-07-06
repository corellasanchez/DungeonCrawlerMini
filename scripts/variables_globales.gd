extends Node2D

var idioma 
var vida
var vida_max
var magia
var magia_max
var llaves 
var llaves_calabozo
var texto_dialogo

func _ready():
	idioma= 'es' 
	vida = 100;
	vida_max = 100
	magia = 100
	magia_max = 100
	llaves = 0 
	llaves_calabozo = 0
	texto_dialogo = ''

func mostrar_mensaje():
	$mensaje.mostrar_mensaje()
	
func ocultar_mensaje():
	$mensaje.ocultar_mensaje()
