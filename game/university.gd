extends Node2D

# MEMBER VARIABLES

# Student scene
onready var scene = load("res://scenes/student/student.tscn") # will load when parsing the script

# Timer
#onready var can_go = true
onready var timer = get_node("Timer")

func _ready():
	# Called every time the node is added to the scene.
	# Initialization here
	set_process(true)

func _process(delta):
	# Move new student
	if (global.can_go):
		if (global.next_student == true):
			var new_student = scene.instance()
			get_parent().add_child(new_student)
			global.can_go = false
			timer.start()
			
	# Check if gameover 1
	if (global.dialog_scene_counter > 2):
		global.gameovercheck = true

	# Check if gameover 2
	if (global.gameovercheck):
		get_tree().change_scene("res://scenes/gameover/gameover.tscn")
		queue_free()
		
	print("dialog_scene_counter ", global.dialog_scene_counter)
	
	

func level_up():
	global.level += 1

# If time is out - next student can go
func _on_Timer_timeout():
	global.can_go = true
	
	if(global.ready_next_level(global.all_questions[global.level].keys())):
		global.next_student = false
		if(global.dialog_scene_counter == 0):
			global.next_student = true
			print ("Ready to go to the next level!")
			level_up()
