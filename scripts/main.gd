extends Node2D


func _on_area_2d_body_entered(body):
	if body is Player:
		GameManager.player.global_position = GameManager.lastTeleportPosition
