extends Node2D


var manejando_dano = false
onready var animacion = $animacion


# Botines disponibles
var botines = [
	{
		"nombre": "moneda_dorada",
		"valor": 10,
		"tipo": "monedas"
	}
	]

var tipos_botin:= RNGTools.WeightedBag.new()


# Called when the node enters the scene tree for the first time.
func _ready():
	randomize()
	botin_aleatorio()

	
func botin_aleatorio():
	tipos_botin.weights = {
	corazon = 4,
	moneda_dorada = 1,
	moneda_plateada = 4,
	moneda_roja = 1
	}
	var elemento = RNGTools.pick_weighted(tipos_botin)
	print(elemento);


func manejar_dano(_ataque_recibido, _pos_enemigo):
	
	remove_child($colision)
	manejando_dano = true
	animacion.play('explosion')
	manejando_dano = false


func _on_animacion_animation_finished():
	pass
	#self.queue_free()
	






#Equipar una espada de la lista
#func equipar(nombre: String):
#	for i in range(0,tiposDeEspada.size()):
#		if(tiposDeEspada[i].nombre == nombre):
#			espadaEquipada = tiposDeEspada[i]
#			texturaEspada.texture = tiposDeEspada[i].textura
#			texturaEspada.visible = true

