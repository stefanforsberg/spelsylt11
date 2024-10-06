extends Node2D
@onready var timer = $Timer
@onready var area_2d = $Area2D

@export var min:Vector2
@export var max:Vector2
@export var time:int = 1
@export var delay:int = 1
var dir = 1
var isWaiting = false
@onready var line_2d = $Line2D

# Called when the node enters the scene tree for the first time.
func _ready():
	line_2d.add_point(min)
	line_2d.add_point(max)
	
	move()

func move():
	var t = create_tween()

	await create_tween().set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_IN_OUT).tween_property(area_2d, "position", max if dir == 1 else min, 1).finished
	dir = 1 if dir == 0 else 0
	isWaiting = true
	timer.start(delay)
	await timer.timeout
	isWaiting = false
	move()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if !isWaiting:
		area_2d.rotation_degrees+=2


func _on_area_2d_body_entered(body):
	if body is Player:
		GameManager.reset()
