extends Control

# MEMBER VARIABLES

# get nodes for dialog
onready var question = get_node("dialog/question")
onready var b_correct = get_node("dialog/b_correct")
onready var b_wrong = get_node("dialog/b_wrong")

# Score scene
onready var score_scene = load("res://scenes/score/score.tscn") # will load when parsing the script
# Check what exactly button is pressed
onready var check_answer = -1
# Check "CORRECT" or "WRONG" answer
onready var check = -1

# Questions with paramter (1 - correct, 0 - wrong)
onready var questions = {
"A cat has five legs" : 0,
"People have two eyes" : 1
}

# Get keys(string) from questions
onready var qst = questions.keys()

onready var rand_index
onready var string

# Get a random question
func get_question():
	randomize()
	rand_index = randi()%qst.size()
	string = qst[rand_index]
	question.set_text(string)

# Whic button is pressed
func answer():
	if (b_correct.is_pressed()):
		check = 1
		if (global.dialog_scene_counter > 1):
			global.dialog_scene_counter -= 1
			print("global.dialog_scene_counter ", str(global.dialog_scene_counter))
		queue_free()
	elif (b_wrong.is_pressed()):
		check = 0
		if (global.dialog_scene_counter > 1):
			global.dialog_scene_counter -= 1
			print("global.dialog_scene_counter ", str(global.dialog_scene_counter))
		queue_free()
	
	return check

# "CORRECT" or "WRONG" answer
func check_answer():
	answer()
	if (questions[string] == check):
		check_answer = 1
		global.score += 1
		var new_score = score_scene.instance()
		get_parent().add_child(new_score)
	elif ((questions[string] != check) and (check != -1)):
		check_answer = 0
		global.gameovercheck = true
	
	return check_answer


func _ready():
	# Called every time the node is added to the scene.
	# Initialization here
	get_question()
	set_process(true)

func _process(delta):
	check_answer()
	if (global.gameovercheck):
		queue_free()
	
