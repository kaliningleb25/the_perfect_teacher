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
#onready var test2 = global.questions[global.discipline_mode][global.category_mode][global.lvl]

#onready var test = global.questions[global.discipline_mode][global.category_mode][global.lvl]



# Get a random question
func get_question():
	randomize()
	global.test = global.questions[global.discipline_mode][global.category_mode][global.lvl]
#	var test = global.questions[global.discipline_mode][global.category_mode][global.lvl]
	print("global.test.size() ", global.test.size())

	if (global.test.size() != 0):
		rand_index = randi()%global.test.keys().size()
		string = global.test.keys()[rand_index]
		question.set_text(string)
		q = string
		val = global.test[string]
		global.test.erase(string)
	else:
		queue_free()
	

# Which button is pressed
func answer():
	if (b_correct.is_pressed()):
		check = 1
		global.question_answered = true
		if (global.dialog_scene_counter > 0):
			global.dialog_scene_counter -= 1
		queue_free()
	elif (b_wrong.is_pressed()):
		check = 0
		global.question_answered = true
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
		global.answer_is_true = true

	elif ((val != check) and (check != -1)):
		check_answer = 0
		global.gameovercheck = true

	return check_answer

func _ready():
	# Called every time the node is added to the scene.
	# Initialization here

#	print("global.test2 size : ", global.test2.size())
	if (global.check_restart_game):
		var questions_file = File.new()
		questions_file.open("res://questions/qst.json", File.READ)
		global.questions.parse_json(questions_file.get_as_text())
		global.check_restart_game = false
	#	test = test2
	#	global.check_restart_game = false

	get_question()
	set_process(true)
	get_node("paper/question").set_scroll_follow(true)
	global.student_reach_teacher = true
	global.question_answered = false
	

func _process(delta):
	check_answer()
	if (global.gameovercheck):
		queue_free()
	


