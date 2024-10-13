extends Area2D

var colors = []

var colorIndex = 0

var canUse: bool = false

func _ready() -> void:
	colors.append(Color(1,0,0,1))
	colors.append(Color(0,1,0,1))
	colors.append(Color(0,0,1,1))
	colors.append(Color(1,0,1,1))
	colors.append(Color(1,1,0,1))
	# 1,3,0,4

func _process(delta: float) -> void:
	if canUse && Input.is_action_just_pressed("Action"):
		colorIndex = (colorIndex + 1) % colors.size()
		
		modulate = colors[colorIndex]
		
		GameManager.statue_color_change.emit()

func _on_body_entered(body: Node2D) -> void:
	if body is Player:
		canUse = true

func _on_body_exited(body: Node2D) -> void:
	if body is Player:
		canUse = false
