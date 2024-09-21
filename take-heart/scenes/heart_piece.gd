class_name HeartPiece
extends Node2D

enum HeartType {LEFT, RIGHT}

@export var heart_type: HeartType
const left_heart = preload("res://assets/tile_0045.png")
const right_heart = preload("res://assets/tile_0045_reversed.png")
@onready var sprite_2d: Sprite2D = $Area2D/Sprite2D
@onready var heart_box: HBoxContainer = %HeartBox


func _ready() -> void:
	sprite_2d.texture = left_heart if heart_type == HeartType.LEFT else right_heart


func _on_area_2d_body_entered(body: Node2D) -> void:
	var taken = false
	if body.is_in_group("player"):
		taken = body.take_heart(heart_type)
	if taken:
		heart_box.add_heart()
		queue_free()
