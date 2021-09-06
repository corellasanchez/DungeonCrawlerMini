extends Node2D

var encendido = false
export(int, 'false', 'true') var mantenerPresionado

func _on_area_body_entered(body):
	cambiarEstado(body)

func _on_area_body_exited(body):
	cambiarEstado(body)
	
func cambiarEstado(body):
	if(body.is_in_group("personaje") || body.is_in_group("empujable")):
		if(mantenerPresionado):
			encendido = !encendido
			$textura.frame = encendido
		else:
			if(!encendido):
				encendido = true
				$textura.frame = 1
