extends Node2D
@onready var collected_lights = $CanvasLayer/Control/CollectedLights
@onready var key_0 = $CanvasLayer/Control/Key0
@onready var key_1 = $CanvasLayer/Control/Key1
@onready var key_2 = $CanvasLayer/Control/Key2
@onready var audio_powerup: AudioStreamPlayer = $AudioPowerup

@onready var cl_7 = $ChristmasLights/Cl7
@onready var christmas_light = $CanvasLayer/Control/ChristmasLight

@onready var color_statue_1: Area2D = $Statues/color_statue_1
@onready var color_statue_2: Area2D = $Statues/color_statue_2
@onready var color_statue_3: Area2D = $Statues/color_statue_3
@onready var color_statue_4: Area2D = $Statues/color_statue_4
@onready var color_statue_door: StaticBody2D = $Statues/color_Statue_door

@onready var tree_fire = $PressurePlates/TreeFire
@onready var cl_9 = $ChristmasLights/Cl9

var lonelyStatueJumps = 0
var isCountingJumps = false

func _ready():
	GameManager.collectedLightsLabel = collected_lights
	GameManager.key_collected.connect(collect_key)
	GameManager.secret_lazer.connect(secret_lazer_lightbulb)
	GameManager.statue_color_change.connect(statue_color_change)

func _process(delta):
	if isCountingJumps && !cl_9.visible && Input.is_action_just_pressed("Up"):
		lonelyStatueJumps += 1
		
		if lonelyStatueJumps == 20:
			cl_9.visible = true
			create_tween().tween_property(cl_9, "position", Vector2(13, -645), 2)

func _on_area_2d_body_entered(body):
	if body is Player:
		GameManager.reset()

func collect_key(id):
	GameManager.collectedKeys.append(id)
	
	if id == 0: 
		key_0.visible = true
		
	if id == 1: 
		key_1.visible = true

	if id == 2: 
		key_2.visible = true
 
func secret_lazer_lightbulb():
	if christmas_light.visible:
		christmas_light.visible = false
		cl_7.visible = true
		create_tween().tween_property(cl_7, "position", Vector2(3124,-281), 0.1)

func statue_color_change():
	if color_statue_1.colorIndex == 1 && color_statue_2.colorIndex == 3 && color_statue_3.colorIndex == 0 && color_statue_4.colorIndex == 4:
		print("open")
		color_statue_door.set_collision_layer_value(1,false)
		color_statue_door.visible = false

func _on_powerup_double_jump_body_entered(body: Node2D) -> void:
	if body is Player:
		if !body.double_jump_enabled:
			audio_powerup.play()
			body.double_jump_enabled = true

func _on_pressure_plate_1_body_entered(body: Node2D) -> void:
	print(body)
	if body is Player && tree_fire.material.get_shader_parameter("integrity") > 0:
		get_tree().create_tween().tween_method(set_shader_value, 1.0, 0.0, 2);
		
		
func set_shader_value(value: float):
	print("int value", value)
	# in my case i'm tweening a shader on a texture rect, but you can use anything with a material on it
	tree_fire.material.set_shader_parameter("integrity",value)


func _on_lonely_statue_jump_area_body_entered(body):
	if body is Player:
		isCountingJumps = true

func _on_lonely_statue_jump_area_body_exited(body):
	if body is Player:
		isCountingJumps = false
		lonelyStatueJumps = 0
