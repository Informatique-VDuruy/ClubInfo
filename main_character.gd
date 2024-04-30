extends CharacterBody2D

@onready var playerSprite = $AnimatedSprite2D

const SPEED = 300.0
const JUMP_VELOCITY = -400.0

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")


func _physics_process(delta):
		
	if (velocity.x > 1 || velocity.x < -1) :
		playerSprite.play("running")
	
	if velocity.x == 0 and is_on_floor() :
		playerSprite.play("default")

	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta

	# Handle jump.
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction = Input.get_axis("go_left", "go_right")
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()
	
	if velocity.x > 1 :
		playerSprite.flip_h = false
	elif velocity.x < -1 :
		playerSprite.flip_h = true
