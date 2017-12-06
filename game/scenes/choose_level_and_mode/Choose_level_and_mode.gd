extends Control

# class member variables go here, for example:
# var a = 2
# var b = "textvar"
onready var scene = load("res://scenes/main/university.tscn")
onready var array_of_srcs = get_tree().get_nodes_in_group("scrs")

func _ready():
	# Called every time the node is added to the scene.
	# Initialization here
	set_process(true)
	global.key_up_pressed = true
	get_node("Panel").show()
	load_game()
	load_score()
#	load_questions()
	print("hi")

		
	
	if (global.level_now >= 0) :
		get_node("Panel/btn_first_level").set_disabled(false)
		global.levels_enabled = 0
	if (global.level_now >= 1) :
		get_node("Panel/btn_second_level").set_disabled(false)
		global.levels_enabled = 1
	if (global.level_now >= 2) :
		get_node("Panel/btn_third_level").set_disabled(false)
		global.levels_enabled = 2
	if (global.level_now >= 3) :
		get_node("Panel/btn_fourth_level").set_disabled(false)
		global.levels_enabled = 3
		

	
	

	
	print(array_of_srcs)
	
#	for i in range (0, global.questions[global.discipline_mode][global.category_mode].keys().size()):
#	print("! ", global.questions[global.discipline_mode][global.category_mode].keys()[0])
#	print("! ", global.questions[global.discipline_mode][global.category_mode]["c_lvl1"].size())

#	for i in range (0, array_of_srcs.size()):
	for j in range (0, global.questions[global.discipline_mode][global.levels_types.keys()[global.index_of_level]].size()):
		array_of_srcs[j].set_text(str(global.scores[global.index_of_level][j]) + "/" + str(global.questions[global.discipline_mode][global.category_mode][str(j)].size() * 10))

func load_game():
	var save_file = File.new()
	if not save_file.file_exists("res://save.json"):
		return
	save_file.open("res://save.json", File.READ)
	global.levels_types.parse_json(save_file.get_as_text())
	# Get an opened levels from choosed category(1,2,3..n): 
	global.level_now = global.levels_types[global.category_mode]
	# Save all levels from each category to array:
	for i in range(0,global.levels_arr.size()) :
		global.levels_arr[i] = global.levels_types.values()[i]

#func load_score():
#	var questions_file = File.new()
#	questions_file.open("res://questions/qst.json", File.READ)
#	global.questions.parse_json(questions_file.get_as_text())
#	
#	var load_score_file = File.new()
#	if not load_score_file.file_exists("res://score/score.json"):
#		return
#	load_score_file.open("res://score/score.json", File.READ)
#	global.levels_types_for_scores.parse_json(load_score_file.get_as_text())
#	for i in range(0, global.levels_types_for_scores.size()):
#		for j in range(0, global.questions[global.discipline_mode][global.levels_types.keys()[i]].size()):
#			global.scores[i].append(global.levels_types_for_scores[global.category_mode].values()[j-global.levels_types_for_scores[global.category_mode].keys().size() + 1])
#			print("i ", i)
#			print("j ", j)
#			print("global.scores[i][j] ", global.scores[i][j])


func load_score():
	var questions_file = File.new()
	questions_file.open("res://questions/qst.json", File.READ)
	global.questions.parse_json(questions_file.get_as_text())
	
	var load_score_file = File.new()
	if not load_score_file.file_exists("res://score/score.json"):
		return
	load_score_file.open("res://score/score.json", File.READ)
	global.levels_types_for_scores.parse_json(load_score_file.get_as_text())
#	print(global.levels_types_for_scores.values()[0]["0"])
#	print(global.questions[global.discipline_mode][global.levels_types.keys()[1]].size())
	for i in range(0, global.levels_types_for_scores.size()):
		for j in range(0, global.questions[global.discipline_mode][global.levels_types.keys()[i]].size()):
			global.scores[i].append(global.levels_types_for_scores.values()[i][str(j)])
#			print("i ", i)
#			print("j ", j)
#			print("global.scores[i][j] ", global.scores[i][j])
#			print(global.levels_types_for_scores.values()[i][str(j)])
		
#		for j in range(0, global.questions[global.discipline_mode][global.levels_types.keys()[i]].size()):
#			global.scores[i].append(global.levels_types_for_scores[global.category_mode].values()[j-global.levels_types_for_scores[global.category_mode].keys().size() + 1])
#			print("i ", i)
#			print("j ", j)
#			print("global.scores[i][j] ", global.scores[i][j])

func load_questions():
	var questions_file = File.new()
	questions_file.open("res://questions/qst.json", File.READ)
	global.questions.parse_json(questions_file.get_as_text())
	

# Start game with selected category and level:
func _on_btn_start_pressed():
	if (global.check_focus):
		get_node("SamplePlayer").play("door_opened2")
		var new_game = scene.instance()
		get_parent().add_child(new_game)
		global.check_start_new_game = true
		global.student_wait = false
		global.key_up_pressed = false
		queue_free()
	else :
		get_node("PopupDialog").show()


func _on_first_level_focus_enter():
	global.level_now = 0
	global.check_focus = true
	#get_node("Panel/btn_first_level/scr1").set_text(str(global.scores[global.index_of_level][global.level_now]))
	get_node("Panel/lbl_choose_level").hide()
	get_node("PopupDialog").hide()

func _on_btn_second_level_focus_enter():
	global.level_now = 1
	global.check_focus = true
	#get_node("Panel/btn_second_level/scr2").set_text(str(global.scores[global.index_of_level][global.level_now]))
	get_node("Panel/lbl_choose_level").hide()
	get_node("PopupDialog").hide()
	
func _on_btn_third_level_focus_enter():
	global.level_now = 2
	global.check_focus = true
	#get_node("Panel/btn_third_level/scr3").set_text(str(global.scores[global.index_of_level][global.level_now]))
	get_node("Panel/lbl_choose_level").hide()
	get_node("PopupDialog").hide()
	
func _on_btn_fourth_level_focus_enter():
	global.level_now = 3
	global.check_focus = true
	#get_node("Panel/btn_fourth_level/scr4").set_text(str(global.scores[global.index_of_level][global.level_now]))
	get_node("Panel/lbl_choose_level").hide()
	get_node("PopupDialog").hide()

# Open lectures for selected category and level:
func _on_btn_lecture_pressed():
	if(global.check_focus) :
		var t = get_node("Panel/btn_first_level")

		var lectures_file = File.new()
		lectures_file.open("res://lectures/lectures.json", File.READ)
	
		var lectures = {}
	
		lectures.parse_json(lectures_file.get_as_text())
		# Parse from .json file all lectures for selected discipline, category and level:
		var lects = lectures[global.discipline_mode][global.category_mode][str(global.level_now)]

		# Open all lectures for selected discipline, category and level in browser:
		for i in range(0, lects.size()) :
			OS.shell_open(lects[i])
	else :
		get_node("PopupDialog").show()
		
func print_scores():
	pass
		

func _on_Panel_hide():
	for lbl in array_of_srcs:
		lbl.queue_free()
	global.key_up_pressed = false
	global.student_wait = false


