extends Sprite2D

var heldTime : float = 0
var cast : bool = false
var canCast : bool = true
var colliding : bool = false
var catching : bool = false

@onready var playerSprite : AnimatedSprite2D = get_parent().get_node("AnimatedSprite2D")
@onready var progressBar : ProgressBar = $CanvasLayer/ProgressBar
@onready var bobber : RigidBody2D = $Bobber
@onready var bobberCollider : CollisionShape2D = $Bobber/BobberCollider

@onready var bobberTip : Marker2D = $Bobber/BobberTip
@onready var rodTip : Marker2D = $FishingRodTip
@onready var line : Line2D = $FishingLine

@onready var raycast : RayCast2D = $Bobber/RayCast2D
@onready var castTimer : Timer = $CastTime
@onready var bubbles : GPUParticles2D = $Bobber/BubbleParticles

func _process(delta: float) -> void:
	# Retract
	if Input.is_action_just_pressed("interact"):
		if cast:
			cast = false
			canCast = false
			bobber.visible = false
			line.visible = false
			bobberCollider.disabled = true

			if catching:
				catching = false
				print("catched fishor dead body perhaps owo")

		elif not canCast:
			canCast = true

	# Casting
	if Input.is_action_pressed("interact") and canCast:
		heldTime += delta
		heldTime = clamp(heldTime, 0, 2)
		progressBar.value = heldTime * 50
		progressBar.visible = true

	# Cast
	elif (heldTime != 0):
		cast = true
		progressBar.visible = false
		bobber.visible = true
		line.visible = true
		bobberCollider.disabled = false

		bobber.global_transform.origin = rodTip.global_position + offset * scale
		bobber.linear_velocity = Vector2(-heldTime * 500 * (int(playerSprite.flip_h) * 2 - 1), -heldTime * 100)
		
		heldTime = 0

	if cast:
		# LINE update
		line.points = [rodTip.global_position + offset * scale, bobber.global_position + bobberTip.position]

		# Cast Time
		var collision : Object = raycast.get_collider()
		if collision and not colliding:
			colliding = true
			castTimer.wait_time = randf_range(1, 3)
			castTimer.start()

	# Rod flip update
	flip_h = playerSprite.flip_h 
	offset.x = abs(offset.x) * (int(flip_h) * -2 + 1)
	rodTip.position.x = abs(rodTip.position.x) * (int(flip_h) * -2 + 1)

func _on_cast_time_timeout() -> void:
	if not catching:
		catching = true
		bubbles.emitting = true
		castTimer.wait_time = randf_range(2, 4)
	else:
		catching = false
		bubbles.emitting = false
		castTimer.wait_time = randf_range(20, 40)













