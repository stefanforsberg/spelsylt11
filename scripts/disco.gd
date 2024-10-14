extends Node2D

@onready var line_2d = $Line2D
@onready var line_2d2 = $Line2D2
@onready var line_2d3 = $Line2D3
@onready var line_2d4 = $Line2D4

# Called when the node enters the scene tree for the first time.
func _ready():
	tweenLazer1(line_2d)
	tweenLazer1(line_2d2)
	tweenLazer1(line_2d3)
	tweenLazer1(line_2d4)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	
func tweenLazer1(line: Line2D):
	var tween = create_tween()
	tween.set_parallel(true)
	
	if line.width != 5:
		tween.tween_property(line, "self_modulate", Color(2, 2, 2, 2), 0.4)
		tween.tween_property(line, "width", 5, 0.3)
	else:
		tween.tween_property(line, "self_modulate", Color(1, 1, 1, 1), 0.4)
		tween.tween_property(line, "width", 1, 0.3)
 	
	await get_tree().create_timer(randf()*2).timeout
	
	tweenLazer1(line)
	
