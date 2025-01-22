extends Node2D


@onready var anim: AnimationPlayer = $AnimationPlayer
@onready var timer: Timer = $Timer
@onready var main : Node2D = preload("res://scenes/main.tscn").instantiate()
var loaded : bool = false

func _on_new_button_pressed():
	buttonPressed()

func _on_load_button_pressed():
	loaded = true
	buttonPressed()
	

func buttonPressed():
	anim.play("fadeToBlack")
	timer.start()
	


func _on_timer_timeout():
	if loaded:
		main.loadGame()
	get_tree().root.add_child(main)
	get_tree().current_scene = main
	queue_free()
