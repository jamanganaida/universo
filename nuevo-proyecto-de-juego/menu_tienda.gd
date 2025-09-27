extends Panel
@onready var comprarEscoba = $PanelArmas/Panel/ComprarEscoba
@onready var comprarBate = $PanelArmas/Panel2/ComprarBate
@onready var comprarRemo = $PanelArmas/Panel3/ComprarRemo
@onready var comprarHorquilla = $PanelArmas/Panel4/ComprarHorquilla
@onready var comprarPala = $PanelArmas/Panel5/ComprarPala
@onready var comprarAcha = $PanelArmas/Panel6/ComprarAcha
@onready var comprarLiana22lr = $PanelArmas/Panel7/VenderLiana22lr
@onready var comprarDoca9mm = $PanelArmas/Panel8/VenderDoca9mm
@onready var comprarBoom9mm = $PanelArmas/Panel9/VenderBoom9mm
@onready var comprarAloe9mm = $PanelArmas/Panel10/VenderAloe9mm
@onready var comprarEngau9mm = $PanelArmas/Panel11/VenderEngau9mm
@onready var comprarPluto10mm = $PanelArmas/Panel12/VenderPluto10mm
@onready var comprarTomate = $PanelCultivos/Panel/ComprarTomate
@onready var comprarCebolla = $PanelCultivos/Panel4/ComprarCebolla 
@onready var comprarZanahoria = $PanelCultivos/Panel2/ComprarZanahoria
@onready var comprarPimiento = $PanelCultivos/Panel6/ComprarPimiento
@onready var comprarBrocoli = $PanelCultivos/Panel5/ComprarBrocoli
@onready var comprarMaiz = $PanelCultivos/Panel3/ComprarMaiz
@onready var venderTomate = $PanelCultivos/Panel7/VenderTomate
@onready var venderCebolla = $PanelCultivos/Panel10/VenderCebolla 
@onready var venderZanahoria = $PanelCultivos/Panel8/VenderZanahoria
@onready var venderPimiento = $PanelCultivos/Panel12/VenderPimiento
@onready var venderBrocoli = $PanelCultivos/Panel11/VenderBrocoli
@onready var venderMaiz = $PanelCultivos/Panel9/VenderMaiz
@onready var modoTienda = $Panel3/modoTienda
@onready var panelcultivo = $PanelCultivos
@onready var panelarmas = $PanelArmas

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	controlar_botones_tienda_arma()
	Datos.cultivo_cambiado.connect(calcularDisabledDeLosBotones)
	calcularDisabledDeLosBotones()
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func calcularDisabledDeLosBotones():
	if Datos.monedas < 2500:
		comprarBrocoli.disabled = true
	else:
		comprarBrocoli.disabled = false
	if Datos.monedas < 7500:
		comprarCebolla.disabled = true
	else:
		comprarCebolla.disabled = false
	if Datos.monedas < 250:
		comprarMaiz.disabled = true
	else:
		comprarMaiz.disabled = false
	if Datos.monedas < 500:
		comprarPimiento.disabled = true
	else:
		comprarPimiento.disabled = false
	if Datos.monedas < 50:
		comprarTomate.disabled = true
	else:
		comprarTomate.disabled = false
	if Datos.monedas < 20000:
		comprarZanahoria.disabled = true
	else:
		comprarZanahoria.disabled = false
	if Datos.objetos["Zanahoria"].cantidad == 0:
		venderZanahoria.disabled = true
	else:
		venderZanahoria.disabled = false
	if Datos.objetos["Brocoli"].cantidad == 0:
		venderBrocoli.disabled = true
	else:
		venderBrocoli.disabled = false
	if Datos.objetos["Cebolla"].cantidad == 0:
		venderCebolla.disabled = true
	else:
		venderCebolla.disabled = false
	if Datos.objetos["Maíz"].cantidad == 0:
		venderMaiz.disabled = true
	else:
		venderMaiz.disabled = false
	if Datos.objetos["Pimiento"].cantidad == 0:
		venderPimiento.disabled = true
	else:
		venderPimiento.disabled = false
	if Datos.objetos["Tomate"].cantidad == 0:
		venderTomate.disabled = true
	else:
		venderTomate.disabled = false


func _on_comprar_tomate_pressed() -> void:
	if Datos.monedas >= 50:
		Datos.monedas -= 50
		Datos.objetos["Tomate"].cantidad += 1
		Datos.actualizar_verduras_mnedas()
	calcularDisabledDeLosBotones()


func _on_comprar_zanahoria_pressed() -> void:
	if Datos.monedas >= 20000:
		Datos.monedas -= 20000
		Datos.objetos["Zanahoria"].cantidad += 1
		Datos.actualizar_verduras_mnedas()
	calcularDisabledDeLosBotones()


func _on_comprar_maiz_pressed() -> void:
	if Datos.monedas >= 250:
		Datos.monedas -= 250
		Datos.objetos["Maíz"].cantidad += 1
		Datos.actualizar_verduras_mnedas()
	calcularDisabledDeLosBotones()


func _on_comprar_cebolla_pressed() -> void:
	if Datos.monedas >= 7500:
		Datos.monedas -= 7500
		Datos.objetos["Cebolla"].cantidad += 1
		Datos.actualizar_verduras_mnedas()
	calcularDisabledDeLosBotones()


func _on_comprar_brocoli_pressed() -> void:
	if Datos.monedas >= 2500:
		Datos.monedas -= 2500
		Datos.objetos["Brocoli"].cantidad += 1
		Datos.actualizar_verduras_mnedas()
	calcularDisabledDeLosBotones()


func _on_comprar_pimiento_pressed() -> void:
	if Datos.monedas >= 500:
		Datos.monedas -= 500
		Datos.objetos["Pimiento"].cantidad += 1
		Datos.actualizar_verduras_mnedas()
	calcularDisabledDeLosBotones()


func _on_vender_tomate_pressed() -> void:
	if Datos.objetos["Tomate"].cantidad > 0:
		Datos.monedas += 10
		Datos.objetos["Tomate"].cantidad -= 1
		Datos.actualizar_verduras_mnedas()
	calcularDisabledDeLosBotones()


func _on_vender_zanahoria_pressed() -> void:
	if Datos.objetos["Zanahoria"].cantidad > 0:
		Datos.monedas += 10
		Datos.objetos["Zanahoria"].cantidad -= 1
		Datos.actualizar_verduras_mnedas()
	calcularDisabledDeLosBotones()


func _on_vender_maiz_pressed() -> void:
	if Datos.objetos["Maíz"].cantidad > 0:
		Datos.monedas += 10
		Datos.objetos["Maíz"].cantidad -= 1
		Datos.actualizar_verduras_mnedas()
	calcularDisabledDeLosBotones()


func _on_vender_cebolla_pressed() -> void:
	if Datos.objetos["Cebolla"].cantidad > 0:
		Datos.monedas += 10
		Datos.objetos["Cebolla"].cantidad -= 1
		Datos.actualizar_verduras_mnedas()
	calcularDisabledDeLosBotones()


func _on_vender_brocoli_pressed() -> void:
	if Datos.objetos["Brocoli"].cantidad > 0:
		Datos.monedas += 10
		Datos.objetos["Brocoli"].cantidad -= 1
		Datos.actualizar_verduras_mnedas()
	calcularDisabledDeLosBotones()


func _on_vender_pimiento_pressed() -> void:
	if Datos.objetos["Pimiento"].cantidad > 0:
		Datos.monedas += 10
		Datos.objetos["Pimiento"].cantidad -= 1
		Datos.actualizar_verduras_mnedas()
	calcularDisabledDeLosBotones()


func _on_area_2d_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if event is InputEventMouseButton and event.pressed:
		Datos.menutiendavisible = false
		self.queue_free()


func _on_button_pressed() -> void:
	if modoTienda.text == "Cultivos":
		modoTienda.text = "Armas"
		panelcultivo.visible = false
		panelarmas.visible = true
	else:
		modoTienda.text = "Cultivos"
		panelcultivo.visible = true
		panelarmas.visible = false


func _on_button_2_pressed() -> void:
	if modoTienda.text == "Armas":
		modoTienda.text = "Cultivos"
		panelcultivo.visible = true
		panelarmas.visible = false
	else:
		modoTienda.text = "Armas"
		panelcultivo.visible = false
		panelarmas.visible = true




func controlar_botones_tienda_arma():
	if Datos.objetos.get("Acha", null) != null:
		comprarAcha.text = "Comprado"
		comprarAcha.disabled = true
	elif Datos.monedas >= 8000:
		comprarAcha.disabled = false
	else:
		comprarAcha.disabled = true
	if Datos.objetos.get("Bate", null) != null:
		comprarBate.text = "Comprado"
		comprarBate.disabled = true
	elif Datos.monedas >= 2000:
		comprarBate.disabled = false
	else:
		comprarBate.disabled = true
	if Datos.objetos.get("Remo", null) != null:
		comprarRemo.text = "Comprado"
		comprarRemo.disabled = true
	elif Datos.monedas >= 3000:
		comprarRemo.disabled = false
	else:
		comprarRemo.disabled = true
	if Datos.objetos.get("Horquilla", null) != null:
		comprarHorquilla.text = "Comprado"
		comprarHorquilla.disabled = true
	elif Datos.monedas >= 4000:
		comprarHorquilla.disabled = false
	else:
		comprarHorquilla.disabled = true
	if Datos.objetos.get("Pala", null) != null:
		comprarPala.text = "Comprado"
		comprarPala.disabled = true
	elif Datos.monedas >= 5000:
		comprarPala.disabled = false
	else:
		comprarPala.disabled = true
	if Datos.objetos.get("Escoba", null) != null:
		comprarEscoba.text = "Comprado"
		comprarEscoba.disabled = true
	elif Datos.monedas >= 1000:
		comprarEscoba.disabled = false
	else:
		comprarEscoba.disabled = true
	if Datos.objetos.get("Liana", null) != null:
		comprarLiana22lr.text = "Comprado"
		comprarLiana22lr.disabled = true
	elif Datos.monedas >= 15000:
		comprarLiana22lr.disabled = false
	else:
		comprarLiana22lr.disabled = true
	if Datos.objetos.get("Doca", null) != null:
		comprarDoca9mm.text = "Comprado"
		comprarDoca9mm.disabled = true
	elif Datos.monedas >= 23000:
		comprarDoca9mm.disabled = false
	else:
		comprarDoca9mm.disabled = true
	if Datos.objetos.get("Boom", null) != null:
		comprarBoom9mm.text = "Comprado"
		comprarBoom9mm.disabled = true
	elif Datos.monedas >= 38500:
		comprarBoom9mm.disabled = false
	else:
		comprarBoom9mm.disabled = true
	if Datos.objetos.get("Aloe", null) != null:
		comprarAloe9mm.text = "Comprado"
		comprarAloe9mm.disabled = true
	elif Datos.monedas >= 40000:
		comprarAloe9mm.disabled = false
	else:
		comprarAloe9mm.disabled = true
	if Datos.objetos.get("Engau", null) != null:
		comprarEngau9mm.text = "Comprado"
		comprarEngau9mm.disabled = true
	elif Datos.monedas >= 87000:
		comprarEngau9mm.disabled = false
	else:
		comprarEngau9mm.disabled = true
	if Datos.objetos.get("Pluto", null) != null:
		comprarPluto10mm.text = "Comprado"
		comprarPluto10mm.disabled = true
	elif Datos.monedas >= 126900:
		comprarPluto10mm.disabled = false
	else:
		comprarPluto10mm.disabled = true
		
		
		
func _on_comprar_escoba_pressed() -> void:
	if Datos.monedas >= 1000:
		Datos.sumar_monedas(-1000)
		var atributo = {"daño": 1}
		Datos.crear_guardar_objeto("Escoba", "Escoba +1 daño", 1, preload("res://arma-0-escoba.png") as CompressedTexture2D, "arma-corta", atributo, "ninguna")
	controlar_botones_tienda_arma()
		


func _on_comprar_bate_pressed() -> void:
	if Datos.monedas >= 2000:
		Datos.sumar_monedas(-2000)
		var atributo = {"daño": 2}
		Datos.crear_guardar_objeto("Bate", "Bate +2 daño", 1, preload("res://arma-1-bate.png") as CompressedTexture2D, "arma-corta", atributo, "ninguna" )
	controlar_botones_tienda_arma()


func _on_comprar_remo_pressed() -> void:
	if Datos.monedas >= 3000:
		Datos.sumar_monedas(-3000)
		var atributo = {"daño": 3}
		Datos.crear_guardar_objeto("Remo", "Remo +3 daño", 1, preload("res://arma-2-remo.png") as CompressedTexture2D, "arma-corta", atributo, "ninguna")
	controlar_botones_tienda_arma()



func _on_comprar_horquilla_pressed() -> void:
	if Datos.monedas >= 4000:
		Datos.sumar_monedas(-4000)
		var atributo = {"daño": 4}
		Datos.crear_guardar_objeto("Horquilla", "Horquilla +4 daño", 1, preload("res://arma-4-horquilla.png") as CompressedTexture2D, "arma-corta", atributo, "ninguna")
	controlar_botones_tienda_arma()



func _on_comprar_pala_pressed() -> void:
	if Datos.monedas >= 5000:
		Datos.sumar_monedas(-5000)
		var atributo = {"daño": 5}
		Datos.crear_guardar_objeto("Pala", "Pala +5 daño", 1, preload("res://arma-5-pala.png") as CompressedTexture2D, "arma-corta", atributo, "ninguna")
	controlar_botones_tienda_arma()


func _on_comprar_acha_pressed() -> void:
	if Datos.monedas >= 8000:
		Datos.sumar_monedas(-8000)
		var atributo = {"daño": 10}
		Datos.crear_guardar_objeto("Acha", "Acha +10 daño", 1, preload("res://arma-6-acha.png") as CompressedTexture2D, "arma-corta", atributo, "ninguna")
	controlar_botones_tienda_arma()


func _on_vender_liana_22_lr_pressed() -> void:
	if Datos.monedas >= 15000:
		Datos.sumar_monedas(-15000)
		var atributo = {"daño": 15}
		Datos.crear_guardar_objeto("Liana", "Liana +15 daño", 1, preload("res://arma-fuego-1-Liana22lr.png") as CompressedTexture2D, "arma-larga", atributo, "ninguna")
	controlar_botones_tienda_arma()


func _on_vender_doca_9_mm_pressed() -> void:
	if Datos.monedas >= 23000:
		Datos.sumar_monedas(-23000)
		var atributo = {"daño": 23}
		Datos.crear_guardar_objeto("Doca", "Doca +23 daño", 1, preload("res://arma-fuego-2-Doca9mm.png") as CompressedTexture2D, "arma-larga", atributo, "ninguna")
	controlar_botones_tienda_arma()


func _on_vender_boom_9_mm_pressed() -> void:
	if Datos.monedas >= 38500:
		Datos.sumar_monedas(-38500)
		var atributo = {"daño": 39}
		Datos.crear_guardar_objeto("Boom", "Boom +39 daño", 1, preload("res://arma-fuego-3-Boom9mm.png") as CompressedTexture2D, "arma-larga", atributo, "ninguna" )
	controlar_botones_tienda_arma()


func _on_vender_aloe_9_mm_pressed() -> void:
	if Datos.monedas >= 40000:
		Datos.sumar_monedas(-40000)
		var atributo = {"daño": 40}
		Datos.crear_guardar_objeto("Aloe", "Aloe +40 daño", 1, preload("res://arma-fuego-4-Aloe9mm.png") as CompressedTexture2D, "arma-larga", atributo, "ninguna")
	controlar_botones_tienda_arma()


func _on_vender_engau_9_mm_pressed() -> void:
	if Datos.monedas >= 87000:
		Datos.sumar_monedas(-87000)
		var atributo = {"daño": 87}
		Datos.crear_guardar_objeto("Engau", "Engau +87 daño", 1, preload("res://arma-fuego-5-Engau9mm.png") as CompressedTexture2D, "arma-larga", atributo, "ninguna")
	controlar_botones_tienda_arma()


func _on_vender_pluto_10_mm_pressed() -> void:
	if Datos.monedas >= 126900:
		Datos.sumar_monedas(-126900)
		var atributo = {"daño": 130}
		Datos.crear_guardar_objeto("Pluto", "Boom +130 daño", 1, preload("res://arma-fuego-6-Pluto10mm.png") as CompressedTexture2D, "arma-larga", atributo, "ninguna")
	controlar_botones_tienda_arma()
