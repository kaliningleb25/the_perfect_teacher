extends Control

#onready var dialog = get_node("Control/dialog")
#onready var question = get_node("question")
#onready var b_right = get_node("Control/dialog/b_right")
#onready var b_wrong = get_node("Control/dialog/b_wrong")

onready var question = get_node("dialog/question")

onready var questions = {
"Some question" : 0,
"Another question" : 1
}

onready var qst = questions.keys()

func get_question():
	randomize()
	question.set_text(qst[randi()%qst.size()])

func _ready():
	# Called every time the node is added to the scene.
	# Initialization here
	get_question()
	
	set_process(true)
