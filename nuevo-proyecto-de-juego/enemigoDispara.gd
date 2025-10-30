extends Node2D

@export var bullet_scene: PackedScene
@export var fire_interval := 5.0  # cada 2 segundos dispara
var vida_maxima = 100
var vida = 100
var daño = 1
@export var target = Node
@warning_ignore("unused_signal")
signal enemigo_destruido


func _ready():
	var timer = Timer.new()
	timer.wait_time = fire_interval
	timer.autostart = true
	timer.one_shot = false
	add_child(timer)
	timer.timeout.connect(disparar)


func disparar():
	if target:
		var bullet = bullet_scene.instantiate()
		bullet.daño += daño
		bullet.global_position = self.global_position
		bullet.direction = (target.global_position - self.global_position).normalized()
		get_tree().current_scene.add_child(bullet)


func descontar_vida(dañoVar):
	Datos.enemigo_combate = self
	Datos.mandar_info_del_enemigo()
	vida -= dañoVar
	if vida <= 0:
		emit_signal("enemigo_destruido")
		Datos.agregar_puntos(1)
		call_deferred("queue_free")
