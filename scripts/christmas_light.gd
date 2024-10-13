class_name ChristmasLight extends Node2D

@onready var area_2d = $Area2D
@export var id: float = 0
@onready var audio_stream_player: AudioStreamPlayer = $AudioStreamPlayer

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_area_2d_body_entered(body):
	if body is Player:
		audio_stream_player.play()
		area_2d.set_collision_mask_value(1,false)
		body.add_light(self)
