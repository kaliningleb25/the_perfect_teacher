extends Node2D

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

# Speed of student
const MOVEMENT_SPEED = 1
# Dialog scene
onready var dialog_scene = load("res://scenes/dialog/dialog.tscn") # will load when parsing the script


func _ready():
	# Called every time the node is added to the scene.
	# Initialization here
	if (global.student_auto_mode == true):
		get_node("AnimationPlayer").play("student_move")
	
	set_process(true)

func _process(delta):
	# For main - student automatically go to teacher:
	if (global.student_auto_mode == true):
		# Move a student
		set_pos(Vector2(get_pos().x + MOVEMENT_SPEED, get_pos().y))
	
	# Check if student interacte with teacher(624.565674)
	# If true - show dialog window
		if (get_pos().x >= global.teacher_pos):
			var new_dialog = dialog_scene.instance()
			get_parent().add_child(new_dialog)
			global.dialog_scene_counter += 1
		

		# Check if student is out of screen or destinate a teacher
		if ((get_pos().x > OS.get_window_size().x) or (get_pos().x >= global.teacher_pos)):
			queue_free()

		# Check if gameover
		if (global.gameovercheck):
			queue_free()
