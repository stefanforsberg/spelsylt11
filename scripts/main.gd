extends Node2D
@onready var collected_lights = $CanvasLayer/Control/CollectedLights
@onready var key_0 = $CanvasLayer/Control/Key0
@onready var key_1 = $CanvasLayer/Control/Key1

@onready var cl_7 = $ChristmasLights/Cl7
@onready var christmas_light = $CanvasLayer/Control/ChristmasLight

func _ready():
	GameManager.collectedLightsLabel = collected_lights
	GameManager.key_collected.connect(collect_key)
	GameManager.secret_lazer.connect(secret_lazer_lightbulb)

func _on_area_2d_body_entered(body):
	if body is Player:
		GameManager.reset()

func collect_key(id):
	GameManager.collectedKeys.append(id)
	
	if id == 0: 
		key_0.visible = true
		
	if id == 1: 
		key_1.visible = true
 
func secret_lazer_lightbulb():
	if christmas_light.visible:
		christmas_light.visible = false
		cl_7.visible = true
		create_tween().tween_property(cl_7, "position", Vector2(3124,-281), 0.1)
