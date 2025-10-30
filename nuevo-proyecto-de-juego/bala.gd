extends Area2D

@export var speed = 3000
var direction = Vector2.ZERO

func _ready():
	pass

func _physics_process(delta):
	if position.y >= 7000 or position.y <= -7000 or position.x >= 7000 or position.x <= -7000:
		queue_free()
		
	position += direction.normalized() * speed * delta


func _on_area_entered(area: Area2D) -> void:
	if area.is_in_group("enemigo"):
		area.descontar_vida(Datos.daño + Datos.daño_mejora)
		queue_free()
