extends Node

class_name objetoInteractuable

var estadoActual
var textura

# Estados disponibles
var estados = []

# Abre el cuadro de dialogos de mensajes
signal mostrar_mensaje

# Constructor
func _init(nodoTextura, estadosDisponibles, estadoPorDefecto):
	textura = nodoTextura
	estados = estadosDisponibles
	establecerEstado(estadoPorDefecto)

# Establecer estado
func establecerEstado(nombre: String):
	for i in range(0,estados.size()):
		if(estados[i].nombre == nombre):
			estadoActual = estados[i].nombre
			textura.frame = estados[i].frame

#
func enviar_mensaje(mensaje):
	 emit_signal("mostrar_mensaje", mensaje)
