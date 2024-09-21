extends HBoxContainer

const FULL_HEART = preload("res://scenes/full_heart.tscn")
const HALF_HEART = preload("res://scenes/half_heart.tscn")

var heart_number: float = 0


func _ready() -> void:
	clear_hearts()


func set_hearts(score: float):
	heart_number = score

	clear_hearts()
	generate_hearts()


func add_heart():
	heart_number += .5
	if int(heart_number) == 7:
		visible = false
		get_tree().paused = true
		Events.game_win.emit(7)
	clear_hearts()
	generate_hearts()


func clear_hearts():
	for x in get_children():
		x.queue_free()


func generate_hearts():	
	var whole = int(heart_number)
	var half = heart_number - whole
	for i in whole:
		var heart = FULL_HEART.instantiate()
		add_child(heart)
	if half > 0: 
		var half_heart = HALF_HEART.instantiate()
		add_child(half_heart)
	print("HEART BOX UPDATE")
	print(str("whole ", whole))
	print(str("half ", half))
