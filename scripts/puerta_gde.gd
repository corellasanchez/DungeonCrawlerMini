extends Area2D

onready var cerradura = get_node("cerradura/CollisionShape2D")
onready var colision_puerta = get_node("CollisionShape2D")

export(String, "puerta_bloqueada", "cerrada", "abierta") var estadoActual = 'puerta_bloqueada'

onready var textura = get_node("textura")

var estados = [
	{"nombre": "cerrada", "frame": 0},
	{"nombre": "abierta", "frame": 2},
	{"nombre": "puerta_bloqueada", "frame": 1}
]

func _ready():
	if (estadoActual != "puerta_bloqueada"):
		cerradura.disabled = true
	else:
		cerradura.disabled = false

func abrir_puerta():
	cerradura.set_deferred("disabled", true)
	colision_puerta.set_deferred("disabled", true)
	establecerEstado("abierta")
	
# El jugador toca la puerta
func _on_puerta_gde_body_entered(_body):
	if (estadoActual != "puerta_bloqueada"):
		abrir_puerta()
	else:
		if (estadoActual == "puerta_bloqueada"):
			if(Globales.llaves_calabozo > 0):
				Globales.llaves_calabozo -= 1
				abrir_puerta()
			else:
				Globales.mostrar_mensaje("puerta_calaboso_bloqueada")
				
# Establecer estado
func establecerEstado(nombre: String):
	for i in range(0,estados.size()):
		if(estados[i].nombre == nombre):
			estadoActual = estados[i].nombre
			textura.frame = estados[i].frame


func _on_puerta_gde_body_exited(_body):
	if (estadoActual == "puerta_bloqueada"):
		Globales.ocultar_mensaje()
