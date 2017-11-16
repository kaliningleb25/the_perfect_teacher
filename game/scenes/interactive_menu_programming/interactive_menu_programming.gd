extends Node2D

# class member variables go here, for example:
# var a = 2
# var b = "textvar"
var screen_size
var door_size
var doot_java_size

#onready var scene = load("res://scenes/main/university.tscn")
onready var scene = load("res://scenes/choose_level_and_mode/choose_level_and_mode.tscn")
onready var exit_to_previous_corridor_scene = load("res://scenes/interactive_menu/interactive_menu.tscn") # Back to previous corridor

onready var door_c = get_node("door_c")
onready var door_java = get_node("door_java")



func _ready():
	# Called every time the node is added to the scene.
	# Initialization here
	screen_size = get_viewport_rect().size
	# Can refactor using .JSOM
	if (global.discipline_mode == "programming"):
		get_node("label_c").set_text("C++")
		get_node("label_java").set_text("Java")
		
	door_size = get_node("door_c").get_texture().get_size()
	set_process(true)

func _process(delta):
	var stud_pos = get_node("stud").get_pos()
	
	var door_c_rect = Rect2( get_node("door_c").get_pos() - door_size*0.5, door_size )
	var door_java_rect = Rect2( get_node("door_java").get_pos() - door_size*0.5, door_size)
	
	# Move student left and right
	if (stud_pos.x > 0 and Input.is_action_pressed("ui_left")):
		stud_pos.x += -100 * delta
	if (stud_pos.x < screen_size.x and Input.is_action_pressed("ui_right")):
		stud_pos.x += 100 * delta
	get_node("stud").set_pos(stud_pos)
	
	if(door_c_rect.has_point(stud_pos) and Input.is_action_pressed("ui_select")):
		print("ENTER THE DOOR!")
		global.category_mode = "c_plus_plus"
		global.ekz_type = "\"" + "C++" + "\""
		global.index_of_level = 0
		var new_game = scene.instance()
		get_parent().add_child(new_game)
		#queue_free()
	if(door_java_rect.has_point(stud_pos) and Input.is_action_pressed("ui_select")):
		print("ENTER THE DOOR!")
		global.category_mode = "java"
		global.ekz_type = "\"" + "Java" + "\""
		global.index_of_level = 1
		var new_game = scene.instance()
		get_parent().add_child(new_game)
		
	if(stud_pos.x < 0): 
		var exit_to_prev_cor = exit_to_previous_corridor_scene.instance()
		get_parent().add_child(exit_to_prev_cor)
		global.check_return = 0
		queue_free()