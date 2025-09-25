extends Area2D


var vida = 100
var daño = 0

@warning_ignore("unused_signal")
signal enemigo_destruido

func descontar_vida(dañoVar):
	vida -= dañoVar
	if vida <= 0:
		emit_signal("enemigo_destruido")
		Datos.agregar_puntos(1)
		call_deferred("queue_free")
