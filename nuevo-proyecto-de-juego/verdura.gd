extends Area2D

var verdura = ""
@export var tomate: CompressedTexture2D
@export var maiz: CompressedTexture2D
@export var brocoli: CompressedTexture2D
@export var pimiento: CompressedTexture2D
@export var cebolla: CompressedTexture2D
@export var zanahoria: CompressedTexture2D
@onready var imagen = $Sprite2D
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if verdura:
		if verdura == "tomate":
			imagen.texture = tomate
		if verdura == "maiz":
			imagen.texture = maiz
		if verdura == "brocoli":
			imagen.texture = brocoli
		if verdura == "pimiento":
			imagen.texture = pimiento
		if verdura == "cebolla":
			imagen.texture = cebolla
		if verdura == "zanahoria":
			imagen.texture = zanahoria
	pass # Replace with function body.


func _on_body_entered(body: Node2D) -> void:
	if body.name == "personaje":
		Datos.controlador_de_cultivo(verdura)
		call_deferred("queue_free")
