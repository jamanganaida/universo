extends CanvasLayer

func _ready():
	Datos.activar_consumible.connect(_on_activar_consumible)
	Datos.vida_cambiada.connect(_on_vida_cambiada)
	Datos.puntos_cambiados.connect(_on_puntos_cambiados)
	Datos.monedas_cambiadas.connect(_on_monedas_cambiadas)
	Datos.informacion_del_nivel_cambiado.connect(_on_informacion_del_nivel_cambiado)
	Datos.info_del_enemigo.connect(_on_combate_activado)
	Datos.consumo_completo.connect(_on_recargar_consumible)
	Datos.ningun_consumible.connect(_on_desactivar_consumible)
	Datos.contar_consumible_equipado()

func _on_combate_activado(vida_maxima_enemigo, vida_actual_enemigo):
	$Control/PanelContainer5.visible = true
	$Control/PanelContainer5/Vida.text = "Vida: " + str(vida_actual_enemigo)
	$Control/PanelContainer5/ProgressBar.max_value = vida_maxima_enemigo
	$Control/PanelContainer5/ProgressBar.value = vida_actual_enemigo

func _on_vida_cambiada(valor):
	$Control/PanelContainer/Vida.text = "Vida: " + str(valor)
	$Control/PanelContainer/ProgressBar.max_value = Datos.vidaMaxima
	$Control/PanelContainer/ProgressBar.value = Datos.vida

func _on_puntos_cambiados(valor):
	$Control/PanelContainer5.visible = false
	$Control/PanelContainer2/Puntos.text = "Puntos: " + str(valor)

func _on_monedas_cambiadas(valor):
	$Control/PanelContainer4/Monedas.text = "Monedas: " + str(valor)

func _on_informacion_del_nivel_cambiado(valor):
	$Control/PanelContainer3/Mision.text = str(valor)

func _on_desactivar_consumible():
	$Control/PanelContainer6/Sopa1JugoTomate.modulate = Color(0, 0, 0)
	$Control/PanelContainer6/ColorRect.visible = false
	$Control/PanelContainer6/ColorRect.stop()

func _on_recargar_consumible():
	$Control/PanelContainer6/Sopa1JugoTomate.modulate = Color(0, 0, 0)
	$Control/PanelContainer6/ColorRect.visible = true
	$Control/PanelContainer6/ColorRect.play("default")
	await get_tree().create_timer(3).timeout
	_on_activar_consumible()

func _on_activar_consumible():
	$Control/PanelContainer6/ColorRect.visible = false
	$Control/PanelContainer6/ColorRect.stop()
	$Control/PanelContainer6/Sopa1JugoTomate.modulate = Color(1, 1, 1)
	Datos.permitir_consumir()
