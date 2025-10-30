extends Panel


var pagina = 0
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	ordenar_hijos(pagina)
	pass # Replace with function body.



func ordenar_hijos(pagina := 0):
	await get_tree().create_timer(0.01).timeout
	var paginas_total = contador_Objetos() / 12
	if pagina > paginas_total:
		pagina = 0 
	var infopaginalabel = self.get_parent().get_child(7)
	infopaginalabel.text = str(pagina) + "/" + str(paginas_total)
	var inicio := pagina * 12
	var fin := inicio + 12
	for idx in range(get_child_count()):
		var c := get_child(idx)
		if idx < inicio or idx >= fin:
			c.visible = false
			continue
		var local = idx - inicio
		var col = local % 3
		var fila = int(local / 3)
		c.position = Vector2(col * 100, fila * 115)
		c.visible = true
		c.position.x += 30

func contador_Objetos():
	var contador = 0
	for idx in range(get_child_count()):
		contador += 1
	return contador
	
func _on_button_pressed() -> void:
	var paginas_total = int(contador_Objetos() / 12)
	if paginas_total > pagina:
		pagina += 1
	elif paginas_total <= pagina:
		pagina = 0
	ordenar_hijos(pagina)


func _on_button_2_pressed() -> void:
	var paginas_total = int(contador_Objetos() / 12)
	if pagina > 0:
		pagina -= 1
	elif pagina <= 0:
		pagina = paginas_total
	ordenar_hijos(pagina)
