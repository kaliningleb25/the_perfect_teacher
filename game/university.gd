extends Node2D

# MEMBER VARIABLES

# Student scene
onready var scene = load("res://scenes/student/student.tscn") # will load when parsing the script

onready var teacher = get_node("teacher")

# Timer
onready var timer = get_node("Timer")

func _ready():
	# Called every time the node is added to the scene.
	# Initialization here
	global.teacher_pos = teacher.get_global_pos().x
	var type = get_node("background/type")
	type.set_text(global.ekz_type)
	load_questions_from_json_file()

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

	save_file.store_line("{")
	for i in range(0, global.levels_arr.size()) :
		save_file.store_string("\"")
		save_file.store_string(global.levels_types.keys()[i])
		save_file.store_string("\"")
		save_file.store_string(" : ")
		if (global.category_mode == global.levels_types.keys()[i]) :
			save_file.store_string(str(global.level_now))
		else :
			save_file.store_string(str(global.levels_arr[i]))
		save_file.store_string(",\n")
	save_file.store_line("}")
	save_file.close()

func level_up():
	global.level_now += 1
	load_questions_from_json_file()

# If time is out - next student can go
func _on_Timer_timeout():
	global.can_go = true
	
	if(global.ready_next_level(global.questions[global.discipline_mode][global.category_mode][global.lvl].keys())):
		global.next_student = false
		if(global.dialog_scene_counter == 0):
			global.next_student = true
			print ("Ready to go to the next level!")
			level_up()


func load_questions_from_json_file():
	# Read from .jsom file about what the level is now and for set text name
	var levels_and_names_file = File.new()
	levels_and_names_file.open("res://levels/levels_and_names.json", File.READ)
	global.levels_and_names.parse_json(levels_and_names_file.get_as_text())
	global.lvl = global.levels_and_names["levels"][global.discipline_mode][global.category_mode][str(global.level_now)]
	get_node("background/name").set_text(global.levels_and_names["names"][global.discipline_mode][global.category_mode][str(global.level_now)])

func _on_Button_pressed():
	save()
