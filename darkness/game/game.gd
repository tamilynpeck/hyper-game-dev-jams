extends Node2D

@onready var darkness_layer: ColorRect = %DarknessLayer
@onready var magic_button: TextureButton = %MagicButton
@onready var score_label: Label = %ScoreLabel
@onready var clicks_label: Label = %ClicksLabel
@onready var portal_button: TextureButton = %PortalButton
@onready var sun_button: TextureButton = %SunButton
@onready var win_label: Label = %WinLabel
@onready var final_score_label: Label = %FinalScoreLabel


var darkness_collected: float = 0
var clicks_remaining: int = 100

func _ready() -> void:
	win_label.visible = false
	final_score_label.visible = false
	update_darkness_layer()


func update_darkness_layer():
	var transperancy = darkness_collected / 255.0
	var color = Color(0, 0, 0, transperancy)
	print("set transperancy ", transperancy)
	darkness_layer.color = color
	
	magic_button.disabled = true if darkness_collected >= 255 or clicks_remaining == 0 else false
	portal_button.disabled = true if clicks_remaining == 0 else false
	sun_button.disabled = true if darkness_collected == 0 else false
	
	score_label.text = "Score: %s" % darkness_collected
	clicks_label.text = "Clicks Remaining: %s" % clicks_remaining
	
	
	if darkness_collected == 255:
		win_condition()
	if clicks_remaining <= 0:
		fail_condition()

func set_darkness(amount):
	darkness_collected = clampf(amount, 0, 255)
	update_darkness_layer()	


func increase_darkness(amount):
	darkness_collected = clampf(darkness_collected + amount, 0, 255)
	update_darkness_layer()


func decrease_darkness(amount):
	increase_darkness(-amount)


func _on_sun_button_pressed() -> void:
	clicks_remaining = clicks_remaining + 10
	increase_darkness(-5)


func _on_magic_button_pressed() -> void:
	clicks_remaining -= 1
	increase_darkness(1)


func _on_portal_button_pressed() -> void:
	var roll = randi_range(0, 255)
	clicks_remaining = clicks_remaining - 5
	set_darkness(roll)


func win_condition():
	score_label.visible = false
	clicks_label.visible = false
	win_label.text = "Darkness Achieved"
	win_label.visible = true
	final_score_label.text = "Final Score: \n %s" % (darkness_collected + clicks_remaining)
	final_score_label.visible = true
	
	magic_button.disabled = true 
	portal_button.disabled = true 
	sun_button.disabled = true


func fail_condition():
	score_label.visible = false
	clicks_label.visible = false
	win_label.text = "Darkness Not Achieved"
	win_label.visible = true
	final_score_label.text = "Final Score: \n %s" % 0
	final_score_label.visible = true
	
	magic_button.disabled = true 
	portal_button.disabled = true 
	sun_button.disabled = true
