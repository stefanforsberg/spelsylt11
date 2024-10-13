extends RigidBody2D
class_name Pillar
@export var id:int = 0
var original_position: Vector2

func _ready():
	original_position = global_position
	GameManager.lever_pulled.connect(reset)

func reset(group_id: int):
	print(id, group_id)
	
	if id == group_id:
		global_position = original_position
		linear_velocity = Vector2(0,0)

func _process(delta):
	pass
