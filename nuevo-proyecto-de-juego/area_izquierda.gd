extends Area2D


func _on_body_entered(body) -> void:
	if body.name == "personaje":
		body.global_position.x = 5900
