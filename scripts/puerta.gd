extends Area2D

onready var cerradura = get_node("cerradura/CollisionShape2D")
# clase interactuable
const claseInteractuable = preload("res://scripts/objetoInteractuable.gd")

export var estadoPorDefecto = "cerrada"
onready var textura = get_node("textura")

# instancia interactuable
var objetoInteractuable

var estados = [
	{"nombre": "cerrada", "frame": 0},
	{"nombre": "abierta", "frame": 2},
	{"nombre": "bloqueada", "frame": 1},
	{"nombre": "bloqueada-magicamente", "frame": 3},
]

func _ready():
	# textura, estados posibles, estado por defecto
	objetoInteractuable = claseInteractuable.new(textura,estados,estadoPorDefecto)
	if (estadoPorDefecto != "bloqueada" && objetoInteractuable.estadoActual != "bloqueada-magicamente"):
		cerradura.disabled = true
	else:
		cerradura.disabled = false

# El jugador toca la puerta
func _on_puerta_body_entered(body):
	if (objetoInteractuable.estadoActual != "bloqueada" && objetoInteractuable.estadoActual != "bloqueada-magicamente"):
		cerradura.disabled = true
		objetoInteractuable.establecerEstado("abierta")
	else:
		cerradura.disabled = false
	print(body.get_name())
