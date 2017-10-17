extends Control

onready var dialog = get_node("dialog")
onready var question = get_node("dialog/question")
onready var b_correct = get_node("dialog/b_correct")
onready var b_wrong = get_node("dialog/b_wrong")
onready var score = get_node("score")

onready var scr_count = 0

onready var check = -1

onready var questions = {
"A cat has five legs" : 0,
"People have two eyes" : 1 
}

onready var qst = questions.keys()
onready var rand_index
onready var string

func get_question():
	randomize()
	rand_index = randi()%qst.size()
	string = qst[rand_index]
	question.set_text(string)

func answer():
	if (b_correct.is_pressed()):
		check = 1
		dialog.hide()
	if (b_wrong.is_pressed()):
		check = 0
		dialog.hide()
	
	return check

func check_answer():

	answer()
	#print("wait for answer: ", questions[string])
	#print("check ", check)
	
	if (questions[string] == answer()):
		scr_count = 1
		score.set_text("Score: " + str(scr_count))
	#TODO else: GAMEOVER!


func _ready():
	# Called every time the node is added to the scene.
	# Initialization here
	get_question()
	
	

	set_process(true)
	
func _process(delta):
	check_answer()
	
