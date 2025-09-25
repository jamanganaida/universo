extends Node2D

@onready var contenedor_monedas = $ContenedorMonedas
@onready var contenedor_enemigos = $Contenedor_enemigos
@onready var contenedor_plataformas = $ContenedorPlataformas
@export var imagen_plataforma: CompressedTexture2D
@export var imagen_moneda: CompressedTexture2D
@export var imagen_enemigo: CompressedTexture2D
@export var imagen_personaje: CompressedTexture2D
@onready var personaje = $personaje
@export var mision_1_completada_booleano: bool = false
@export var enemigo :PackedScene
@export var enemigoDisparador:PackedScene
@export var enemigoDisparadorPersigue:PackedScene
@export var moneda:PackedScene
@export var plataforma:PackedScene
@export var puertaVerde:PackedScene
@export var cofre:PackedScene

var pase = false
var CantidadDemonedas = 0
var CantidadEnemigos = 0
var nivel = 1

func _ready() -> void:#
	Datos.contenedor.set_visible(false)
	var lista = {}
	nivel = Datos.nivel
	var cantidad_monedas = randi_range(20, 50)
	lista["monedas_n"] = cantidad_monedas
	var cantidad_plataformas = randi_range(15, 50)
	lista["plataformas_n"] = cantidad_plataformas
	var cantidad_enemigos
	if nivel <=5:
		cantidad_enemigos = randi_range(5, 5+nivel)
	elif nivel >5 and nivel <=15:
		cantidad_enemigos = randi_range(10, 10+nivel)
	elif nivel >15 and nivel <=35:
		cantidad_enemigos = randi_range(25, 25+nivel)
	elif nivel >35 and nivel <=65:
		cantidad_enemigos = randi_range(60, 60+nivel)
	elif nivel >65 and nivel <=105:
		cantidad_enemigos = randi_range(125, 125+nivel)
	elif nivel >105 and nivel <=155:
		cantidad_enemigos = randi_range(230, 230+nivel)
	if cantidad_enemigos == 0:
		mision_1_completada_booleano = true
		comprobar()
	lista["enemigos_n"] = cantidad_enemigos
	generar_nivel(lista)
	personaje.connect("movimiento", agregar_personaje_al_minimapa)#
	$personaje.global_position.x = Datos.position_x_personaje
	Datos.actualizar_todos_los_datos()#imprime los datos del nivel
	agregar_plataformas_al_minimapa()#
	agregar_moneda_al_minimapa()
	agregar_enemigo_al_minimapa()
	for monedasen in contenedor_monedas.get_children():
		#contamos todos los enemigos. conectamos para recibir la señal de destruccion para descontar del total.
		CantidadDemonedas += 1
		monedasen.connect('moneda_colectada', _on_moneda_colectada)
	for enemigoEn in contenedor_enemigos.get_children():
		#contamos todos los enemigos. conectamos para recibir la señal de destruccion para descontar del total.
		CantidadEnemigos += 1
		enemigoEn.connect('enemigo_destruido', _on_enemigo_destruido)
		actualizar_datos()
		Datos.controlador_de_niveles(nivel)
	comprobar()

func actualizar_datos():
	Datos.cantidad_de_enemigos = CantidadEnemigos
	Datos.cantidad_de_monedas = CantidadDemonedas

func generar_nivel(lista):
	var contador = 0
	var pongoPuertaVerde = false
	var numRandom = randi_range(0, 4)
	var contadorCofres = 0
	var numRandomCofres = randi_range(0, 4)
	if numRandom == 2:
		pongoPuertaVerde = true
	# objetos_a_generar ejemplo:
	# {"moneda": 10, "enemigo": 3, "plataforma": 5}
	for i in range(lista["plataformas_n"]):
		var pos = randomNumer()
		if contador > 1:
			if contadorCofres < numRandomCofres:
				contadorCofres += 1
				_instanciar_objeto("cofre", pos)
		contador += 1
		if pongoPuertaVerde:
			_instanciar_objeto("puertaVerde", pos)
			pongoPuertaVerde = false
		_instanciar_objeto("plataforma", pos)

	for i in range(lista["monedas_n"]):
		var pos = randomNumer()
		_instanciar_objeto("moneda", pos)

	for i in range(lista["enemigos_n"]):
		var pos = randomNumer()
		_instanciar_objeto("enemigo", pos)

func randomNumer():
	var posx = randi_range(-5000, 5000)
	var posy = randi_range(-5000, 5000)
	var pos = Vector2(posx,posy)
	return pos

func _instanciar_objeto(tipo:String, posicion:Vector2):
	if tipo == "plataforma":
		var objeto = plataforma.instantiate()
		objeto.global_position = posicion
		contenedor_plataformas.add_child(objeto)
	if tipo == "moneda":
		var objeto = moneda.instantiate()
		objeto.global_position = posicion
		contenedor_monedas.add_child(objeto)
	if tipo == "enemigo":
		var random = randi_range(0,1)
		var objeto
		if random:
			objeto = enemigo.instantiate()
		else:
			objeto = enemigoDisparador.instantiate()
			objeto.target = personaje
		objeto.global_position = posicion
		objeto.daño += roundi((2*nivel) * 0.3)
		objeto.vida += 10*nivel
		contenedor_enemigos.add_child(objeto)
	if tipo == "puertaVerde":
		var objeto = puertaVerde.instantiate()
		objeto.global_position = posicion
		contenedor_plataformas.add_child(objeto)
	if tipo == "cofre":
		var objeto = cofre.instantiate()
		objeto.tipoDeCofre = "oro"
		objeto.cantidadRecompensa = 19*nivel 
		objeto.global_position = posicion
		contenedor_plataformas.add_child(objeto)


func agregar_personaje_al_minimapa():	
	for objeto in $pantallita/CanvasLayer/Control/ConPer.get_children():
		objeto.queue_free()
	agregar_al_minimapa(personaje, "personaje")

func agregar_moneda_al_minimapa():	
	await get_tree().create_timer(0.1).timeout
	for objeto in $pantallita/CanvasLayer/Control/ConMon.get_children():
		objeto.call_deferred("queue_free")
	for monedas in contenedor_monedas.get_children():
		call_deferred("agregar_al_minimapa", monedas, "monedas")

func agregar_enemigo_al_minimapa():	
	await get_tree().create_timer(0.1).timeout
	for objeto in $pantallita/CanvasLayer/Control/ConEne.get_children():
		objeto.call_deferred("queue_free")
	for enemigoen in contenedor_enemigos.get_children():
		call_deferred("agregar_al_minimapa", enemigoen, "enemigo")


func agregar_plataformas_al_minimapa():
	await get_tree().create_timer(0.1).timeout
	for plataformaen in contenedor_plataformas.get_children():
			agregar_al_minimapa(plataformaen, "plataforma")#esta funcion agrega la plataforma al minimapa

func agregar_al_minimapa(loquesea, nombre):#recibe el objeto del nivel con la informacion para representarlo en el minimapa
	var objeto_del_minimapa = Sprite2D.new() #se crea un nodo para poder introducir los datos como la textura, escala, posición.
	objeto_del_minimapa.position.x = ((loquesea.position.x / 16000) * 150) +75
	objeto_del_minimapa.position.y = ((loquesea.position.y / 16000) * 150) +75
	if nombre == "monedas":
		objeto_del_minimapa.texture = imagen_moneda
		objeto_del_minimapa.scale.x = 0.5
		objeto_del_minimapa.scale.y = 0.5
		$pantallita/CanvasLayer/Control/ConMon.add_child(objeto_del_minimapa)
	if nombre == "enemigo":
		objeto_del_minimapa.texture = imagen_enemigo
		objeto_del_minimapa.scale.x = 0.2
		objeto_del_minimapa.scale.y = 0.2
		$pantallita/CanvasLayer/Control/ConEne.add_child(objeto_del_minimapa)
	if nombre == "plataforma":
		objeto_del_minimapa.texture = imagen_plataforma
		objeto_del_minimapa.scale.x = 0.8
		objeto_del_minimapa.scale.y = 0.6
		$pantallita/CanvasLayer/Control.add_child(objeto_del_minimapa)
	if nombre == "personaje":
		objeto_del_minimapa.texture = imagen_personaje
		objeto_del_minimapa.scale.x = 0.2
		objeto_del_minimapa.scale.y = 0.2
		$pantallita/CanvasLayer/Control/ConPer.add_child(objeto_del_minimapa)

func _on_moneda_colectada():
	agregar_moneda_al_minimapa()
	CantidadDemonedas -= 1
	actualizar_datos()
	Datos.controlador_de_niveles(nivel)

func _on_enemigo_destruido():
	agregar_enemigo_al_minimapa()
	CantidadEnemigos -= 1
	actualizar_datos()
	Datos.controlador_de_niveles(nivel)
	if CantidadEnemigos <= 0:
		mision_1_completada_booleano = true
		comprobar()

func comprobar():
	if mision_1_completada_booleano:
		pase = true
		Datos.nivel_progreso = nivel + 1
		Datos.controlador_de_niveles(nivel)#Actualiza mision
