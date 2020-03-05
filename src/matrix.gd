extends TileMap

# var giveme = BlockColor.GRAY

export var width = 10
export var height = 20
export var ghost_height = 20

var tile_size = cell_size
var grid_size = Vector2(width, height + ghost_height)
var matrix_content = []

func _ready():
	pass
	
func move_ok():
	pass

# Processes the movement of the cluster
func process_move(cluster, move):
	pass

func rotate_ok():
	pass

func process_rotate(cluster, rotation):
	pass
