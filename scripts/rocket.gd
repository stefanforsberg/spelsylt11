extends Area2D

@onready var line_2d = $Line2D

var direction = 0.5
var min_angle = 180
var max_angle = 360
var canShoot = false

var tween


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	line_2d.rotation_degrees += direction
 	
	if line_2d.rotation_degrees >= max_angle:
		line_2d.rotation_degrees = max_angle
		direction = -1*direction  # Reverse the direction
		
	if line_2d.rotation_degrees <= min_angle:
		line_2d.rotation_degrees = min_angle
		direction = -1*direction  # Reverse the direction
		
	if canShoot && Input.is_action_just_pressed("Action"):
		
		if line_2d.rotation_degrees > 310 && line_2d.rotation_degrees < 330:
			GameManager.secret_lazer.emit()
		
		tween = create_tween().tween_property(line_2d, "self_modulate", Color(15, 3, 3, 3), 0.1)
		tween.connect("finished", tweenLazer)


func tweenLazer():
	tween = create_tween().tween_property(line_2d, "self_modulate", Color(1, 1, 1, 1), 0.3)

func _on_body_entered(body):
	if body is Player:
		canShoot = true;


func _on_body_exited(body):
	if body is Player:
		canShoot = false;
