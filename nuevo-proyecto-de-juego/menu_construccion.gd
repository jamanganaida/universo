extends Panel


@export var plataforma : PackedScene
@export var plataformaCultivo : PackedScene

@onready var boton1 = $Panel2/Tomate/comprarPlataformaTomate
@onready var boton2 = $Panel2/Maiz/comprarPlataformaMaiz
@onready var boton3 = $Panel2/Pimiento/comprarPlataformaPimiento
@onready var boton4 = $Panel2/Brocoli/comprarPlataformaBrocoli
@onready var boton5 = $Panel2/Cebolla/comprarPlataformaCebolla
@onready var boton6 = $Panel2/Zanahoria/comprarPlataformaZanahoria
@onready var boton7 = $"Panel2/Plataforma común/comprarPlataformaComún"
var padre
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Datos.plataforma_colocada.connect(colocando_plataforma)
	padre = get_tree().current_scene
	Datos.monedas_cambiadas.connect(calcularSiTodos)
	pass # Replace with function body.


func colocarPlataformaCultivoDe(varCultivo, precio):
	if Datos.monedas >= precio:
		colocando_plataforma()
		Datos.sumar_monedas(precio)
		var plataformaNueva = plataformaCultivo.instantiate()
		plataformaNueva.nombreVerdura = varCultivo
		plataformaNueva.tipoVerdura = true
		plataformaNueva.placing_plataforma = true
		plataformaNueva.lo_tengo = true
		plataformaNueva.está_en_casa = true
		plataformaNueva.perEnPla = true
		Datos.nc += 1
		Datos.contenedor.add_child(plataformaNueva)


func _on_comprar_plataforma_tomate_pressed() -> void:
	colocarPlataformaCultivoDe("tomate", -100)
	pass # Replace with function body.


func _on_comprar_plataforma_común_pressed() -> void:
	colocando_plataforma()
	Datos.sumar_monedas(-50)
	var plataformaNueva = plataforma.instantiate()
	plataformaNueva.placing_plataforma = true
	plataformaNueva.lo_tengo = true
	Datos.contenedor.add_child(plataformaNueva)
	get_tree().root.get_node("Nivel1").agregar_plataformas_al_minimapa()
	pass # Replace with function body.


func _on_comprar_plataforma_maiz_pressed() -> void:
	colocarPlataformaCultivoDe("maiz", -500)
	pass # Replace with function body.


func _on_comprar_plataforma_pimiento_pressed() -> void:
	colocarPlataformaCultivoDe("pimiento", -1000)
	pass # Replace with function body.


func _on_comprar_plataforma_brocoli_pressed() -> void:
	colocarPlataformaCultivoDe("brocoli", -5000)
	pass # Replace with function body.


func _on_comprar_plataforma_cebolla_pressed() -> void:
	colocarPlataformaCultivoDe("cebolla", -15000)
	pass # Replace with function body.


func _on_comprar_plataforma_zanahoria_pressed() -> void:
	colocarPlataformaCultivoDe("zanahoria", -40000)
	pass # Replace with function body.

	
func calcularSiTodos(_v):
	calcularSi(boton1, 100)
	calcularSi(boton2, 500)
	calcularSi(boton3, 1000)
	calcularSi(boton4, 5000)
	calcularSi(boton5, 15000)
	calcularSi(boton6, 40000)
	calcularSi(boton7, 50)

func calcularSi(boton, cantidad):
	if Datos.monedas < cantidad:
		boton.disabled = true
	else:
		boton.disabled = false
		
func colocando_plataforma():
	if self.visible:
		self.visible = false
	else:
		self.visible = true


func _on_area_2d_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if event is InputEventMouseButton and event.pressed:
		Datos.menuconstruccionvisible = false
		self.queue_free()
