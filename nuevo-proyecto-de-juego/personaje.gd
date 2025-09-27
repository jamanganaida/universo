extends CharacterBody2D


@export var bullet_scene = preload("res://bala.tscn")
var SPEED = 250.0
const JUMP_VELOCITY = -500.0
@warning_ignore("unused_signal")
signal movimiento
@onready var animacion = $AnimationPlayer
@onready var spritepj = $Sprite2D
@onready var tiempo = $Timer
var disparar = true
var move = true

func _physics_process(_delta: float) -> void:
	tiempo.wait_time = 2 - (Datos.velocidadDisparo * 0.1)
	emit_signal("movimiento")
	if not is_on_floor():
		if velocity.y <= 1000:
			velocity.y += 10
	
	if Input.is_action_pressed("mover_derecha"):
		spritepj.flip_h = false
		velocity.x = 2 * SPEED
	if Input.is_action_pressed("mover_izquierda"):
		spritepj.flip_h = true
		velocity.x = 2 * -SPEED
	if Input.is_action_pressed("saltar"):
		animacion.play("volar")
		if velocity.y > -500:
			velocity.y += -60
	else:
		animacion.play("nada")
	velocity.x = move_toward(velocity.x, 0, SPEED -100 )
	
	if Input.is_action_pressed("disparar"):
		disparar_al_mouse()
	if move:
		move_and_slide()
	

func disparar_al_mouse():
	if disparar:
		var bullet = bullet_scene.instantiate()
		bullet.daño += Datos.daño + Datos.daño_mejora
		bullet.global_position = global_position  # Sale desde el personaje
		bullet.direction = (get_global_mouse_position() - global_position).normalized()
		get_tree().current_scene.add_child(bullet)
		tiempo.start()
		disparar = false

func descontar_vida(dañoEntrada):
	Datos.set_vida(-dañoEntrada)#en negativo para descontar
	if Datos.vida <= 0:
		if Datos.primeraMuerte == 0:
			Datos.primeraMuerte = 1
		get_tree().call_deferred("change_scene_to_file", "res://nivel1.tscn")


func _on_timer_timeout() -> void:
	disparar = true
