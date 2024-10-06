extends Area2D

@export var id: int = 0
var canUse:bool = false
@onready var animated_sprite_2d = $AnimatedSprite2D

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if canUse && Input.is_action_just_pressed("Action"):
		animated_sprite_2d.play("Pull")
		
		GameManager.lever_pulled.emit(id)
		


func _on_body_entered(body):
	if body is Player:
		canUse = true


func _on_body_exited(body):
	if body is Player:
		canUse = false
