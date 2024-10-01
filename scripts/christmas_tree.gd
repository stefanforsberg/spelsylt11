extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_area_2d_body_entered(body):
	if body is Player:
		var tween = create_tween()
		tween.tween_property(GameManager.camera, "zoom", Vector2(1.5, 1.5), 1)
		#tween.tween_property($Sprite, "position",# Vector2(200, 300), 1)
		
		#create_tween().tween_property(GameManager.camera, "zoom", Vector2(2, 2), Vector2(1.5, 1.5), 1.0, Tween.TransitionType.TRANS_LINEAR, Tween.EaseType.IN_OUT)
		
		#GameManager.camera.zoom.x = 1.5
		#GameManager.camera.zoom.y = 1.5
		
		for light in body.collected_lights:
			light.global_position = body.global_position
			create_tween().tween_property(light, "global_position", global_position, 1)
			# light.global_position = global_position
			light.visible = true


func _on_area_2d_body_exited(body):
	var tween = create_tween()
	tween.tween_property(GameManager.camera, "zoom", Vector2(2, 2), 1)
