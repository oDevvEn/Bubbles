extends Area2D


@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var sprite_2d: Sprite2D = $AnimationPlayer/Sprite2D
@onready var interactive_ui: Area2D = $"."


func _ready() -> void:
	sprite_2d.position = interactive_ui.position


func _on_body_entered(body: Node2D) -> void:
	animation_player.play("interactiveUIopen")
	

func _on_body_exited(body: Node2D) -> void:
	animation_player.play("interactiveUIclose")
