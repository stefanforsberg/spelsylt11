extends Node

var camera:Camera2D
var player:Player
var lastTeleportPosition:Vector2
var collectedLightsLabel:Label
var collectedLights = []
var collectedKeys = []

signal key_collected(id:int)
