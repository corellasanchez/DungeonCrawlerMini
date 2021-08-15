extends Node2D

onready var animacion = $animacion
const clase_twig = preload("res://escenas/objetos/twig.tscn")

var escena
var posicion
var tipo

# Botines disponibles
var botines = [
	{
		"nombre": "moneda_dorada",
		"valor": 20,
		"tipo": "monedas"
	},
	{
		"nombre": "moneda_roja",
		"valor": 5,
		"tipo": "monedas"
	},
	{
		"nombre": "moneda_plateada",
		"valor": 1,
		"tipo": "monedas"
	},
	{
		"nombre": "corazon",
		"valor": 15,
		"tipo": "vida"
	},
	{
		"nombre": "nada",
		"valor": 0,
		"tipo": "nada"
	},
	{
		"nombre": "twig",
		"valor": 0,
		"tipo": "enemigo"
	}
	]
	
var botin_seleccionado;

var tipos_botin:= RNGTools.WeightedBag.new()

# Called when the node enters the scene tree for the first time.
func _ready():
	pass
	
func inicializar(e,p,t):
	escena = e
	posicion = p
	tipo = t
	if(tipo == "aleatorio"):
		botin_aleatorio()
	if(tipo == "arbusto"):
		botin_arbusto()
		
# Botin generico para enemigos
func botin_aleatorio():
	randomize()
	tipos_botin.weights = {
	corazon = 4,
	nada = 4,
	moneda_plateada = 4,
	moneda_dorada = 1,
	moneda_roja = 1
	}
	var botin = RNGTools.pick_weighted(tipos_botin)
	seleccionarBotin(botin)

func botin_arbusto():
	randomize()
	tipos_botin.weights = {
	twig = 5,
	nada = 5,
	corazon = 1,
	moneda_plateada = 1,
	moneda_dorada = 1,
	moneda_roja = 1
	}
	var botin = RNGTools.pick_weighted(tipos_botin)
	seleccionarBotin(botin)

func coleccionar():
	if(botin_seleccionado.tipo == 'vida'):
		Globales.vida += botin_seleccionado.valor
	if(botin_seleccionado.tipo == 'monedas'):
		Globales.monedas += botin_seleccionado.valor
	self.queue_free()
	

#Equipar una espada de la lista
func seleccionarBotin(nombre: String):
	for i in range(0,botines.size()):
		if(botines[i].nombre == nombre):
			botin_seleccionado = botines[i]
			if(botin_seleccionado.tipo == 'enemigo'):
				if(botin_seleccionado.nombre == 'twig'):
					var twig = clase_twig.instance()
					twig.global_position = posicion
					escena.add_child(twig)
			else:
				if(botin_seleccionado.tipo == 'nada'):
					self.queue_free()
				else:
					global_position = posicion
					escena.add_child(self)
					visible = true
					animacion.play(nombre)


func _on_area_coleccionable_body_entered(body):
	if(body.name == 'personaje'):
		coleccionar()
