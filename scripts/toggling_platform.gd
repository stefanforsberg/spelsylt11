extends StaticBody2D

@export var destruction_time: int = 3 
var timer: Timer
@onready var gpu_particles_2d = $GPUParticles2D
var is_destroying:bool = false
@onready var sprite_2d = $Sprite2D

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.
	# Create and configure the timer.
	timer = Timer.new()
	timer.wait_time = destruction_time
	timer.one_shot = true
	timer.connect("timeout", _on_timer_timeout)
	add_child(timer)
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _on_timer_timeout():
	if is_destroying:
		gpu_particles_2d.emitting = false
		set_collision_layer_value(1,false)
		sprite_2d.visible = false
		timer.start()
		is_destroying = false
		
	else:
		set_collision_layer_value(1,true)
		sprite_2d.visible = true

func _on_area_2d_body_entered(body):
	if body is Player && body.is_on_floor() && !is_destroying:
		gpu_particles_2d.emitting = true
		is_destroying = true
		timer.start()


func _on_area_2d_body_exited(body):
	if body is Player:
		pass
