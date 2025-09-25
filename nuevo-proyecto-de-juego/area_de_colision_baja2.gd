extends Area2D


func _on_body_entered(body) -> void:
	if body.name == "personaje":
		if !get_parent().pase:
			body.global_position.y = -5900
		else:
			Datos.position_x_personaje = body.global_position.x
			Datos.velocida_y_personaje = body.velocity.y
			Datos.nivel += 1
			get_tree().call_deferred("change_scene_to_file", "res://niveles.tscn")
