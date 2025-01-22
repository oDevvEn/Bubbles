extends Area2D


@onready var anim: AnimationPlayer = $AnimationPlayer
@onready var sprite_2d3: Sprite2D = $AnimationPlayer/Sprite2D
@onready var interactive_ui3: Area2D = $"."



func _ready() -> void:
	sprite_2d3.position = interactive_ui3.position




func _on_body_entered(body: Node2D) -> void:
	anim.play("interactiveUIopen")

func _on_body_exited(body: Node2D) -> void:
	anim.play("interactiveUIclose")
