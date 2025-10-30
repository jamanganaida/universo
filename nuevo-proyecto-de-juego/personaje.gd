extends CharacterBody2D


@export var bullet_scene = preload("res://bala.tscn")
var SPEED = 250.0
const JUMP_VELOCITY = -500.0
@warning_ignore("unused_signal")
signal movimiento
@onready var animacion = $AnimationPlayer
@onready var spritepj = $Sprite2D
@onready var tiempo = $Timer
@onready var tiempo2 = $Timer2
@onready var contenedor_golpe = $golpe
@onready var golpe_colision = $golpe/colision
@onready var golpe_animacion = $golpe/AnimationPlayer
@onready var golpe_imagen = $golpe/Sprite2D
var disparar = true
var golpear = true
var move = true
var areadetecta = false
var atacar = true
var puede_consumir = true

func _ready() -> void:
	await get_tree().create_timer(0.1).timeout
	golpe_imagen.texture = Datos.arma_imagen
	Datos.permitir_consumo.connect(_on_puede_consumir)
	
	
func _physics_process(_delta: float) -> void:
	tiempo.wait_time = 2 - (Datos.velocidadDisparo * 0.01)
	tiempo2.wait_time = 0.5 - (Datos.velocidadDisparo * 0.01)
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
	if atacar:
		if Input.is_action_pressed("disparar"):
			disparar_al_mouse()
		if Input.is_action_pressed("golpear"):
			pegar()
		if Input.is_action_pressed("consumir"):
			if puede_consumir:
				if Datos.vida < Datos.vidaMaxima:
					puede_consumir = false
					Datos.consumir_consumible_equipado()
	if move:
		move_and_slide()
	
func pegar():
	if golpear:
		if spritepj.flip_h:
			contenedor_golpe.scale.x = -1
		else:
			contenedor_golpe.scale.x = 1
		golpe_animacion.play("golpe")
		for area in contenedor_golpe.get_overlapping_areas():
			area.descontar_vida(Datos.daño_corto + Datos.daño_mejora)
		tiempo2.start()
		golpear = false
	

func disparar_al_mouse():
	if disparar:
		var bullet = bullet_scene.instantiate()
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


func _on_timer_2_timeout() -> void:
	golpear = true

func _on_puede_consumir():
	puede_consumir = true
