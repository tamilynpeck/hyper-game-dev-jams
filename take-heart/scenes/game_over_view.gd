extends Control

@onready var heart_box: HBoxContainer = $VBoxContainer/HeartBox
@onready var label: Label = $VBoxContainer/Label


func _ready() -> void:
	visible = false
	Events.game_over_score.connect(_show_game_over_view)
	Events.game_win.connect(_show_game_win_view)
	
func _on_restart_button_pressed() -> void:
	get_tree().paused = false
	get_tree().reload_current_scene()
	#visible = false


func _show_game_over_view(score: float):
	print(str("game over ", score))
	heart_box.set_hearts(score)
	visible = true


func _show_game_win_view(score: float):
	print(str("game win ", score))
	label.text = "All Hearts Taken!"
	heart_box.set_hearts(score)
	visible = true
