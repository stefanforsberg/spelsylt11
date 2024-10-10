extends Area2D
@export var labelText: String = ""

@onready var label = $ColorRect/Label

@onready var color_rect = $ColorRect


# Called when the node enters the scene tree for the first time.
func _ready():
	label.text = labelText 


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_body_entered(body):
	if body is Player:
		color_rect.visible = true


func _on_body_exited(body):
	if body is Player:
		color_rect.visible = false
