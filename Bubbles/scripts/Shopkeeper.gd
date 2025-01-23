extends CollisionShape2D

var inCollider = false

func _process(delta: float) -> void:
	if Input.is_action_pressed("interact") && inCollider == true:
		pass
		



func _on_interactive_ui_body_entered(body: Node2D) -> void:
	inCollider = true

func _on_interactive_ui_body_exited(body: Node2D) -> void:
	inCollider = false
