extends Area2D

@export var destination: Vector2
@onready var gpu_particles_2d = $GPUParticles2D
@onready var point_light_2d = $PointLight2D

var canTeleport = false;

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if canTeleport && Input.is_action_just_pressed("Action"):
		GameManager.lastTeleportPosition = destination
		GameManager.player.global_position = destination


func _on_body_entered(body):
	if body is Player:
		gpu_particles_2d.emitting = true
		point_light_2d.enabled = true
		canTeleport = true


func _on_body_exited(body):
	if body is Player:
		canTeleport = false
