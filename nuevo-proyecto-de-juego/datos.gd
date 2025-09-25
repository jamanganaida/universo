extends Node

#personaje
var vida = 100
var vidaMaxima = 100
var daño = 0
var position_x_personaje = 0
var velocida_y_personaje = 0
var velocidadDisparo = 0
var primeraMuerte = 0
var armaEquipada = ""
#juego
var contenedor : Node2D
var cultivos = 0
var vida_plataforma_curativa = 10
var puntos = 0
var monedas = 1000000
var nc = 0
var objetos = {}
var objetos_equipados = {}
var id_objeto = 0
#nivel
var cantidad_de_enemigos = 0
var cantidad_de_monedas = 0
var nivel_progreso = 1
var nivel = 0
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

var imgTomate = preload("res://tomate.png") as CompressedTexture2D
var imgZanahoria = preload("res://zanahoria.png") as CompressedTexture2D
var imgMaiz = preload("res://maiz.png") as CompressedTexture2D
var imgCebolla = preload("res://cebolla.png") as CompressedTexture2D
var imgBrocoli =  preload("res://brocoli.png") as CompressedTexture2D
var imgPimiento =  preload("res://pimiento.png") as CompressedTexture2D
func _ready():
	crear_guardar_objeto("Tomate", "Tomate", 0, imgTomate, "verdura" )
	crear_guardar_objeto("Zanahoria", "Zanahoria", 0,  imgZanahoria, "verdura")
	crear_guardar_objeto("Maíz", "Maíz", 0,  imgMaiz, "verdura")
	crear_guardar_objeto("Cebolla", "Cebolla", 0,  imgCebolla, "verdura")
	crear_guardar_objeto("Brocoli", "Brocoli", 0, imgBrocoli, "verdura")
	crear_guardar_objeto("Pimiento", "Pimiento", 0, imgPimiento, "verdura")
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

func crear_guardar_objeto(nombre, mensaje_tooltip, cantidad, imagen, tipo):
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
			"tipo": tipo
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
