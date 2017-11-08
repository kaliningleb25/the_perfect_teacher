extends Control

# MEMBER VARIABLES

# get nodes for dialog
onready var question = get_node("paper/question")
onready var b_correct = get_node("paper/b_correct")
onready var b_wrong = get_node("paper/b_wrong")

# Score scene
onready var score_scene = load("res://scenes/score/score.tscn") # will load when parsing the script
# Check what exactly button is pressed
onready var check_answer = -1
# Check "CORRECT" or "WRONG" answer
onready var check = -1

onready var rand_index
onready var string

# For store question
onready var q
# For store value of question (1 or 0)
onready var val

# Get a random question
func get_question():
	randomize()
	#if (global.discipline_mode == 0 and global.category_mode == 0):
	var test = global.test_questions[global.c_level]#global.questions_programming[global.programming_mode][global.level]
	if (test.size() != 0):
		rand_index = randi()%test.keys().size()
		
		string = test.keys()[rand_index]
		
		question.set_text(string)
		q = string
		val = test[string]
		test.erase(string)
	else:
		queue_free()
	

# Which button is pressed
func answer():
	if (b_correct.is_pressed()):
		check = 1
		if (global.dialog_scene_counter > 0):
			global.dialog_scene_counter -= 1
		queue_free()
	elif (b_wrong.is_pressed()):
		check = 0
		if (global.dialog_scene_counter > 0):
			global.dialog_scene_counter -= 1
		queue_free()

	return check

# "CORRECT" or "WRONG" answer
func check_answer():
	answer()
	if (val == check):
		check_answer = 1
		global.score += 1
		var new_score = score_scene.instance()
		get_parent().add_child(new_score)
	elif ((val != check) and (check != -1)):
		check_answer = 0
		global.gameovercheck = true

	return check_answer

func _ready():
	# Called every time the node is added to the scene.
	# Initialization here
	get_question()
	set_process(true)
	get_node("paper/question").set_scroll_follow(true)

func _process(delta):
	check_answer()
	if (global.gameovercheck):
		queue_free()
	
