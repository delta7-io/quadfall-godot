extends Node2D

enum BlockColor {
	EMPTY = -1,
	GRAY,
	RED,
	ORANGE,
	YELLOW,
	GREEN, 
	CYAN,
	BLUE,
	PURPLE
}

# Vector in Godot runs from top left
# example:
#  0  1  2  3  4  5  (x)
#  1
#  2
#  3
#  4
#  5
# (y)

const DROP = Vector2(0, 1)
const LEFT = Vector2(-1, 0)
const RIGHT = Vector2(1, 0)
const HARD_DROP = Vector2(0, -1)

export(BlockColor) var color = BlockColor.EMPTY


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	var color_code = -1
	if color == BlockColor.GRAY:
		color_code = 0
	elif color == BlockColor.RED:
		color_code = 1
	elif color == BlockColor.ORANGE:
		color_code = 2
	elif color == BlockColor.YELLOW:
		color_code = 3
	elif color == BlockColor.GREEN:
		color_code = 4
	elif color == BlockColor.CYAN:
		color_code = 5
	elif color == BlockColor.BLUE:
		color_code = 6
	elif color == BlockColor.PURPLE:
		color_code = 7
		
	set_color(color_code)
	
	# region_rect
	# Replace with function body.
	
	
	# Called every frame. 'delta' is the elapsed time since the previous frame.
	#func _process(delta):
	#	pass
	
func set_color(color_index):
	var block_sprite = get_node("blocks") as Sprite
	var block_size = 16 #block_sprite.region_rect.size.x
	
	block_sprite.region_rect.position = Vector2(block_size * color_index, 0)
		
