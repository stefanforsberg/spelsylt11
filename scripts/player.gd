extends CharacterBody2D
class_name Player

@onready var animated_sprite_2d = $AnimatedSprite2D
@onready var camera_2d = $Camera2D

# Movement and Jump Parameters
@export var speed: float = 80.0
@export var jump_strength: float = 300.0
@export var gravity: float = 900.0
@export var max_fall_speed: float = 900.0
@export var coyote_time: float = 0.2
@export var double_jump_enabled: bool = false


# State tracking variables
var on_ground: bool = false
var coyote_timer: float = 0.0
var can_double_jump: bool = true
var has_jumped: bool = false 

# Enum for state machine
enum PlayerState { IDLE, RUNNING, JUMPING, FALLING, DOUBLE_JUMP }

# Current player state
var current_state: PlayerState = PlayerState.IDLE:
	set(value):
		
		if value == PlayerState.IDLE:
			animated_sprite_2d.play("Idle")
		elif value == PlayerState.JUMPING || value == PlayerState.DOUBLE_JUMP || value == PlayerState.FALLING:
			if animated_sprite_2d.animation != "Jump":
				animated_sprite_2d.play("Jump")
		else:
			animated_sprite_2d.play("Walk")
		
		current_state = value

func _ready():
	GameManager.camera = camera_2d
	GameManager.player = self
	GameManager.lastTeleportPosition = global_position

# Jump function
func jump():
	if on_ground or coyote_timer > 0.0 or !has_jumped:
		velocity.y = -jump_strength
		on_ground = false
		coyote_timer = 0.0
		current_state = PlayerState.JUMPING
		has_jumped = true

# Double Jump function
func double_jump():
	print("double jumping",velocity.y)
	
	velocity.y = -jump_strength
	can_double_jump = false
	current_state = PlayerState.DOUBLE_JUMP

# State machine logic
func _physics_process(delta):

	# Apply gravity
	if not on_ground:
		velocity.y += gravity * delta
		velocity.y = min(velocity.y, max_fall_speed)

	# Input handling for horizontal movement
	var direction = 0.0
	if Input.is_action_pressed("Right"):
		direction = 1.0
	elif Input.is_action_pressed("Left"):
		direction = -1.0
		
	if Input.is_action_just_pressed("Down"):
		position.y +=3
		
	if Input.is_action_just_pressed("Up"):
		
		match current_state:
			PlayerState.IDLE, PlayerState.RUNNING:
				jump()
			PlayerState.FALLING, PlayerState.JUMPING:
				print("Not jumping from ground")
				if !has_jumped:
					print("Jump because has not jumped")
					jump()
				elif can_double_jump and double_jump_enabled:
					print("Double jump")
					double_jump()
	
	velocity.x = direction * speed

	# State transitions
	match current_state:
		PlayerState.IDLE:
			if abs(velocity.x) > 0.0:
				current_state = PlayerState.RUNNING
			if not on_ground:
				current_state = PlayerState.FALLING
		PlayerState.RUNNING:
			if not on_ground:
				current_state = PlayerState.FALLING
			if abs(velocity.x) == 0.0:
				current_state = PlayerState.IDLE
		PlayerState.JUMPING:
			if velocity.y > 0.0:
				current_state = PlayerState.FALLING
		PlayerState.FALLING:
			if on_ground:
				current_state = PlayerState.IDLE
		PlayerState.DOUBLE_JUMP:
			if velocity.y > 0.0:
				current_state = PlayerState.FALLING

	# Coyote time logic
	if not on_ground:
		coyote_timer = max(coyote_timer - delta, 0.0)
	else:
		coyote_timer = coyote_time
		can_double_jump = true
		has_jumped = false

	if velocity.x < 0 && !animated_sprite_2d.flip_h:
		animated_sprite_2d.flip_h = true
	elif velocity.x > 0 && animated_sprite_2d.flip_h:
		animated_sprite_2d.flip_h = false

	# Move and update physics
	move_and_slide()
	on_ground = is_on_floor()
	
	# Reset jump if grounded
	if on_ground:
		can_double_jump = true
		has_jumped = false
		
	if animated_sprite_2d.animation == "Jump" && animated_sprite_2d.frame == 11:
		animated_sprite_2d.frame = 6

var collected_lights = []

func add_light(light: ChristmasLight):
	light.visible = false
	collected_lights.push_front(light)
	
