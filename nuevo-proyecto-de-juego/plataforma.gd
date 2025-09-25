extends StaticBody2D

var placing_plataforma = false
var está_en_casa = false
var lo_tengo = false
@export var inmobil = false


func _process(_delta):
	# 2. Si existe una plataforma en modo "colocación", sigue al puntero
	if placing_plataforma and not inmobil:
		get_tree().current_scene.personaje.move = false
		self.global_position = get_global_mouse_position()

func _input(event):
	# 3. Cuando das click, se fija en esa posición
	if lo_tengo and not inmobil:
		if self and event is InputEventMouseButton and event.pressed and event.button_index == MOUSE_BUTTON_LEFT:
			placing_plataforma = false
			get_tree().root.get_node("Nivel1").personaje.move = true
			await get_tree().create_timer(0.1).timeout
			lo_tengo = false
			Datos.nc = 0
			Datos.guardar_objeto()


func _on_input_event(_viewport: Node, event: InputEvent, _shape_idx: int) -> void:
	if not lo_tengo and not inmobil:
		if event is InputEventMouseButton and event.pressed and event.button_index == MOUSE_BUTTON_LEFT:
			if está_en_casa:
				if Datos.nc == 0:
					Datos.nc += 1
					print("click nc" + str(Datos.nc))
					lo_tengo = true
					placing_plataforma = true
					Datos.guardar_objeto()
