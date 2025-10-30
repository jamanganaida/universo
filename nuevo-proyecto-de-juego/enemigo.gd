extends Area2D

var vida_maxima = 100
var vida = 100
var daño = 0

@warning_ignore("unused_signal")
signal enemigo_destruido

func descontar_vida(dañoVar):
	Datos.enemigo_combate = self
	Datos.mandar_info_del_enemigo()
	vida -= dañoVar
	if vida <= 0:
		emit_signal("enemigo_destruido")
		Datos.agregar_puntos(1)
		call_deferred("queue_free")
