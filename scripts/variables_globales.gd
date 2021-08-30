extends Node2D

const clase_botin_aleatorio = preload("res://escenas/objetos/botin_aleatorio.tscn")
var ataque
var cristales 
var idioma
var llaves
var llaves_calabozo
var magia
var magia_max
var monedas
var texto_dialogo
var vida
var vida_max
onready var cuadro_mensaje = get_tree().get_current_scene().get_node("ui_principal/mensaje")

func _ready():
	ataque = 10
	cristales = 10
	idioma= 'es'
	llaves = 1
	llaves_calabozo = 0
	magia = 100
	magia_max = 100
	monedas = 0
	texto_dialogo = ''
	vida = 100;
	vida_max = 100

func mostrar_mensaje(texto):
	texto_dialogo = texto
	cuadro_mensaje.mostrar_mensaje()
	
func ocultar_mensaje():
	cuadro_mensaje.ocultar_mensaje()
	
func generar_botin(escena,pos,tipo):
	var botin = clase_botin_aleatorio.instance()
	botin.inicializar(escena,pos,tipo)
