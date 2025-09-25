extends CanvasLayer

func _ready():
	Datos.vida_cambiada.connect(_on_vida_cambiada)
	Datos.puntos_cambiados.connect(_on_puntos_cambiados)
	Datos.monedas_cambiadas.connect(_on_monedas_cambiadas)
	Datos.informacion_del_nivel_cambiado.connect(_on_informacion_del_nivel_cambiado)
	Datos.cultivo_cambiado.connect(_on_inf_cultivos_actualizados)

func _on_vida_cambiada(valor):
	$Control/PanelContainer/Vida.text = "Vida: " + str(valor)
	$Control/PanelContainer/ProgressBar.max_value = Datos.vidaMaxima
	$Control/PanelContainer/ProgressBar.value = Datos.vida

func _on_puntos_cambiados(valor):
	$Control/PanelContainer2/Puntos.text = "Puntos: " + str(valor)

func _on_monedas_cambiadas(valor):
	$Control/PanelContainer4/GridContainer/Monedas.text = "Monedas: " + str(valor)

func _on_informacion_del_nivel_cambiado(valor):
	$Control/PanelContainer3/Mision.text = str(valor)


func _on_panel_container_4_mouse_entered() -> void:
	$Control/PanelContainer4/GridContainer/brocoli.visible = true
	$Control/PanelContainer4/GridContainer/cebolla.visible = true
	$Control/PanelContainer4/GridContainer/tomate.visible = true
	$Control/PanelContainer4/GridContainer/pimiento.visible = true
	$Control/PanelContainer4/GridContainer/zanahoria.visible = true
	$Control/PanelContainer4/GridContainer/maiz.visible = true
	_on_inf_cultivos_actualizados()
	$Control/PanelContainer4.position.x = 530
	$Control/PanelContainer4.size.x = 400
	$Control/PanelContainer4.size.y = 90



func _on_panel_container_4_mouse_exited() -> void:
	$Control/PanelContainer4/GridContainer/brocoli.visible = false
	$Control/PanelContainer4/GridContainer/cebolla.visible = false
	$Control/PanelContainer4/GridContainer/tomate.visible = false
	$Control/PanelContainer4/GridContainer/pimiento.visible = false
	$Control/PanelContainer4/GridContainer/zanahoria.visible = false
	$Control/PanelContainer4/GridContainer/maiz.visible = false
	$Control/PanelContainer4.position.x = 530
	$Control/PanelContainer4.size.x = 100
	$Control/PanelContainer4.size.y = 30
	pass # Replace with function body.

func _on_inf_cultivos_actualizados():
	$Control/PanelContainer4/GridContainer/brocoli.text = "Brocoli: " + str(Datos.objetos["Brocoli"].cantidad)
	$Control/PanelContainer4/GridContainer/cebolla.text = "Cebolla: " + str(Datos.objetos["Cebolla"].cantidad)
	$Control/PanelContainer4/GridContainer/tomate.text = "Tomate: " + str(Datos.objetos["Tomate"].cantidad)
	$Control/PanelContainer4/GridContainer/pimiento.text = "Pimiento: " + str(Datos.objetos["Pimiento"].cantidad)
	$Control/PanelContainer4/GridContainer/zanahoria.text = "Zanahoria: " + str(Datos.objetos["Zanahoria"].cantidad)
	$Control/PanelContainer4/GridContainer/maiz.text = "Maiz: " + str(Datos.objetos["Maíz"].cantidad)
