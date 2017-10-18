extends Control

onready var dialog = get_node("dialog")
onready var question = get_node("dialog/question")
onready var b_correct = get_node("dialog/b_correct")
onready var b_wrong = get_node("dialog/b_wrong")

onready var score_scene = load("res://scenes/score/score.tscn") # will load when parsing the script
#onready var score = get_node("score")

onready var check_answer = -1

onready var check = -1

onready var counter = 0

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
		#dialog.hide()
		if (global.dialog_scene_counter > 1):
			global.dialog_scene_counter -= 1
			print("global.dialog_scene_counter ", str(global.dialog_scene_counter))
		queue_free()
		
	elif (b_wrong.is_pressed()):
		check = 0
		#dialog.hide()
		if (global.dialog_scene_counter > 1):
			global.dialog_scene_counter -= 1
			print("global.dialog_scene_counter ", str(global.dialog_scene_counter))
		queue_free()
		
		
	
	return check

func check_answer():

	var ch = answer()
	#print("wait for answer: ", questions[string])
	#print("check ", check)
	
	if (questions[string] == check):
		check_answer = 1
		global.score += 1
		var new_score = score_scene.instance()
		get_parent().add_child(new_score)
	elif ((questions[string] != check) and (check != -1)):
		check_answer = 0
		get_tree().change_scene("res://scenes/gameover/gameover.tscn")
		global.gameovercheck = true
		
##		score.set_text("Score: " + str(scr_count))
	#TODO else: GAMEOVER!
	
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
	
