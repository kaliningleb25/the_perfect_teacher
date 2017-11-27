extends Control

# MEMBER VARIABLES
# Get a label_score node
#onready var score = get_node("label_score")

func _ready():
	#if (not get_node("Timer").is_active()):
	set_process(true)

func _process(delta):
	# Show a current score(points):
	get_node("label_score").set_text("Points: " + str(global.score * 10))
	# Check gameover
	if (global.gameovercheck):
		queue_free()



func _on_Timer_timeout():
	pass
