extends CharacterBody2D


const JUMP_VELOCITY = -250.0
const SPEED = 100.0
const ROTATION_SPEED = 20.0
const MAX_ROTATION_UP: float = -0.3 
const MAX_ROTATION_DOWN: float = 0.5

func _physics_process(delta: float) -> void:
	velocity += get_gravity() * delta
	velocity.x = SPEED
	# Handle jump.
	if Input.is_action_just_pressed("flap"):
		velocity.y = JUMP_VELOCITY
		
	rotate_bird(delta)
	move_and_slide()
	
	
func rotate_bird(delta: float) -> void:
	var roation_direction = MAX_ROTATION_UP if velocity.y < 0 else MAX_ROTATION_DOWN
	rotation = lerp(rotation, roation_direction, ROTATION_SPEED * delta)
