extends Area2D

@onready var anim2: AnimationPlayer = $AnimationPlayer
@onready var sprite_2d2: Sprite2D = $AnimationPlayer/Sprite2D
@onready var interactive_ui2: Area2D = $"."


func _ready() -> void:
	sprite_2d2.position = interactive_ui2.position


func _on_body_entered(body: Node2D) -> void:
	anim2.play("interactiveUIopen")

func _on_body_exited(body: Node2D) -> void:
	anim2.play("interactiveUIclose")
