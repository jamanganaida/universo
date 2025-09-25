extends Area2D

var tipoDeCofre = ""
var cantidadRecompensa = 0


func _on_body_entered(body: Node2D) -> void:
	if body.name == "personaje":
		Datos.controladorCofre(tipoDeCofre, cantidadRecompensa)
	call_deferred("queue_free")
