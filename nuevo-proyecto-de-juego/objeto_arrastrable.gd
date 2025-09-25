extends Panel

var lo_tengo = false
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if lo_tengo:
		self.global_position = get_global_mouse_position()
	pass


func _on_button_pressed() -> void:
	lo_tengo =  true
