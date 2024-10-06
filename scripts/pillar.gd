extends RigidBody2D
@onready var static_body_2d = $StaticBody2D

@export var id:int = 0
var original_position: Vector2

# Called when the node enters the scene tree for the first time.
func _ready():
	original_position = global_position
	GameManager.lever_pulled.connect(reset)

func reset(group_id: int):
	if id == group_id:
		static_body_2d.constant_linear_velocity = Vector2(0,0)
		global_position = original_position

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
