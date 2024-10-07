extends Node2D
@onready var collected_lights = $CanvasLayer/Control/CollectedLights
@onready var key_0 = $CanvasLayer/Control/Key0

func _ready():
	GameManager.collectedLightsLabel = collected_lights
	GameManager.key_collected.connect(collect_key)

func _on_area_2d_body_entered(body):
	if body is Player:
		GameManager.player.global_position = GameManager.lastTeleportPosition

func collect_key(id):
	GameManager.collectedKeys.append(id)
	
	if id == 0: 
		key_0.visible = true
 
