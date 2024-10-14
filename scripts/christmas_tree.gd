extends Node2D
@onready var light_1 = $Light1
@onready var light_2 = $Light2
@onready var light_3 = $Light3
@onready var light_5 = $Light5
@onready var light_4 = $Light4
@onready var light_6 = $Light6
@onready var light_7 = $Light7
@onready var light_8 = $Light8
@onready var light_9 = $Light9
@onready var light_10 = $Light10
@onready var disco = $Disco

var collectedLights = 0

var positions = []
# Called when the node enters the scene tree for the first time.
func _ready():
	positions.push_front(light_1.global_position)
	positions.push_front(light_2.global_position)
	positions.push_front(light_3.global_position)
	positions.push_front(light_4.global_position)
	positions.push_front(light_5.global_position)
	positions.push_front(light_6.global_position)
	positions.push_front(light_7.global_position)
	positions.push_front(light_8.global_position)
	positions.push_front(light_9.global_position)
	positions.push_front(light_10.global_position)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_area_2d_body_entered(body):
	if body is Player:
		
		for light in body.collected_lights:
			light.global_position = body.global_position
			
			create_tween().tween_property(light, "global_position", positions[light.id], 1)
			
			collectedLights += 1
			
			light.visible = true
			
			GameManager.collectedLights.push_back(light.id)
			
		body.collected_lights = []
		
		
		if collectedLights == 10:
			disco.visible = true
		
		GameManager.collectedLightsLabel.text = "%s / %s" % [str(GameManager.collectedLights.size()).pad_zeros(2), "10"]


func _on_area_2d_body_exited(body):
	pass
