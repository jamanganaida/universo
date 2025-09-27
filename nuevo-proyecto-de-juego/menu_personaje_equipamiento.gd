extends Panel


@onready var listaObjetos = $listaDeObjetos
@export var objetoContenedor : PackedScene
@onready var armacorta_imagen = $Panel2/Panel2/armaCorta/Tomate
@onready var armacorta_nombre = $Panel2/Panel2/armaCorta/ComprarEscoba
@onready var armalarga_imagen = $Panel2/Panel2/armaLarga/Tomate
@onready var armalarga_nombre = $Panel2/Panel2/armaLarga/VenderLiana22lr
@onready var consumible_imagen = $Panel2/Panel2/consumible/img
@onready var consumible_nombre = $Panel2/Panel2/consumible/consumible
@onready var informacionPersonaje_daño = $Panel2/Panel2/InformacionPersonaje/daño
@onready var informacionPersonaje_vida = $Panel2/Panel2/InformacionPersonaje/vida
@onready var informacionPersonaje_velocidad_atq = $"Panel2/Panel2/InformacionPersonaje/vel-atq"
@onready var informacionPersonaje_proteccion_atq = $Panel2/Panel2/InformacionPersonaje/proteccion_atq
@onready var informacionPersonaje_extra = $Panel2/Panel2/InformacionPersonaje/extras
var tipo = "todo"

var id_objeto_focus = 0

func _ready():
	Datos.objeto_equipado.connect(imprimir_segun_tipo)
	Datos.objeto_equipado.connect(actualizar_equipo)
	cargar_informacion()
	actualizar_equipo()
	imprimir_segun_tipo()



func actualizar_equipo():
	for objeto in Datos.objetos_equipados.keys():
		var data = Datos.objetos_equipados[objeto]
		if data.tipo == "arma-corta":
			armacorta_imagen.texture = data.imagen
			armacorta_nombre.text = data.nombre
		elif data.tipo == "arma-larga":
			armalarga_imagen.texture = data.imagen
			armalarga_nombre.text = data.nombre
		elif data.tipo == "consumible":
			consumible_imagen.texture = data.imagen
			consumible_nombre.text = data.nombre
	cargar_informacion()
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func imprimir_segun_tipo():
	for hijo in listaObjetos.get_children():
		hijo.queue_free()
	for data in Datos.objetos:
		if tipo == "verduras" and Datos.objetos[data].tipo == "verduras":
			imprimir_objeto(data)
		if tipo == "arma-larga" and Datos.objetos[data].tipo == "arma-larga":
			imprimir_objeto(data)
		if tipo == "arma-corta" and Datos.objetos[data].tipo == "arma-corta":
			imprimir_objeto(data)
		if tipo == "consumible":
			imprimir_objeto(data)
		if tipo == "todo":
			imprimir_objeto(data)
	listaObjetos.pagina = 0
	listaObjetos.ordenar_hijos(0)


func imprimir_objeto(data):
	if Datos.objetos[data].cantidad == 0:
		return
	var slot = objetoContenedor.instantiate()# Asignar imagen
	slot.get_node("Sprite2D").texture = Datos.objetos[data].imagen
	slot.get_node("Label").text = "%s x%d" % [Datos.objetos[data].nombre, Datos.objetos[data].cantidad]# Tooltip (como el atributo title en HTML)
	slot.tooltip_text = Datos.objetos[data].mensaje_tooltip# Guarda el id si lo necesitas
	slot.set_meta("item_id", Datos.objetos[data].id)
	slot.set_meta("tipo", Datos.objetos[data].tipo)
	listaObjetos.add_child(slot)


func _on_option_button_item_selected(index: int) -> void:
	if index == 0:
		tipo = "todo"
		imprimir_segun_tipo()
	if index == 1:
		tipo = "arma-corta"
		imprimir_segun_tipo()
	if index == 2:
		tipo = "arma-larga"
		imprimir_segun_tipo()
	if index == 3:
		tipo = "consumible"
		imprimir_segun_tipo()

func cargar_informacion():
	informacionPersonaje_vida.text = "Vida: " + str(Datos.vidaMaxima)
	informacionPersonaje_daño.text = "Daño: " + str(Datos.daño)
	informacionPersonaje_proteccion_atq.text = "Proteccion ATQ: " + str(Datos.proteccionATQ)
	informacionPersonaje_velocidad_atq.text = "Velocidad ATQ: " + str(Datos.velocidadDisparo)
	informacionPersonaje_extra.text = "Extras: " + str(Datos.extrasInfo)
