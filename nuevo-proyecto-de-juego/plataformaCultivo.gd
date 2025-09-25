extends "res://plataforma.gd"

@onready var timer = $Timer
@export var moneda :PackedScene
@export var verdura :PackedScene
@onready var animacion = $AnimationPlayer
var tipoVerdura = false
var perEnPla = false
var nombreVerdura = ""
func _ready() -> void:
	if nombreVerdura == "tomate":
		timer.wait_time = 3
	animacion.play("activo")
	Datos.cultivos += 1


func _on_timer_timeout() -> void:
	if not tipoVerdura:
		var NuevaMoneda = moneda.instantiate()
		NuevaMoneda.global_position.y = -50
		add_child(NuevaMoneda)
	else:
		var verduraobj = verdura.instantiate()
		verduraobj.global_position.y = -50
		verduraobj.verdura = nombreVerdura
		add_child(verduraobj)
	if perEnPla:
		timer.start()
	

func _on_area_2d_body_entered(body) -> void:
	if body.name == "personaje":
		perEnPla = true
		timer.start()


func _on_area_2d_body_exited(body: Node2D) -> void:
	if body.name == "personaje":
		perEnPla = false
