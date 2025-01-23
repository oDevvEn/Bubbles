extends Sprite2D

const retractSpeed : float = 2000
const castPower : float = 600

var heldTime : float = 0
var cast : bool = false
var colliding : bool = false
var special : bool = false
var catching : bool = false
var retracting : bool = false
var elapsedTime : float = 0

@onready var player : CharacterBody2D = get_parent()
@onready var playerSprite : AnimatedSprite2D = player.get_node("AnimatedSprite2D")
@onready var progressBar : ProgressBar = $CanvasLayer/ProgressBar
@onready var bobber : RigidBody2D = $Bobber
@onready var bobberCollider : CollisionShape2D = $Bobber/BobberCollider

@onready var bobberTip : Marker2D = $Bobber/BobberTip
@onready var rodTip : Marker2D = $FishingRodTip
@onready var line : Line2D = $FishingLine

@onready var raycast : RayCast2D = $Bobber/RayCast2D
@onready var castTimer : Timer = $CastTime
@onready var bubbles : GPUParticles2D = $Bobber/BubbleParticles

# fish texture: 1 in every [] times
@onready var fish : Dictionary = {
	"Cod": [load("res://assets/fish/Cod.png"), 										   Vector2(-250,  55)], # 50%
	"JewelCichild": [load("res://assets/fish/JewelCichild.png"), 					   Vector2(-210,  40)], # 20%
	"CopperbandButterflyfish": [load("res://assets/fish/CopperbandButterflyfish.png"), Vector2(-100, -32)], # 15%
	"Clownfish": [load("res://assets/fish/Clownfish.png"), 	 						   Vector2(-150,  40)], # 10%
	"PurpleTang": [load("res://assets/fish/PurpleTang.png"), 						   Vector2(-185, - 8)], #  5%
}
@onready var crab = load("res://assets/crab.png")
@onready var attatchedFish : Sprite2D = $Bobber/AttatchedFish

func _process(delta: float) -> void:
	# Retract initialiser
	if Input.is_action_just_pressed("interact") and cast:
		retracting = true
		cast = false
		elapsedTime = 0
			
		if catching:
			if special:
				attatchedFish.texture = crab
				attatchedFish.offset = Vector2(-160, 0)

			else:
				var choice : float = randf_range(0, 100)
				var stats : Array
				if choice > 50:
					stats = fish["Cod"]
				elif choice > 30:
					stats = fish["JewelCichild"]
				elif choice > 15:
					stats = fish["CopperbandButterflyfish"]
				elif choice > 5:
					stats = fish["Clownfish"]
				else:
					stats = fish["PurpleTang"]
				
				attatchedFish.texture = stats[0]
				attatchedFish.offset = stats[1]
			attatchedFish.visible = true
		catching = false

	# Casting
	if Input.is_action_pressed("interact") and not cast and not retracting:
		heldTime += delta
		heldTime = clamp(heldTime, 0, 2)
		progressBar.value = heldTime * 50
		progressBar.visible = true

	# Cast
	elif (heldTime != 0):
		cast = true
		progressBar.visible = false
		attatchedFish.visible = false
		bobber.visible = true
		line.visible = true
		bobberCollider.disabled = false

		bobber.global_transform.origin = rodTip.global_position + offset * scale
		bobber.linear_velocity = Vector2(-heldTime * castPower * (int(playerSprite.flip_h) * 2 - 1), -heldTime * castPower/3)
		
		heldTime = 0

	# Cast Time
	if cast:
		var collision : Object = raycast.get_collider()
		if collision and not colliding:
			if collision.get_collision_mask_value(4):
				special = true
			colliding = true
			castTimer.wait_time = randf_range(5, 10)
			castTimer.start()
	
	# Retracting handler
	if retracting:
		if (bobber.global_position + bobberTip.position).distance_to(rodTip.global_position + offset * scale) > 20 and elapsedTime < 5:
			elapsedTime += delta
			bobber.linear_velocity = (bobber.global_position + bobberTip.position).direction_to(rodTip.global_position + offset * scale) * retractSpeed
		else:
			retracting = false
			if special:
				special = false 
				player.crabbed = true
			bobber.visible = false
			line.visible = false
			bobberCollider.disabled = true
			colliding = false
			bubbles.emitting = false
			castTimer.stop()



	# LINE update
	if cast or retracting:
		line.points = [rodTip.global_position + offset * scale, bobber.global_position + bobberTip.position]


	# Rod flip update
	flip_h = playerSprite.flip_h 
	offset.x = abs(offset.x) * (int(flip_h) * -2 + 1)
	rodTip.position.x = abs(rodTip.position.x) * (int(flip_h) * -2 + 1)

func _on_cast_time_timeout() -> void:
	if not catching and (not special or (special and not player.crabbed)):
		catching = true
		bubbles.emitting = true
		castTimer.wait_time = randf_range(2, 4)
		castTimer.start()
	else:
		catching = false
		bubbles.emitting = false
		castTimer.wait_time = randf_range(20, 40)
		castTimer.start()
