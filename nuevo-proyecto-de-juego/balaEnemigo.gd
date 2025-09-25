extends Area2D

@export var speed = 1800
var daño = 20
var direction = Vector2.ZERO

func _ready():
	pass

func _physics_process(delta):
	if position.y >= 7000 or position.y <= -7000 or position.x >= 7000 or position.x <= -7000:
		queue_free()
		
	position += direction.normalized() * speed * delta



func _on_body_entered(body) -> void:
	if body.name == "personaje":
		body.descontar_vida(daño)
		call_deferred("queue_free")
