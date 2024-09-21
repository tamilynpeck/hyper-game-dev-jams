extends CharacterBody2D

var move_speed: float = 100.0
var jump_force: float = 200.0
var gravity: float = 500.0
var score: int = 0

var hearts: Array = []
@onready var heart_box: HBoxContainer = %HeartBox

#@onready var score_label: Label = %ScoreLabel

func _physics_process(delta: float) -> void:
	if not is_on_floor():
		velocity.y += gravity * delta
	
	velocity.x = 0
	if Input.is_action_pressed("left"):
		velocity.x -= move_speed
	if Input.is_action_pressed("right"):
		velocity.x += move_speed
	if Input.is_key_pressed(KEY_SPACE) and is_on_floor():
		velocity.y = -jump_force
	
	move_and_slide()
	
	if global_position.y > 160:
		game_over()


func game_over():
	heart_box.visible = false
	get_tree().paused = true
	
	Events.game_over_score.emit(hearts.size() * .5)


func take_heart(new_heart) -> bool:
	if hearts.size() == 0 and new_heart == HeartPiece.HeartType.LEFT:
		hearts.append(new_heart)
		return true
	elif hearts.size() == 0:
		return false
	
	var last_heart = hearts.back() as HeartPiece.HeartType
	if last_heart != new_heart:
		hearts.append(new_heart)
		return true
	return false
