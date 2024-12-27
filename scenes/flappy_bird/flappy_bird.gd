extends CharacterBody2D

@onready var animation = $AnimatedSprite2D
@onready var wing_audio = $WingAudio
@onready var hit_audio = $HitAudio

const JUMP_VELOCITY = -250.0
const SPEED = 100.0
const ROTATION_SPEED = 20.0
const MAX_ROTATION_UP: float = -0.3 
const MAX_ROTATION_DOWN: float = 0.5

func _ready() -> void:
	Events.connect("player_died", Callable(self, "on_player_died"))
	
func _process(_delta: float) -> void:
	if not Globals.running:
		animation.stop()
		return;
	if Input.is_action_just_pressed("flap"):
		wing_audio.play()

func _physics_process(delta: float) -> void:
	if not Globals.running:
		return
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

func on_player_died() -> void:
	hit_audio.play()
