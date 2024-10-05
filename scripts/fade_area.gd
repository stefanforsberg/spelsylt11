extends Area2D


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_body_entered(body):
	if body is Player:
		var parent = self.get_parent()
		if parent:
			var tween = get_tree().create_tween()
			tween.tween_method(fade_in_hidden, 1.0, 0.0, 0.1)
			# parent.modulate.a = 0.00


func _on_body_exited(body):
	if body is Player:
		var parent = self.get_parent()
		if parent:
			var tween = get_tree().create_tween().tween_method(fade_in_hidden, 0.0, 1.0, 0.3)
			

			#parent.modulate.a = 1
			
func fade_in_hidden(value:float):
	self.get_parent().modulate.a = value
	
