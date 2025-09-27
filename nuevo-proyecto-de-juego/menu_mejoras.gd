extends Panel


@onready var boton1 = $Panel2/MejoraVida/VidaPlus
@onready var boton2 = $Panel2/MejoraDaño/DangerMás
@onready var boton3 = $Panel2/Mejorapantalla/pantallaCura
@onready var boton4 = $Panel2/Mejoravelataque/VelocidadAtaque
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	boton1.text = "Vida: " + str(Datos.vidaMaxima) + " +10 $" + str(Datos.costoMejoraVida)
	boton2.text = "Daño: " + str(Datos.daño_mejora) + " +1 $" + str(Datos.costoMejoraDaño)
	boton3.text = "Plantalla curativa: " + str(Datos.vida_plataforma_curativa) + " +10 $" + str(Datos.costoMejoraPlataformaCurativa)
	boton4.text = "Velocidad de diparo: " + str(Datos.velocidadDisparo) + " +1 $" + str(Datos.costoMejoraVelocidadDisparo)
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func actualizar():
	calcularSiTodos()
	boton1.text = "Vida: " + str(Datos.vidaMaxima) + " +10 $" + str(Datos.costoMejoraVida)
	boton2.text = "Daño: " + str(Datos.daño) + " +1 $" + str(Datos.costoMejoraDaño)
	boton3.text = "Plantalla curativa: " + str(Datos.vida_plataforma_curativa) + " +10 $" + str(Datos.costoMejoraPlataformaCurativa)
	boton4.text = "Velocidad de diparo: " + str(Datos.velocidadDisparo) + " +1 $" + str(Datos.costoMejoraVelocidadDisparo)
	

func _on_vida_plus_pressed() -> void:
	Datos.sumar_monedas(-Datos.costoMejoraVida)
	Datos.vidaMaxima += 10
	actualizar()
	pass # Replace with function body.


func _on_danger_más_pressed() -> void:
	Datos.sumar_monedas(-Datos.costoMejoraDaño)
	Datos.daño_mejora += 1
	actualizar()
	pass # Replace with function body.


func _on_pantalla_cura_pressed() -> void:
	Datos.sumar_monedas(-Datos.costoMejoraPlataformaCurativa)
	Datos.vida_plataforma_curativa += 10
	actualizar()
	pass # Replace with function body.


func _on_velocidad_ataque_pressed() -> void:
	Datos.sumar_monedas(-Datos.costoMejoraVelocidadDisparo)
	Datos.velocidadDisparo += 1
	actualizar()
	pass # Replace with function body.

func calcularSi(boton, cantidad):
	if Datos.monedas < cantidad:
		boton.disabled = true
	else:
		boton.disabled = false
	
func calcularSiTodos():
	calcularSi(boton1, 100)
	calcularSi(boton2, 100)
	calcularSi(boton3, 100)
	calcularSi(boton4, 100)


func _on_area_2d_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if event is InputEventMouseButton and event.pressed:
		Datos.menumejorasvisible = false
		self.queue_free()
