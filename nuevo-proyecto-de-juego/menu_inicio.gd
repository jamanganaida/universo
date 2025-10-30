extends Control



func _on_button_pressed() -> void:
	get_tree().call_deferred("change_scene_to_file", "res://menu_información.tscn")


func _on_start_pressed() -> void:
	get_tree().call_deferred("change_scene_to_file", "res://niveles.tscn")


func _on_salir_pressed() -> void:
	get_tree().quit()
