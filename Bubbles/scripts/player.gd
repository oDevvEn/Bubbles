extends CharacterBody2D


var crabbed : bool = false
@onready var sprite: AnimatedSprite2D = $PlayerSprite
@onready var col: CollisionShape2D = $CollisionShape2D
const SPEED = 300.0
const JUMP_VELOCITY = -400.0

func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Handle jump.
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction := Input.get_axis("moveLeft", "moveRight")
	
	if direction > 0:
		sprite.flip_h = false
		if(col.position.x < 0):
			col.position.x *= -1
	elif direction < 0:
		sprite.flip_h = true
		if(col.position.x > 0):
			col.position.x *= -1
	
	if direction:
		velocity.x = direction * SPEED
		sprite.play("walk")
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		sprite.pause()
	


	move_and_slide()
