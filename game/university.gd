extends Node2D

# MEMBER VARIABLES

# Student scene
onready var scene = load("res://scenes/student/student.tscn") # will load when parsing the script

onready var teacher = get_node("teacher")
#onready var teacher_pos = teacher.get_global_pos()

# Timer
#onready var can_go = true
onready var timer = get_node("Timer")

func _ready():
	# Called every time the node is added to the scene.
	# Initialization here
	global.teacher_pos = teacher.get_global_pos().x
	var type = get_node("background/type")
	type.set_text(global.ekz_type)
	
	#load_game()
	
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
	


	


	
func save():
	var save_file = File.new()
	save_file.open("res://save.json", File.WRITE)
	save_file.store_line(str(global.level))
	save_file.close()
	
#func load_game():
#	var save_file = File.new()
#	if not save_file.file_exists("res://save.json"):
#		return
#	save_file.open("res://save.json", File.READ)
#	var lvl = save_file.get_as_text()
#	global.level = int(lvl)
	
	

func level_up():
	global.level += 1

# If time is out - next student can go
func _on_Timer_timeout():
	global.can_go = true
	
	if(global.ready_next_level(global.discipline[global.discipline_mode][global.programming_mode][global.level].keys())):
		global.next_student = false
		if(global.dialog_scene_counter == 0):
			global.next_student = true
			print ("Ready to go to the next level!")
			level_up()


func _on_Button_pressed():
	save()
