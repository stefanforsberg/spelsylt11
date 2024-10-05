extends Node2D
@export var id = 0
@export var color:Color
@onready var door = $Door
@onready var locked_door = $Door/LockedDoor
@onready var key = $Door/Key

var active = true

# Called when the node enters the scene tree for the first time.
func _ready():
	key.modulate = color


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_key_detection_body_entered(body):
	if !active:
		return
	
	if body is Player:
		print(GameManager.collectedKeys)
		if GameManager.collectedKeys.any(func(number): return id == number):
			print("open")
			active = false
			door.set_collision_layer_value(1,false)
			
			
			var tween = get_tree().create_tween();
			await tween.tween_method(set_shader_value, 1.0, 0.0, 1)
			key.visible = false
			
			
			#door.visible = false
func set_shader_value(value: float):
	# in my case i'm tweening a shader on a texture rect, but you can use anything with a material on it
	locked_door.material.set_shader_parameter("DissolveValue",value)
