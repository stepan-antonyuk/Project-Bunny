extends Sprite3D

var coins = 5
var player_name = "robot"
var hearts = 3.5
const SPEED = 2
const ROT_Y_SPEED = 2

# Called when the node enters the scene tree for the first time.
func _ready():
	print(add_num(11, 99))
	#pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	check_inputs()
	#pass

func banana():
	print("banana")

func add_num(a, b):	
	var sum = a + b
	return sum

func check_inputs():
	if Input.is_action_pressed("ui_end"):
		rotate_y(deg_to_rad(-ROT_Y_SPEED))
	if Input.is_action_pressed("ui_text_delete"):
		rotate_y(deg_to_rad(ROT_Y_SPEED))
