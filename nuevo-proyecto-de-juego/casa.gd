extends Node2D

@onready var contenedor_plataformas = $ContenedorPlataformas
@export var imagen_plataforma: CompressedTexture2D
@export var imagen_personaje: CompressedTexture2D
@onready var personaje = $personaje
@export var mision_1_completada_booleano: bool = false
@export var plataforma:PackedScene
@export var puertaVerde:PackedScene
@export var menutienda:PackedScene
@export var menumejoras:PackedScene
@export var menuconstruccion:PackedScene
@export var menupersonaje:PackedScene
@export var menucocina:PackedScene
@onready var ContenedorMenu = $CanvasLayer/ContenedorMenu
@onready var catelindicacion = $ScartelIndicacion
var pase = false

func _ready() -> void:
	if Datos.primeraMuerte == 1:
		catelindicacion.visible = true
		Datos.primeraMuerte = 2
	Datos.contenedor.set_visible(true)
	personaje.connect("movimiento", agregar_personaje_al_minimapa)#
	$personaje.global_position.x = 0
	$personaje.global_position.y = 0
	Datos.actualizar_todos_los_datos()#imprime los datos del nivel
	agregar_plataformas_al_minimapa()#

func agregar_personaje_al_minimapa():	
	for objeto in $pantallita/CanvasLayer/Control/ConPer.get_children():
		objeto.queue_free()
	agregar_al_minimapa(personaje, "personaje")


func agregar_plataformas_al_minimapa():
	await get_tree().create_timer(0.1).timeout
	for unaplataforma in contenedor_plataformas.get_children():
			unaplataforma.está_en_casa = true
			agregar_al_minimapa(unaplataforma, "plataforma")#esta funcion agrega la plataforma al minimapa
	for unaplataforma in Datos.contenedor.get_children():
			unaplataforma.está_en_casa = true
			agregar_al_minimapa(unaplataforma, "plataforma")#esta funcion agrega la plataforma al minimapa

			

func agregar_al_minimapa(loquesea, nombre):#recibe el objeto del nivel con la informacion para representarlo en el minimapa
	var objeto_del_minimapa = Sprite2D.new() #se crea un nodo para poder introducir los datos como la textura, escala, posición.
	objeto_del_minimapa.position.x = ((loquesea.position.x / 15000) * 150) +75
	objeto_del_minimapa.position.y = ((loquesea.position.y / 15000) * 150) +75
	if nombre == "plataforma":
		objeto_del_minimapa.texture = imagen_plataforma
		objeto_del_minimapa.scale.x = 0.015
		objeto_del_minimapa.scale.y = 0.015
		$pantallita/CanvasLayer/Control.add_child(objeto_del_minimapa)
	if nombre == "personaje":
		objeto_del_minimapa.texture = imagen_personaje
		objeto_del_minimapa.scale.x = 0.05
		objeto_del_minimapa.scale.y = 0.05
		$pantallita/CanvasLayer/Control/ConPer.add_child(objeto_del_minimapa)
