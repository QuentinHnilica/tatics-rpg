extends Node

var player : OW_Pawn
var cam : TacticsCamera
var grid : GridMap

# Called when the node enters the scene tree for the first time.
func _ready():
	player = $Pawn
	cam = $TacticsCamera
	grid = $GridMap
	player.config_player(cam, grid)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

