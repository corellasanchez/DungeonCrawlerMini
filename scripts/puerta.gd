extends Area2D

onready var cerradura = get_node("cerradura/CollisionShape2D")
onready var colision_puerta = get_node("CollisionShape2D")

# clase interactuable
var claseInteractuable = preload("res://scripts/objetoInteractuable.gd")

export(String, "puerta_bloqueada", "cerrada", "abierta", "puerta_bloqueada_magicamente") var estadoPorDefecto = 'puerta_bloqueada'

onready var textura = get_node("textura")

# instancia interactuable
var objetoInteractuable

var estados = [
	{"nombre": "cerrada", "frame": 0},
	{"nombre": "abierta", "frame": 2},
	{"nombre": "puerta_bloqueada", "frame": 1},
	{"nombre": "puerta_bloqueada_magicamente", "frame": 3},
]

func _ready():
	# textura, estados posibles, estado por defecto
	objetoInteractuable = claseInteractuable.new(textura,estados,estadoPorDefecto)
	if (estadoPorDefecto != "puerta_bloqueada" && objetoInteractuable.estadoActual != "puerta_bloqueada_magicamente"):
		cerradura.disabled = true
	else:
		cerradura.disabled = false

# El jugador toca la puerta
func _on_puerta_body_entered(_body):
	if (objetoInteractuable.estadoActual != "puerta_bloqueada" && objetoInteractuable.estadoActual != "puerta_bloqueada_magicamente"):
		abrir_puerta()
	else:
		if (objetoInteractuable.estadoActual == "puerta_bloqueada"):
			if(Globales.llaves > 0):
				Globales.llaves -= 1
				abrir_puerta()
			else:
				Globales.mostrar_mensaje("puerta_bloqueada")
		if (objetoInteractuable.estadoActual == "puerta_bloqueada_magicamente"):
			Globales.mostrar_mensaje("puerta_bloqueada_magicamente")

func _on_puerta_body_exited(_body):
	if (objetoInteractuable.estadoActual == "puerta_bloqueada" || objetoInteractuable.estadoActual == "puerta_bloqueada_magicamente"):
		Globales.ocultar_mensaje()

func abrir_puerta():
	cerradura.set_deferred("disabled", true)
	colision_puerta.set_deferred("disabled", true)
	objetoInteractuable.establecerEstado("abierta")
	
