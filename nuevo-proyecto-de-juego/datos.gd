extends Node

#personaje
var vida = 100
var daño = 0
var daño_corto = 0
var vidaMaxima = 100
var vida_equipamiento = 0
var vida_extra = 0
var daño_mejora = 0
var position_x_personaje = 0
var velocida_y_personaje = 0
var velocidadDisparo = 1
var velocidadDisparo_mejora = 0
var velocidadDisparo_extra = 0
var proteccionATQ = 1
var protexionATQ_mejora = 0
var proteccionATQ_extra = 0
var extrasInfo = "nada"
var primeraMuerte = 0
var experiencia = 0
var experiencia_en_combate = 0
var muertes = 0
var enemigos_derrotados = 0
#juego
var contenedor : Node2D
var cultivos = 0
var vida_plataforma_curativa = 10
var puntos = 0
var monedas = 10000
var nc = 0
var objetos = {}
var objetos_equipados = {}
var objetos_cocina = {}
var id_objeto = 0
#nivel
var cantidad_de_enemigos = 0
var cantidad_de_monedas = 0
var nivel_progreso = 1
var nivel = 1
#tienda
var costoMejoraVida = 100
var costoMejoraDaño = 100
var costoMejoraPlataformaCurativa = 100
var costoMejoraVelocidadDisparo = 100
#control menus
var menutiendavisible = false
var menumejorasvisible = false
var menuconstruccionvisible = false
var menupersonajevisible = false
var menucocina = false


#señales
@warning_ignore("unused_signal")
signal vida_cambiada(valor)
@warning_ignore("unused_signal")
signal puntos_cambiados(valor)
@warning_ignore("unused_signal")
signal monedas_cambiadas(valor)
@warning_ignore("unused_signal")
signal informacion_del_nivel_cambiado(valor)
signal cultivo_cambiado()
signal plataforma_colocada()
signal objeto_equipado()

#imagenes
var imgCultivoTomate = preload("res://plataformaTomate.png") as CompressedTexture2D
var imgCultivoBrocoli = preload("res://plataformaBrocoli.png") as CompressedTexture2D
var imgCultivoMaiz = preload("res://plataformaMaiz.png") as CompressedTexture2D
var imgCultivoZanahria = preload("res://plataformaZanahoria.png") as CompressedTexture2D
var imgCultivoCebolla = preload("res://plataformaCebolla.png") as CompressedTexture2D
var imgCultivoPimiento = preload("res://plataformaPimiento.png") as CompressedTexture2D
var imgTomate = preload("res://tomate.png") as CompressedTexture2D
var imgZanahoria = preload("res://zanahoria.png") as CompressedTexture2D
var imgMaiz = preload("res://maiz.png") as CompressedTexture2D
var imgCebolla = preload("res://cebolla.png") as CompressedTexture2D
var imgBrocoli =  preload("res://brocoli.png") as CompressedTexture2D
var imgPimiento =  preload("res://pimiento.png") as CompressedTexture2D
var imgJugoTomate = preload("res://sopa_ 1_jugo_tomate.png") as CompressedTexture2D
var imgSopaZanahoria = preload("res://sopa_ 4_zanahoria_con_brocoli.png") as CompressedTexture2D
var imgEnsaladaMixta = preload("res://sopa_5_ensalada.png") as CompressedTexture2D
var imgJugoBrocoli = preload("res://sopa_ 2_jugo_brocoli.png") as CompressedTexture2D
var imgSopaTomate =  preload("res://sopa_ 3_tomate_con_brocoli.png") as CompressedTexture2D
var imgGuiso =  preload("res://sopa_ 6_guiso.png") as CompressedTexture2D

func _ready():
	crear_guardar_objeto("Rama", "Rama +1 daño", 1, preload("res://arma_base.png") as CompressedTexture2D, "arma-corta", "atributo", "ninguna")
	equipar_objeto(1)
	crear_guardar_objeto("Tomate", "Tomate", 0, imgTomate, "verdura", "ninguno", "ninguno")
	crear_guardar_objeto("Zanahoria", "Zanahoria", 0,  imgZanahoria, "verdura", "ninguno", "ninguno")
	crear_guardar_objeto("Maíz", "Maíz", 0,  imgMaiz, "verdura", "ninguno" ,"ninguno" )
	crear_guardar_objeto("Cebolla", "Cebolla", 0,  imgCebolla, "verdura", "ninguno", "ninguno" )
	crear_guardar_objeto("Brocoli", "Brocoli", 0, imgBrocoli, "verdura", "ninguno", "ninguno" )
	crear_guardar_objeto("Pimiento", "Pimiento", 0, imgPimiento, "verdura", "ninguno", "ninguno" )
	var atributos_juegodetoamte = {"vida_recuperacion": 10}
	var ingredientes_juegodetoamte = {"Tomate": {"nombre": "Tomate", "cantidad": 1}}
	crear_guardar_objeto("Jugo De Tomate", "Juego de tomate", 0, imgJugoTomate, "consumible", atributos_juegodetoamte, ingredientes_juegodetoamte)
	var atributos_juegodebrocolis = {"vida_equipamiento": 10}
	var ingredientes_juegodebrocolis = {"Brocoli":{"nombre": "Brocoli", "cantidad": 1}}
	crear_guardar_objeto("Jugo De Brocoli", "Jugo de brocoli", 0,  imgJugoBrocoli, "consumible", atributos_juegodebrocolis, ingredientes_juegodebrocolis)
	var atributos_ensaladamixta = {"vida_equipamiento": 100, "daño_equipamiento": 30}
	var ingredientes_ensaladamixta = {"Brocoli":{"nombre": "Brocoli", "cantidad": 1}, "Maíz": {"nombre": "Maíz", "cantidad": 1}, "Zanahoria":{"nombre": "Zanahoria", "cantidad": 1}}
	crear_guardar_objeto("Ensalada Mixta", "Ensalada Mixta", 0,  imgEnsaladaMixta, "consumible", atributos_ensaladamixta, ingredientes_ensaladamixta)
	var atributos_guiso = {"defensa": 20, "vida_recuperacion": 100, "velocidadDisparo": 2}
	var ingredientes_guiso = {"Cebolla":{"nombre": "Cebolla", "cantidad": 1}, "Tomate": {"nombre": "Tomate", "cantidad": 1}, "Zanahoria": {"nombre": "Zanahoria", "cantidad": 1}, "Pimiento": {"nombre": "Pimiento", "cantidad": 1}}
	crear_guardar_objeto("Guiso", "Guiso", 0,  imgGuiso, "consumible", atributos_guiso, ingredientes_guiso)
	var atributos_sopadetomate = {"vida_recuperacion": 20}
	var ingredientes_sopadetomate = {"Brocoli": {"nombre": "Brocoli", "cantidad": 1},"Tomate":{"nombre": "Tomate", "cantidad" : 1}}
	crear_guardar_objeto("Sopa De Tomate", "Sopa de tomate", 0, imgSopaTomate, "consumible", atributos_sopadetomate, ingredientes_sopadetomate)
	var atributos_sopadezanahoria = {"vida_equipamiento": 100}
	var ingredientes_sopadezanahoria = {"Brocoli": {"nombre": "Brocoli", "cantidad": 1}, "Zanahoria":{"nombre": "Zanahoria", "cantidad": 1}}
	crear_guardar_objeto("Sopa De Zanahoria", "Sopa de Zanahoria", 0, imgSopaZanahoria, "consumible", atributos_sopadezanahoria, ingredientes_sopadezanahoria)
	contenedor = Node2D.new()
	add_child(contenedor)
	
func set_vida(valor):
	vida += valor
	emit_signal("vida_cambiada", vida)

func set_viadaMaxima(valor):
	vidaMaxima += valor
	emit_signal("vida_cambiada", vida)

func actualizar_verduras_mnedas():
	emit_signal("cultivo_cambiado")
	emit_signal("monedas_cambiadas", monedas)
	
func agregar_puntos(valor):
	puntos += valor
	emit_signal("puntos_cambiados", puntos)

func restart():
	vida = 100
	emit_signal("vida_cambiada", vida)
	monedas = 0
	emit_signal("monedas_cambiadas", monedas)
	puntos = 0
	emit_signal("puntos_cambiados", puntos)
	nivel -= 1
	nivel_progreso = nivel

func sumar_monedas(valor):
	monedas += valor
	emit_signal("monedas_cambiadas", monedas)


func actualizar_todos_los_datos():
	emit_signal("vida_cambiada", vida)
	emit_signal("puntos_cambiados", puntos)
	emit_signal("monedas_cambiadas", monedas)
	

func controlador_de_niveles(valor):
	var mensaje = ""
	if nivel_progreso == valor:
		mensaje = "Nivel: " + str(valor) + ".\n Monedas: " + str(cantidad_de_monedas) + ".\n Enemigos: " + str(cantidad_de_enemigos) + ".\n Mata todos los enemigos para avanzar al siguiente nivel."  
	else:
		mensaje = "Nivel: " + str(valor) + ".\n Monedas: " + str(cantidad_de_monedas) + ".\n Enemigos: " + str(cantidad_de_enemigos) + ".\n Avanzar al siguiente nivel."
	emit_signal("informacion_del_nivel_cambiado", mensaje)

func controladorCofre(valor, cantidad):
	if valor == "oro":
		sumar_monedas(cantidad)

func guardar_objeto() -> void:
	emit_signal("plataforma_colocada")

func crear_guardar_objeto(nombre, mensaje_tooltip, cantidad, imagen, tipo, atributos, ingredientes):
	if objetos.has(nombre):
		objetos[nombre].cantidad += cantidad
	else:
		id_objeto += 1
		objetos[nombre] = {
			"id": id_objeto,
			"nombre": nombre,
			"mensaje_tooltip": mensaje_tooltip,
			"cantidad": cantidad,
			"imagen": imagen, #preload("res://assets/espada.png") as CompressedTexture2D
			"tipo": tipo,
			"atributos": atributos,
			"ingredientes": ingredientes
			}
		
func equipar_objeto(id) -> void:
	for objeto in objetos.keys():
		var data = objetos[objeto]
		if data.has("id") and data.id == id:
			for objeto_equipado in objetos_equipados.keys():
				var data2 = objetos_equipados[objeto_equipado]
				if data2.has("tipo") and data2.tipo == data.tipo:
					objetos[objeto_equipado] = data2
					objetos_equipados.erase(objeto_equipado)
					break
			objetos_equipados[objeto] = data
			objetos.erase(objeto)
			break   # si solo movés uno
	emit_signal("objeto_equipado")

func controlador_de_cultivo(nombre):
	for obj in objetos:
		var nombreobj = objetos[obj].nombre.to_lower()
		if nombreobj == nombre:
			objetos[obj].cantidad += 1
			break
