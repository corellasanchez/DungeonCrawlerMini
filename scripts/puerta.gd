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
	{"nombre": "bloqueada", "frame": 1}
]

# Called when the node enters the scene tree for the first time.
func _ready():
	objetoInteractuable = claseInteractuable.new(textura,estados,estadoPorDefecto)
	if (estadoPorDefecto != "bloqueada" ):
		cerradura.disabled = true
	else:
		cerradura.disabled = false
	
func _on_puerta_body_entered(body):
	if (objetoInteractuable.estadoActual != "bloqueada" ):
		cerradura.disabled = true
		objetoInteractuable.establecerEstado("abierta")
	else:
		cerradura.disabled = false
	print(body.get_name())
