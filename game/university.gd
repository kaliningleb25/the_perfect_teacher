extends Node2D

# MEMBER VARIABLES

# Student scene
onready var scene = load("res://scenes/student/student.tscn") # will load when parsing the script

# Timer
var can_go = true
onready var timer = get_node("Timer")

func _ready():
	# Called every time the node is added to the scene.
	# Initialization here

	set_process(true)

func _process(delta):
	# Move new student
	if (can_go):
		if (global.dialog_scene_counter > 0):
			var new_student = scene.instance()
			get_parent().add_child(new_student)
			can_go = false
			timer.start()

	# Check if gameover 1
	if (global.dialog_scene_counter > 4):
		global.gameovercheck = true

	# Check if gameover 2
	if (global.gameovercheck):
		get_tree().change_scene("res://scenes/gameover/gameover.tscn")
		queue_free()

# If time is out - next student can go
func _on_Timer_timeout():
	can_go = true
