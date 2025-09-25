extends Panel


@onready var boton_equipar = $Button/Button2
@onready var boton_mostrar_boton = $Button
@onready var label_nombre = $Label
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _on_button_2_pressed() -> void:
	Datos.equipar_objeto(get_meta("item_id"))

func _on_button_pressed() -> void:
	if get_meta("tipo") == "verdura":
		return
	label_nombre.visible = false
	boton_equipar.visible = true

func _on_button_focus_exited() -> void:
	await get_tree().create_timer(0.1).timeout
	label_nombre.visible = true
	boton_equipar.visible = false
	pass # Replace with function body.
