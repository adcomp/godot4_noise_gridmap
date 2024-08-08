extends Node3D

@export var noise : FastNoiseLite
@export var grid_row : int = 100
@export var grid_col : int = 100

@onready var gridmap : GridMap = $GridMap


func _ready():
	_create_grid()


func _create_grid():
	for col in grid_col:
		for row in grid_row:
			
			# get noise value .. return value [-1 .. 1 ]
			var n = noise.get_noise_2d(col, row)
			
			# convert noise to something we can work with ... like gridmap ID
			var id = _get_biome(n)
			
			# define height ..
			var y = remap(n, -1, 1, 0, 16) * .35
			
			# this is the tile position
			var pos = Vector3i(col, y, row)
			
			# and set the tile to the gridmap
			gridmap.set_cell_item(pos, id)


func _get_biome(noise_val: float) -> int:
	if noise_val < -.5: # water
		return 0
	elif noise_val < -.3: # sand
		return 1
	elif noise_val < -.1: # dirt
		return 2
	elif noise_val < .4: # grass
		return 3
	else:
		return 4	# rock
