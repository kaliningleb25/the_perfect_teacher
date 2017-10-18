extends Control

onready var score = get_node("test")
onready var counter = 0

func _ready():
	set_process(true)

func _process(delta):
	score.set_text("Score: " + str(global.score))
	if (global.gameovercheck):
		queue_free()
	

	
	
