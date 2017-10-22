extends Control

# MEMBER VARIABLES
# Get a label_score node
onready var score = get_node("label_score")



func _ready():
	print("dialog_scene_counter ", global.dialog_scene_counter)
	
	set_process(true)

func _process(delta):
	# Show a current score(points):
	score.set_text("Points: " + str(global.score))
	# Check gameover
	if (global.gameovercheck):
		queue_free()

