extends Node

var camera:Camera2D
var player:Player
var startPosition:Vector2
var collectedLightsLabel:Label
var collectedLights = []
var collectedKeys = []
var portalPositions = []
var portalPosition = 0

signal key_collected(id:int)
signal lever_pulled(id:int)
signal secret_lazer()

func SpawnVFX(vfxToSpawn: Resource, position: Vector2):
	var vfxInstance = vfxToSpawn.instantiate()
	vfxInstance.global_position = position
	get_tree().get_root().get_node("Root").add_child(vfxInstance)
	
	return vfxInstance
	
func reset():
	GameManager.player.velocity = Vector2(0,0)
	
	GameManager.player.global_position = startPosition if portalPositions.size() == 0 else portalPositions[portalPosition]
	
func teleport():
	GameManager.player.global_position = portalPositions[portalPosition]
	
	portalPosition = (portalPosition + 1) % portalPositions.size()
