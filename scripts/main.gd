extends Node2D
@onready var collected_lights = $CanvasLayer/Control/CollectedLights
@onready var key_0 = $CanvasLayer/Control/Key0
@onready var key_1 = $CanvasLayer/Control/Key1

func _ready():
	GameManager.collectedLightsLabel = collected_lights
	GameManager.key_collected.connect(collect_key)

func _on_area_2d_body_entered(body):
	if body is Player:
		GameManager.reset()

func collect_key(id):
	GameManager.collectedKeys.append(id)
	
	if id == 0: 
		key_0.visible = true
		
	if id == 1: 
		key_1.visible = true
 
