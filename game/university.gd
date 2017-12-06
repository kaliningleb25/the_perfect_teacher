extends Node2D

# MEMBER VARIABLES

# Student scene
onready var scene = load("res://scenes/student/student.tscn") # will load when parsing the script
onready var animated_student_scene = load("res://scenes/student/animated_student.tscn")
onready var exit_to_corridor_scene = load("res://scenes/interactive_menu_programming/interactive_menu_programming.tscn") # exit to corridor
onready var exit_to_interactive_menu_scene = load("res://scenes/interactive_menu/interactive_menu.tscn") # exit to interactive menu from dialog

onready var teacher = get_node("background/teacher")

onready var main_scene = load("res://scenes/main/university.tscn")

# Timer
onready var timer = get_node("Timer")

onready var time_to_wait = randf()*3+1

func _ready():
	check_sound()
	AudioServer.set_fx_global_volume_scale(global.sound)
	timer.start()
	get_tree().set_auto_accept_quit(false)
	
	var questions_file = File.new()
	questions_file.open("res://questions/qst.json", File.READ)
	global.questions.parse_json(questions_file.get_as_text())
	global.lvls_count = global.questions[global.discipline_mode][global.category_mode].size()
	
	global.teacher_pos = teacher.get_global_pos().x
	var type = get_node("background/type")
	type.set_text(global.ekz_type)
	load_questions_from_json_file()
		
#	global.student_auto_mode = true
	
	global.gameovercheck = false
	
	print("global.check_exit ", global.check_exit)
	
	set_process(true)

func _process(delta):
	if (global.student_reach_teacher == true):
		get_node("AnimationPlayer").play("teacher_read")
		get_node("Timer_How_Long_Answered").start()
		global.student_reach_teacher = false
	if (global.question_answered == true):
		get_node("Timer_How_Long_Answered").stop()
		get_node("AnimationPlayer").seek(0, true)
		# Save score in file each time when question is answered (!check weight of process)
		global.question_answered == false
		
	# Move new student
	if (global.gameovercheck == false):
		if (global.can_go):
			if (global.next_student == true):
				#var new_student = scene.instance()
				#get_parent().add_child(new_student)
				var new_animated_student = animated_student_scene.instance()
				get_parent().add_child(new_animated_student)
				global.can_go = false
				timer.start()
	else :
		get_node("background/opened_door").set_disabled(true)
		get_node("background/bell_on").set_disabled(true)
		get_node("background/bell_off").set_disabled(true)

	# Check if anser is true - play animation (new points +10)
	if (global.answer_is_true):
		get_node("timer_score").start()
		get_node("anim_new_points").play("anim_new_points")
		global.answer_is_true = false
		
	if (global.question_answered_for_sound):
		get_node("SamplePlayer_Teacher").play("pen_write_answer")
		global.question_answered_for_sound = false
			
	
	# Check if gameover 1
	if (global.dialog_scene_counter > 2):
		global.gameovercheck = true

	# Check if gameover 2
	if (global.gameovercheck):
		get_node("GameOverDialog").show()

func save():
	var save_file = File.new()
	save_file.open("res://save.json", File.WRITE)

	save_file.store_line("{")
	for i in range(0, global.levels_arr.size()) :
		save_file.store_string("\"")
		save_file.store_string(global.levels_types.keys()[i])
		save_file.store_string("\"")
		save_file.store_string(" : ")
		if (global.category_mode == global.levels_types.keys()[i]) :
			save_file.store_string(str(global.level_now))
		else :
			save_file.store_string(str(global.levels_arr[i]))
		save_file.store_string(",\n")
	save_file.store_line("}")
	save_file.close()

func level_up():
	global.save_score()
	if (not (global.test.size() == 0 and global.level_now == global.levels_enabled and global.question_answered)):
		get_node("NextLevelDialog").show()
	global.can_go = false
	global.score = 0

# If time is out - next student can go
func _on_Timer_timeout():
	global.check_exit = false
	global.can_go = true
	
	get_node("timer_teacher_eyes").set_wait_time(time_to_wait)
	get_node("timer_teacher_eyes").start()
	
	if(global.ready_next_level(global.questions[global.discipline_mode][global.category_mode][str(global.level_now)].keys())):
		print("global.level_now() = ", global.level_now)
		print("global.lvl = ", global.lvl)
		global.next_student = false
		if(global.dialog_scene_counter == 0):
			if (global.gameovercheck == false):
				if (global.level_now != (global.lvls_count - 1)):
					global.next_student = true
					print ("Ready to go to the next level!")
					level_up()
			
	if (global.test.size() == 0 and global.level_now == global.levels_enabled and global.question_answered):
		if (global.gameovercheck == false):
			global.save_score()
			get_node("Particles2D").show()

func load_questions_from_json_file():
	# Read from .jsom file about what the level is now and for set text name
	var levels_and_names_file = File.new()
	levels_and_names_file.open("res://levels/levels_and_names.json", File.READ)
	global.levels_and_names.parse_json(levels_and_names_file.get_as_text())
	global.lvl = global.levels_and_names["levels"][global.discipline_mode][global.category_mode][str(global.level_now)]
	get_node("background/name").set_text(global.levels_and_names["names"][global.discipline_mode][global.category_mode][str(global.level_now)])

func _on_opened_door_button_down():
	if (global.gameovercheck == false):
		get_node("ExitDialog").show()
		
func _on_no_button_down():
	 get_node("ExitDialog").hide()

func _on_yes_button_down():
	global.check_start = false
	global.student_auto_mode = false
	global.check_exit = true
	global.dialog_scene_counter = 0
	global.can_go = false
	if (get_node("AnimationPlayer").is_playing()):
		get_node("AnimationPlayer").seek(0, true)
	global.check_restart_game_or_exit_to_menu = true
	global.score = 0

	if (global.level_now > global.levels_enabled):
		save()
	global.question_answered = false

	get_node("background/opened_door").set_disabled(false)
	get_node("background/bell_on").set_disabled(false)
	get_node("background/bell_off").set_disabled(false)

	var confirm_quit = exit_to_corridor_scene.instance()
	get_parent().add_child(confirm_quit)

	queue_free()
	
func _on_timer_teacher_eyes_timeout():
	 # replace with function body
	time_to_wait = randf()*3+1
	
	get_node("AnimationPlayer_teacher_eyes").play("teacher_close_eyes")
	get_node("AnimationPlayer_teacher_eyes").seek(0, true)

func _on_timer_score_timeout():
	get_node("score").set_text("Points: " + str(global.score))

func _on_play_again_button_down():
	global.dialog_scene_counter = 0
	global.check_restart_game_or_exit_to_menu = true
	get_node("GameOverDialog").hide()
	global.score = 0
	get_node("score").set_text("Points: " + str(0))
	
	get_node("background/bell_on").set_disabled(false)
	get_node("background/bell_off").set_disabled(false)

	global.gameovercheck = false
	

func exit_to_interactive_menu():
	global.check_start = false
	global.student_auto_mode = false
	global.check_exit = true
	global.dialog_scene_counter = 0
	global.can_go = false
	get_node("AnimationPlayer").seek(0, true)
	global.check_restart_game_or_exit_to_menu = true
	get_node("GameOverDialog").hide()
	get_node("NextLevelDialog").hide()
	global.score = 0

	if (global.level_now > global.levels_enabled):
		save()
	global.question_answered = false

	get_node("background/opened_door").set_disabled(false)
	get_node("background/bell_on").set_disabled(false)
	get_node("background/bell_off").set_disabled(false)

	var exit_to_inter_menu = exit_to_interactive_menu_scene.instance()
	get_parent().add_child(exit_to_inter_menu)
	
	global.gameovercheck = false
	queue_free()

func _on_exit_to_interactive_menu_button_down():
	exit_to_interactive_menu()
	
func _notification(what):
	if (what == MainLoop.NOTIFICATION_WM_QUIT_REQUEST):
		get_node("MainExitDialog").show()

func _on_main_yes_button_down():
	if (global.level_now > global.levels_enabled):
		save()
	get_tree().quit()

func _on_main_no_button_down():
	get_node("MainExitDialog").hide()

func _on_btn_next_lvl_button_down():
	get_node("NextLevelDialog").hide()
	global.can_go = true
	global.level_now += 1
	load_questions_from_json_file()

func _on_btn_goto_lecture_button_down():
	var lectures_file = File.new()
	lectures_file.open("res://lectures/lectures.json", File.READ)
	
	var lectures = {}
	
	lectures.parse_json(lectures_file.get_as_text())
	# Parse from .json file all lectures for selected discipline, category and level:
	var lects = lectures[global.discipline_mode][global.category_mode][str(global.level_now + 1)]

	# Open all lectures for selected discipline, category and level in browser:
	for i in range(0, lects.size()) :
		OS.shell_open(lects[i])


func _on_btn_exit_button_down():
	exit_to_interactive_menu()


func _on_Timer_Before_Start_timeout():
	get_node("SamplePlayer").play("door_opened2")
	global.check_exit = false
	global.can_go = true
	get_node("background/closed_door").hide()
	get_node("background/opened_door").show()


func check_sound():
	if (global.sound == 0):
		get_node("background/bell_on").hide()
		get_node("background/bell_off").show()
	else:
		get_node("background/bell_off").hide()
		get_node("background/bell_on").show()


func _on_bell_on_button_down():
	get_node("background/bell_on").hide()
	get_node("background/bell_off").show()
	global.sound = 0
	AudioServer.set_fx_global_volume_scale(global.sound)
	


func _on_bell_off_button_down():
	get_node("background/bell_off").hide()
	get_node("background/bell_on").show()
	global.sound = 1
	AudioServer.set_fx_global_volume_scale(global.sound)


func _on_Timer_How_Long_Answered_timeout():
	if (global.question_answered == false):
		get_node("SamplePlayer_Teacher").play("teacher_sigh")
