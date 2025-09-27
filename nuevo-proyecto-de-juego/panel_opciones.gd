extends VBoxContainer

var funcion = "nada"
@onready var boton1 = $Button
@onready var boton2 = $Button2
@onready var boton3 = $Button3
@onready var boton8 = $Button8
var padre
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	padre = get_tree().current_scene


func _on_button_pressed() -> void:
	if Datos.menumejorasvisible == true:
		vacie_todo_menu()
		Datos.menumejorasvisible = false
	else:
		vacie_todo_menu()
		var menu = padre.menumejoras.instantiate()
		padre.ContenedorMenu.add_child(menu)
		Datos.menumejorasvisible = true

func _on_button_2_pressed() -> void:
	if Datos.menuconstruccionvisible == true:
		vacie_todo_menu()
		Datos.menuconstruccionvisible = false
	else:
		vacie_todo_menu()
		var menu = padre.menuconstruccion.instantiate()
		padre.ContenedorMenu.add_child(menu)
		Datos.menuconstruccionvisible = true
	

func _on_button_8_pressed() -> void:
	if Datos.menutiendavisible == true:
		vacie_todo_menu()
		Datos.menutiendavisible = false
	else:
		vacie_todo_menu()
		var menu = padre.menutienda.instantiate()
		padre.ContenedorMenu.add_child(menu)
		Datos.menutiendavisible = true


func _on_button_3_pressed() -> void:
	if Datos.menupersonajevisible == true:
		vacie_todo_menu()
		Datos.menupersonajevisible = false
	else:
		vacie_todo_menu()
		var menu = padre.menupersonaje.instantiate()
		padre.ContenedorMenu.add_child(menu)
		Datos.menupersonajevisible = true



func vacie_todo_menu():
	Datos.menutiendavisible = false
	Datos.menumejorasvisible = false
	Datos.menuconstruccionvisible = false
	Datos.menupersonajevisible = false
	Datos.menucocina = false
	for child in padre.ContenedorMenu.get_children():
		child.queue_free()


func _on_button_9_pressed() -> void:
	if Datos.menucocina== true:
		vacie_todo_menu()
		Datos.menucocina = false
	else:
		vacie_todo_menu()
		var menu = padre.menucocina.instantiate()
		padre.ContenedorMenu.add_child(menu)
		Datos.menucocina = true
