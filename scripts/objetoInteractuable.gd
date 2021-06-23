extends Node

class_name objetoInteractuable

var estadoActual
var textura

# Estados disponibles
var estados = []

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
