extends Node2D

# class member variables go here, for example:
# var a = 2
# var b = "textvar"
var screen_size
var door_c_size

#onready var scene = load("res://scenes/main/university.tscn")
onready var scene = load("res://scenes/choose_level_and_mode/choose_level_and_mode.tscn")
#onready var scene = load("res://scenes/interactive_menu_programming/interactive_menu_programming.tscn")

onready var door_c = get_node("door_c")



func _ready():
	# Called every time the node is added to the scene.
	# Initialization here
	screen_size = get_viewport_rect().size
	global.door_c_pos = door_c.get_global_pos().x
#	print(global.door_programming_pos)
	if (global.discipline_mode == 0):
		get_node("door_c/label_c").set_text("C++")
	
	door_c_size = get_node("door_c").get_texture().get_size()
	set_process(true)

func _process(delta):
	var stud_pos = get_node("stud").get_pos()
	
	var door_c_rect = Rect2( get_node("door_c").get_pos() - door_c_size*0.5, door_c_size )
	
	# Move student left and right
	if (stud_pos.x > 0 and Input.is_action_pressed("ui_left")):
		stud_pos.x += -100 * delta
	if (stud_pos.x < screen_size.x and Input.is_action_pressed("ui_right")):
		stud_pos.x += 100 * delta
	get_node("stud").set_pos(stud_pos)
	
	if(door_c_rect.has_point(stud_pos) and Input.is_action_pressed("ui_select")):
		print("ENTER THE DOOR!")
		global.level_mode = 0
		global.category_mode = 0
		global.ekz_type = "\"" + "C++" + "\""
		var new_game = scene.instance()
		get_parent().add_child(new_game)
		#queue_free()