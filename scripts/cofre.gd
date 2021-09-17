extends Area2D

onready var cerradura = get_node("cerradura/CollisionShape2D")
onready var colision_cofre = get_node("CollisionShape2D")

export(String, "cofre_cerrado", "cofre_abierto","cofre_fino_cerrado", "cofre_fino_abierto", "barril_cerrado", "barril_abierto" ) var estadoActual = "cofre_cerrado"

onready var textura = get_node("textura")
export(String, "llave", "llave_calabozo") var botin = 'llave'

var estados = [
	{"nombre": "cofre_cerrado", "frame": 0},
	{"nombre": "cofre_abierto", "frame": 1},
	{"nombre": "cofre_fino_cerrado", "frame": 2},
	{"nombre": "cofre_fino_abierto", "frame": 3},
	{"nombre": "barril_cerrado", "frame": 4},
	{"nombre": "barril_abierto", "frame": 5},
]

func _ready():
	establecerEstado(estadoActual)
	
# El jugador toca la cofre
func _on_cofre_body_entered(_body):
	abrir_cofre()
	
func abrir_cofre():
	if(estadoActual != "cofre_abierto" && estadoActual != "cofre_fino_abierto" && estadoActual != "barril_abierto" ):
		if (estadoActual == "cofre_cerrado"):
			establecerEstado("cofre_abierto")
			
		if (estadoActual == "cofre_fino_cerrado"):
			establecerEstado("cofre_fino_abierto")
			
		if (estadoActual == "barril_cerrado"):
			establecerEstado("barril_abierto")
		
		recoger_tesoro()
	
func recoger_tesoro():
	$animacion.play("mostrar_tesoro")
	if(botin == 'llave'):
		$tesoro.frame = 0
		Globales.llaves +=1
	if(botin == 'llave_calabozo'):
		$tesoro.frame = 1
		Globales.llaves_calabozo += 1
	
# Establecer estado
func establecerEstado(nombre: String):
	for i in range(0,estados.size()):
		if(estados[i].nombre == nombre):
			estadoActual = estados[i].nombre
			textura.frame = estados[i].frame

func mostrarCofre(mostrar):
	visible = mostrar
	$cerradura/CollisionShape2D.disabled = !mostrar
	$CollisionShape2D.disabled = !mostrar
	
	
