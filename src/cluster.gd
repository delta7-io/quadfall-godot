extends TileMap

###      BEGIN DATA VALUES     ###

enum ClusterType {
	NONE = -1,
	L, J, S, Z, T, O, I
}
			
var CLUSTER_COLOR = {
	L = 2,
	J = 6,
	S = 4,
	Z = 1,
	T = 7,
	O = 3,
	I = 5
}

const CLUSTER_L = [
	[0, 0, 1],
	[1, 1, 1],
	[0, 0, 0]
]

const CLUSTER_J = [
	[1, 0, 0],
	[1, 1, 1],
	[0, 0, 0]
]

const CLUSTER_S = [
	[0, 1, 1],
	[1, 1, 0],
	[0, 0, 0]
]

const CLUSTER_Z = [
	[1, 1, 0],
	[0, 1, 1],
	[0, 0, 0]
]

const CLUSTER_T = [
	[0, 1, 0],
	[1, 1, 1],
	[0, 0, 0]
]

const CLUSTER_O = [
	[0, 1, 1],
	[0, 1, 1],
	[0, 0, 0]
]

const CLUSTER_I = [
	[0, 0, 0, 0, 0],
	[0, 0, 0, 0, 0],
	[0, 1, 1, 1, 1],
	[0, 0, 0, 0, 0],
	[0, 0, 0, 0, 0]
]

enum RotationState {
	ROT0, ROT90, ROT180, ROT270
}

func cluster_rotation(value):
	while value < 0:
		value += 4
		
		if value == 0:
			return RotationState.ROT0
		elif value == 1:
			return RotationState.ROT90
		elif value == 2:
			return RotationState.ROT180
		elif value == 3:
			return RotationState.ROT270
		else:
			return RotationState.ROT0

###      END DATA VALUES      ###

export(ClusterType) var cluster

var cluster_size = 3
var cluster_color = -1
var cluster_shape = []

var tile_size = cell_size
var grid_size = Vector2(cluster_size, cluster_size)

onready var matrix = get_parent()
onready var block_unit = preload("res://Block.tscn")

# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():

	if cluster == ClusterType.L:
		cluster_shape = CLUSTER_L
		cluster_color = CLUSTER_COLOR.L
	elif cluster == ClusterType.J:
		cluster_shape = CLUSTER_J
		cluster_color = CLUSTER_COLOR.J
	elif cluster == ClusterType.S:
		cluster_shape = CLUSTER_S
		cluster_color = CLUSTER_COLOR.S
	elif cluster == ClusterType.Z:
		cluster_shape = CLUSTER_Z
		cluster_color = CLUSTER_COLOR.Z
	elif cluster == ClusterType.T:
		cluster_shape = CLUSTER_T
		cluster_color = CLUSTER_COLOR.T
	elif cluster == ClusterType.O:
		cluster_shape = CLUSTER_O
		cluster_color = CLUSTER_COLOR.O
	elif cluster == ClusterType.I:
		cluster_size = 5
		cluster_shape = CLUSTER_I
		cluster_color = CLUSTER_COLOR.I
	else:
		pass

	var block_vectors = []
	for x in range(cluster_size):
		for y in range(cluster_size):
			if cluster_shape[x][y]:
				block_vectors.append(Vector2(y, x))

	for vec in block_vectors:
		var new_block = block_unit.instance()
		new_block.color = cluster_color
		new_block.position = map_to_world(vec)
		add_child(new_block)
		# new_block.set_color(cluster_color)

	# pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	var input = get_move()
	print_debug(input)

	var input_hold = Input.is_action_pressed("game_hold")
	if input_hold:
		print_debug("Hold")
	
	var input_rotate = get_rotation()
	print_debug(input_rotate)

func get_move():
	var input_x = 0
	if Input.is_action_pressed("game_right"):
		input_x += 1
	if Input.is_action_pressed("game_left"):
		input_x -= 1
	
	var input_y = 0
	if Input.is_action_pressed("game_drop"):
		input_y = 1
	if Input.is_action_pressed("game_harddrop"):
		input_y = -1
	
	return Vector2(input_x, input_y)

func get_rotation():
	var input_rot = 0
	if Input.is_action_pressed("game_rot_cw"):
		input_rot += 1
	if Input.is_action_pressed("game_rot_ccw"):
		input_rot -= 1
	if Input.is_action_pressed("game_rot180"):
		input_rot += 2
	
	return input_rot
