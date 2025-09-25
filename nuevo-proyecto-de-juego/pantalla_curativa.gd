extends Area2D

var poder_curativo = Datos.vida_plataforma_curativa
var curar = false
@onready var tiempo = $Timer
var personaje
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

func _on_body_entered(body) -> void:
	if body.name == "personaje":
		personaje = body
		curar = true
		tiempo.start()



func _on_timer_timeout() -> void:
	if personaje:
		if Datos.vida < Datos.vidaMaxima:
			var estimado
			estimado = Datos.vida + poder_curativo
			if estimado > Datos.vidaMaxima:
				var otravida = poder_curativo - (estimado - Datos.vidaMaxima)
				Datos.set_vida(otravida)
			else:
				Datos.set_vida(poder_curativo)
		if curar:
			tiempo.start()


func _on_body_exited(body) -> void:
	if body.name == "personaje":
		personaje = 0
		curar = false
		tiempo.stop()
