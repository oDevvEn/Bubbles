extends CollisionShape2D


@onready var anim: AnimationPlayer = $AnimationPlayer
@onready var timer: Timer = $Timer
@onready var player: CharacterBody2D = %player
var inCollider = false

func _process(delta: float) -> void:
	if Input.is_action_pressed("interact") && inCollider == true:
		timer.start()
		anim.play("fadeBlack")
	

func _on_timer_timeout():
	player.position = Vector2(-550000, 0)
	


func _on_interactive_ui_2_body_entered(body: Node2D) -> void:
	inCollider = true

func _on_interactive_ui_2_body_exited(body: Node2D) -> void:
	inCollider = false
