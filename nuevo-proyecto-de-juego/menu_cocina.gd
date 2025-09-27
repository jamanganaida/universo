extends Panel

@onready var cantidadTomate = $Panel2/Panel/Panel/tomate
@onready var cantidadBrocoli = $Panel2/Panel/Panel2/brocoli
@onready var cantidadCebolla = $Panel2/Panel/Panel3/cebolla
@onready var cantidadMaiz = $Panel2/Panel/Panel4/maiz
@onready var cantidadZanahoria = $Panel2/Panel/Panel6/zanahoria
@onready var cantidadPimiento = $Panel2/Panel/Panel5/pimiento

@onready var seleccionadoNombre = $Panel3/Nombre
@onready var seleccionadoIngredientes = $Panel3/Ingredientes
@onready var seleccionadoEfecto = $Panel3/Efecto
@onready var seleccionadoImagen = $Panel/Imagen
@onready var botonCrear = $Button

var obj_seleccionado = "ninguno"
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	imprimir_cantidad_verduras()
	pass # Replace with function body.

func imprimir_cantidad_verduras():
	if Datos.objetos.has("Tomate"):
		cantidadTomate.text = str(Datos.objetos["Tomate"].cantidad)
	if Datos.objetos.has("Brocoli"):
		cantidadBrocoli.text = str(Datos.objetos["Brocoli"].cantidad)
	if Datos.objetos.has("Cebolla"):
		cantidadCebolla.text = str(Datos.objetos["Cebolla"].cantidad)
	if Datos.objetos.has("Pimiento"):
		cantidadPimiento.text = str(Datos.objetos["Pimiento"].cantidad)
	if Datos.objetos.has("Zanahoria"):
		cantidadZanahoria.text = str(Datos.objetos["Zanahoria"].cantidad)
	if Datos.objetos.has("Maíz"):
		cantidadMaiz.text = str(Datos.objetos["Maíz"].cantidad)

func imprimir_datos_consumible(nombre):
	verificar_boton_disabled(nombre)
	if Datos.objetos.has(nombre):
		obj_seleccionado = nombre
		seleccionadoNombre.text = Datos.objetos[nombre].nombre
		seleccionadoImagen.texture = Datos.objetos[nombre].imagen
		seleccionadoIngredientes.text = "Ingredientes: "
		for ingr in Datos.objetos[nombre]["ingredientes"]:
			seleccionadoIngredientes.text += Datos.objetos[nombre]["ingredientes"][ingr].nombre + ":" + str(Datos.objetos[nombre]["ingredientes"][ingr].cantidad)
			seleccionadoIngredientes.text += ".  "

func verificar_boton_disabled(nombre):
	for ingr in Datos.objetos[nombre]["ingredientes"]:
			var nombreVerdura = Datos.objetos[nombre]["ingredientes"][ingr].nombre
			if Datos.objetos[nombre]["ingredientes"][ingr].cantidad > Datos.objetos[nombreVerdura].cantidad:
				botonCrear.disabled = true
				break
				return
			else:
				botonCrear.disabled = false
				

func _on_panel_3_gui_input(event: InputEvent) -> void:
	if event is InputEventMouseButton and event.pressed and event.button_index == MOUSE_BUTTON_LEFT:
		imprimir_datos_consumible("Jugo De Tomate")


func _on_panel_4_gui_input(event: InputEvent) -> void:
	if event is InputEventMouseButton and event.pressed and event.button_index == MOUSE_BUTTON_LEFT:
		imprimir_datos_consumible("Jugo De Brocoli")


func _on_panel_5_gui_input(event: InputEvent) -> void:
	if event is InputEventMouseButton and event.pressed and event.button_index == MOUSE_BUTTON_LEFT:
		imprimir_datos_consumible("Sopa De Tomate")


func _on_panel_6_gui_input(event: InputEvent) -> void:
	if event is InputEventMouseButton and event.pressed and event.button_index == MOUSE_BUTTON_LEFT:
		imprimir_datos_consumible("Sopa De Zanahoria")


func _on_panel_7_gui_input(event: InputEvent) -> void:
	if event is InputEventMouseButton and event.pressed and event.button_index == MOUSE_BUTTON_LEFT:
		imprimir_datos_consumible("Ensalada Mixta")


func _on_panel_8_gui_input(event: InputEvent) -> void:
	if event is InputEventMouseButton and event.pressed and event.button_index == MOUSE_BUTTON_LEFT:
		imprimir_datos_consumible("Guiso")


func _on_button_pressed() -> void:
	for ingr in Datos.objetos[obj_seleccionado]["ingredientes"]:
			var nombreVerdura = Datos.objetos[obj_seleccionado]["ingredientes"][ingr].nombre
			if Datos.objetos[nombreVerdura].cantidad >= Datos.objetos[obj_seleccionado]["ingredientes"][ingr].cantidad:
				Datos.objetos[nombreVerdura].cantidad -= Datos.objetos[obj_seleccionado]["ingredientes"][ingr].cantidad
				Datos.objetos[obj_seleccionado].cantidad += 1
	imprimir_cantidad_verduras()
	verificar_boton_disabled(obj_seleccionado)
