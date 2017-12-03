extends Node2D

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

# Speed of student
const MOVEMENT_SPEED = 2
#FOR TEST: 
#const MOVEMENT_SPEED = 10
# Dialog scene
onready var dialog_scene = load("res://scenes/dialog/dialog.tscn") # will load when parsing the script
onready var screen_size
onready var stud_pos

onready var time_to_wait = randf()*3+1

func _ready():
	# Called every time the node is added to the scene.
	# Initialization here
	screen_size = get_viewport_rect().size
	
	get_node("AnimationPlayer").play("student_move")
	get_node("timer_student_eye").set_wait_time(time_to_wait)
	get_node("timer_student_eye").start()
	

	
	set_process(true)

func _process(delta):
	if (!global.student_wait):
		# For main - student automatically go to teacher:
		# -----------------------------------------------
		if (global.student_auto_mode == true):
			# Move a student
			set_pos(Vector2(get_pos().x + MOVEMENT_SPEED, get_pos().y))
		
		# Check if student interacte with teacher(624.565674)
		# If true - show dialog window
			if (global.check_exit == false):
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
				
			if (global.check_start_new_game): 
				queue_free()
				global.check_start_new_game = false
		# -----------------------------------------------
		# For interactive menu - student go left and right using buttons
		# -----------------------------------------------
		if (global.student_auto_mode == false) :
			stud_pos = get_node("torso").get_pos()
				# Move student left and right
			if (stud_pos.x > 0 and Input.is_action_pressed("ui_left")):
				stud_pos.x += -100 * delta
				#FOR TEST:
				#stud_pos.x += -300 * delta	
				if (not get_node("AnimationPlayer").is_playing()): 
				
					get_node("AnimationPlayer").play("student_move")
			if (stud_pos.x < screen_size.x and Input.is_action_pressed("ui_right")):
				stud_pos.x += 100 * delta
				#FOR TEST:
				#stud_pos.x += 300 * delta	
				if (not get_node("AnimationPlayer").is_playing()): 
					get_node("AnimationPlayer").play("student_move")
			get_node("torso").set_pos(stud_pos)
			
			if (not Input.is_action_pressed("ui_left") and not Input.is_action_pressed("ui_right")):
				get_node("AnimationPlayer").play("rest")
				get_node("AnimationPlayer").seek(0, true)
				get_node("AnimationPlayer").stop_all()
	else :
		get_node("AnimationPlayer").play("rest")
		get_node("AnimationPlayer").seek(0, true)
		get_node("AnimationPlayer").stop_all()

func _on_timer_student_eye_timeout():
	get_node("AnimationPlayer_student_eye").play("student_close_eye")
	get_node("AnimationPlayer_student_eye").seek(0, true)
	
	time_to_wait = randf()*3+1
	get_node("timer_student_eye").set_wait_time(time_to_wait)
