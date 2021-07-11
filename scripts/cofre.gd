extends Area2D

onready var cerradura = get_node("cerradura/CollisionShape2D")
onready var colision_cofre = get_node("CollisionShape2D")

export var estadoActual = "cofre_cerrado"
onready var textura = get_node("textura")

var estados = [
	{"nombre": "cofre_cerrado", "frame": 0},
	{"nombre": "cofre_abierto", "frame": 1},
	{"nombre": "cofre_fino_cerrado", "frame": 2},
	{"nombre": "cofre_fino_abierto", "frame": 3},
	{"nombre": "barril_cerrado", "frame": 4},
	{"nombre": "barril_abierto", "frame": 5},
]
var bag = RNGTools.WeightedBag.new()


func _ready():
	bag.weights = {
		A = 1,
		B = 2,
		C = 3
	}
	

# El jugador toca la cofre
func _on_cofre_body_entered(_body):
	print(RNGTools.pick_weighted(bag))
	abrir_cofre()
	
func abrir_cofre():
	
	if (estadoActual == "cofre_cerrado"):
		establecerEstado("cofre_abierto")
		return
	if (estadoActual == "cofre_fino_cerrado"):
		establecerEstado("cofre_abierto")
		return
	if (estadoActual == "barril_cerrado"):
		establecerEstado("cofre_abierto")
		return 
	
# Establecer estado
func establecerEstado(nombre: String):
	for i in range(0,estados.size()):
		if(estados[i].nombre == nombre):
			estadoActual = estados[i].nombre
			textura.frame = estados[i].frame
	
