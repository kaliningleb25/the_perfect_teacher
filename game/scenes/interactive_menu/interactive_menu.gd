extends Node2D

# class member variables go here, for example:
# var a = 2
# var b = "textvar"
var screen_size
var door_programming_size

onready var scene = load("res://scenes/interactive_menu_programming/interactive_menu_programming.tscn")
onready var door_programming = get_node("door_programming")
onready var animated_student_scene = load("res://scenes/student/animated_student.tscn")



func _ready():
	# Called every time the node is added to the scene.
	# Initialization here
	screen_size = get_viewport_rect().size
	
	door_programming_size = get_node("door_programming").get_texture().get_size()
	global.student_auto_mode = false


	var new_animated_student = animated_student_scene.instance()
	get_parent().add_child(new_animated_student)
	

	set_process(true)

func _process(delta):
	var stud_pos = get_node("stud").get_pos()
	var label = get_node("label")
	
	var door_programming_rect = Rect2( get_node("door_programming").get_pos() - door_programming_size*0.5, door_programming_size )
	
	# Move student left and right
	if (stud_pos.x > 0 and Input.is_action_pressed("ui_left")):
		stud_pos.x += -100 * delta
	if (stud_pos.x < screen_size.x and Input.is_action_pressed("ui_right")):
		stud_pos.x += 100 * delta
	get_node("stud").set_pos(stud_pos)
	
	if(door_programming_rect.has_point(stud_pos) and Input.is_action_pressed("ui_select")):
		print("ENTER THE DOOR!")
		global.discipline_mode = "programming"
		var new_interactive_menu_programming = scene.instance()
		get_parent().add_child(new_interactive_menu_programming)
		queue_free()
		

