extends Area2D

@warning_ignore("unused_signal")
signal moneda_colectada

func _ready() -> void:
	$AnimationPlayer.play("movimiento")

func player_toca(body: CharacterBody2D) -> void:
	if body.name == "personaje":
		call_deferred("emit_signal", "moneda_colectada")
		Datos.sumar_monedas(1)
		call_deferred("queue_free")
