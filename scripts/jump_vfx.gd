extends AnimatedSprite2D
@onready var animated_sprite_2d = $AnimatedSprite2D

func _ready():
	play("default")
	animated_sprite_2d.play("default")

func _process(delta):
	if !is_playing():
		animated_sprite_2d.queue_free()
		queue_free()
