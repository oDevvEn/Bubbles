extends Node2D


@onready var anim: AnimationPlayer = $AnimationPlayer
@onready var timer: Timer = $Timer

func _on_button_pressed():
	anim.play("fadeToBlack")
	timer.start()
	


func _on_timer_timeout():
	get_tree().change_scene_to_file("res://scenes/main.tscn")
