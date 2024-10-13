extends Area2D
class_name Door

@export var destination: Vector2
@onready var gpu_particles_2d = $GPUParticles2D
@onready var point_light_2d = $PointLight2D

var canTeleport = false;
var isActive = false

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if canTeleport && Input.is_action_just_pressed("Action"):
		GameManager.teleport()

func _on_body_entered(body):
	if body is Player:
		canTeleport = true
		gpu_particles_2d.emitting = true
		point_light_2d.enabled = true
		
		if !isActive:
			GameManager.portalPositions.append(global_position)
			GameManager.startPosition = global_position
			isActive = true

func _on_body_exited(body):
	if body is Player:
		canTeleport = false
