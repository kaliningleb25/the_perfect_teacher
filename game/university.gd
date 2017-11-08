extends Node2D

# MEMBER VARIABLES

# Student scene
onready var scene = load("res://scenes/student/student.tscn") # will load when parsing the script

onready var teacher = get_node("teacher")

#onready var teacher_pos = teacher.get_global_pos()

# Timer
#onready var can_go = true
onready var timer = get_node("Timer")

func _ready():
	# Called every time the node is added to the scene.
	# Initialization here
	global.teacher_pos = teacher.get_global_pos().x
	var type = get_node("background/type")
	type.set_text(global.ekz_type)
	print(global.discipline_mode)
	print(global.category_mode)
	load_questions_from_json_file()


	
	#load_game()
	
	set_process(true)

func _process(delta):
	# Move new student
	if (global.can_go):
		if (global.next_student == true):
			var new_student = scene.instance()
			get_parent().add_child(new_student)
			global.can_go = false
			timer.start()
			
	
	
	# Check if gameover 1
	if (global.dialog_scene_counter > 2):
		global.gameovercheck = true

	# Check if gameover 2
	if (global.gameovercheck):
		get_tree().change_scene("res://scenes/gameover/gameover.tscn")
		queue_free()
	


	


	
func save():
	var save_file = File.new()
	save_file.open("res://save.json", File.WRITE)
	save_file.store_line(str(global.c_level)) #!!!!!!!!!!!!
	save_file.store_line(str(global.java_level))
	save_file.close()
	
#func load_game():
#	var save_file = File.new()
#	if not save_file.file_exists("res://save.json"):
#		return
#	save_file.open("res://save.json", File.READ)
#	var lvl = save_file.get_as_text()
#	global.level = int(lvl)
	
	

func level_up():
	if (global.discipline_mode == 0 and global.category_mode == 0):
		global.c_level += 1
		load_questions_from_json_file()
		
		

# If time is out - next student can go
func _on_Timer_timeout():
	global.can_go = true
	
	if(global.ready_next_level(global.test_questions[global.c_level].keys())):
		global.next_student = false
		if(global.dialog_scene_counter == 0):
			global.next_student = true
			print ("Ready to go to the next level!")
			level_up()


func load_questions_from_json_file():
		if (global.discipline_mode == 0 and global.category_mode == 0):
			var questions_programming_c_file = File.new()
			if (global.c_level == 0):
				#28 вопросов:
				questions_programming_c_file.open("res://questions/programming/c_plus_plus/lvl1.json", File.READ)
				#global.programming_c_questions.parse_json(questions_programming_c_file.get_as_text())
				global.test_questions.parse_json(questions_programming_c_file.get_as_text())
				#print(global.test_questions["test"])
				#global.programming_c_questions = global.test_questions["test"]
				get_node("background/name").set_text("№1: Основы программирования, циклы (for, while, do while), оператор множественного выбора switch")
			if (global.c_level == 1):
				# 26 вопросов:
				questions_programming_c_file.open("res://questions/programming/c_plus_plus/lvl2.json", File.READ)
				global.programming_c_questions_lvl2.parse_json(questions_programming_c_file.get_as_text())
				get_node("background/name").set_text("№2: Арифметические и логические операции, оператор выбора if, ввод/вывод, приведение типов данных")
			if (global.c_level == 2):
				# 28 вопросов:
				questions_programming_c_file.open("res://questions/programming/c_plus_plus/lvl3.json", File.READ)
				global.programming_c_questions_lvl3.parse_json(questions_programming_c_file.get_as_text())
				get_node("background/name").set_text("№3: Строки, ссылки, указатели, массивы")
			if (global.c_level == 3):
				# 11 вопросов:
				questions_programming_c_file.open("res://questions/programming/c_plus_plus/lvl4.json", File.READ)
				global.programming_c_questions_lvl4.parse_json(questions_programming_c_file.get_as_text())
				get_node("background/name").set_text("№4: Структуры и файлы")
			
				
				

func _on_Button_pressed():
	save()
