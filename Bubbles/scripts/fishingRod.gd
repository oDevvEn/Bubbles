extends Sprite2D

var heldTime : float = 0
var cast : bool = false
var canCast : bool = true

@onready var playerSprite : AnimatedSprite2D = get_parent().get_node("AnimatedSprite2D")
@onready var progressBar : ProgressBar = $CanvasLayer/ProgressBar
@onready var bobber : RigidBody2D = $Bobber

@onready var bobberTip : Marker2D = $Bobber/BobberTip
@onready var rodTip : Marker2D = $FishingRodTip
@onready var line : Line2D = $FishingLine

func _process(delta: float) -> void:
	# Retract
	if Input.is_action_just_pressed("interact"):
		if cast:
			cast = false
			canCast = false
			bobber.visible = false
			line.visible = false
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

		bobber.global_transform.origin = rodTip.global_position
		bobber.linear_velocity = Vector2(-heldTime * 500 * (int(playerSprite.flip_h) * 2 - 1), -heldTime * 100)
		
		heldTime = 0

	# LINE update
	if cast:
		line.points = [rodTip.global_position, bobber.global_position + bobberTip.position]

	flip_h = playerSprite.flip_h
	rodTip.position.x = abs(rodTip.position.x) * (int(flip_h) * -2 + 1)

