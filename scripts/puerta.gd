extends Area2D

onready var cerradura = get_node("cerradura/CollisionShape2D")
# clase interactuable
const claseInteractuable = preload("res://scripts/objetoInteractuable.gd")

export var estadoPorDefecto = "cerrada"
onready var textura = get_node("textura")
signal mostrarMensaje(mensaje)
signal ocultarMensaje

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
func _on_puerta_body_entered(body):
	if (objetoInteractuable.estadoActual != "puerta_bloqueada" && objetoInteractuable.estadoActual != "puerta_bloqueada_magicamente"):
		cerradura.disabled = true
		objetoInteractuable.establecerEstado("abierta")
	else:
		if (objetoInteractuable.estadoActual == "puerta_bloqueada"):
			emit_signal("mostrarMensaje", "puerta_bloqueada")
		
		if (objetoInteractuable.estadoActual == "puerta_bloqueada_magicamente"):
			emit_signal("mostrarMensaje", "puerta_bloqueada_magicamente")
	
	print(body.get_name())


func _on_puerta_body_exited(_body):
	if (objetoInteractuable.estadoActual == "puerta_bloqueada" || objetoInteractuable.estadoActual == "puerta_bloqueada_magicamente"):
		emit_signal("ocultarMensaje")

