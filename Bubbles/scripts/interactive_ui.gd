extends Area2D

@onready var anim: AnimationPlayer = $AnimationPlayer
@onready var sprite_2d: Sprite2D = $AnimationPlayer/Sprite2D
@onready var interactive_ui: Area2D = $"."

func _ready() -> void:
	sprite_2d.position = interactive_ui.position


func _on_body_entered(body: Node2D) -> void:
	anim.play("interactiveUIopen")


func _on_body_exited(body: Node2D) -> void:
	anim.play("interactiveUIclose")
