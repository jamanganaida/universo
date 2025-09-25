extends CanvasLayer

func _ready():
	Datos.vida_cambiada.connect(_on_vida_cambiada)
	Datos.puntos_cambiados.connect(_on_puntos_cambiados)
	Datos.monedas_cambiadas.connect(_on_monedas_cambiadas)
	Datos.informacion_del_nivel_cambiado.connect(_on_informacion_del_nivel_cambiado)


func _on_vida_cambiada(valor):
	$Control/PanelContainer/Vida.text = "Vida: " + str(valor)
	$Control/PanelContainer/ProgressBar.max_value = Datos.vidaMaxima
	$Control/PanelContainer/ProgressBar.value = Datos.vida

func _on_puntos_cambiados(valor):
	$Control/PanelContainer2/Puntos.text = "Puntos: " + str(valor)

func _on_monedas_cambiadas(valor):
	$Control/PanelContainer4/Monedas.text = "Monedas: " + str(valor)

func _on_informacion_del_nivel_cambiado(valor):
	$Control/PanelContainer3/Mision.text = str(valor)
