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

func mostrar_mensaje():
	$mensaje.mostrar_mensaje()
	
func ocultar_mensaje():
	$mensaje.ocultar_mensaje()
	
func generar_botin(escena,pos):
	var botin = clase_botin_aleatorio.instance()
	botin.global_position = pos
	escena.add_child(botin)
