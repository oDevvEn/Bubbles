extends Area2D

@onready var anim: AnimationPlayer = $AnimationPlayer


func _on_body_entered(body: Node2D) -> void:
	anim.play("interactiveUI")
