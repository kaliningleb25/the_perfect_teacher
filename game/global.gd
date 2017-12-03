extends Node


# MEMBER VARIABLES
# For each correct answer score + 10
var score = 0
# How much student interacte with a teacher
var dialog_scene_counter = 0
# Gameover IF:
# 1 - If student interacte with a teacher more than 3 times without answer
# 2 - If teahcer choose wrong answer
var gameovercheck = false

var next_student = true

#------------------------------------------------------------
# For choose types for discipline(Programming, Math, etc.)
var discipline_mode

# For choose type questions for programming (C(0), Java(1), etc.)
var category_mode
#------------------------------------------------------------

var lvl

# Check can go for student for timer
var can_go = false

# Teacher's variables
var teacher_pos
var teacher_size

# Label of exam (C++, Java, etc) on the board
var ekz_type

# Dict for all questions
var questions = {}

# Dict for get levels (For example, c_lvl1, java_lvl1) and set name_ekz
var levels_and_names = {}

var levels_types = {}

var levels_types_for_scores = {}

# What type of level rught now (C++, Java etc.)
var level_now

var programming

# For array of levels
var c_level
var java_level

# ------------------------------------------
# Array for save game for each discipline
var disciplines_arr = [programming]

# Array for save game for each category
var c_plus_plus
var java

var levels_arr = [c_plus_plus, java]
# ------------------------------------------

var scores_c = []
var scores_java = []

var scores = [scores_c, scores_java]

# 0 = c_level, 1 = java_level
# TODO: WARNING! CHANGE THIS WHEN ADD NEW DISCIPLINE
var index_of_level

var check_focus = false

var student_reach_teacher = false

var question_answered = false

var check_start_new_game = false

# 0 = programming
var check_return

var student_auto_mode = false

var student_position

var answer_is_true = false

var check_restart_game_or_exit_to_menu = false

var test = {}

var test2 = {}

var levels_enabled

var check_exit = false

var sound = 1

var question_answered_for_sound = false

var lvls_count

var student_wait = false

var key_up_pressed = false




func save_score():
	var save_score_file = File.new()
	save_score_file.open("res://score/score.json", File.WRITE)
	save_score_file.store_line("{")
	for i in range (0, global.levels_arr.size()):
		save_score_file.store_string("\"")
		save_score_file.store_string(global.levels_types.keys()[i])
		save_score_file.store_string("\"")
		save_score_file.store_string(" : ")
		save_score_file.store_string("{\n")
		for j in range(0, global.questions[global.discipline_mode][global.levels_types.keys()[i]].size()): 
			#print("i", i)
			#print("j", j)
			#print("global.scores[i][j] ", global.scores[i][j])
			save_score_file.store_string("\"")
			save_score_file.store_string(str(j))
			save_score_file.store_string("\"")
			save_score_file.store_string(" : ")
			#if (global.category_mode == global.levels_types.keys()[i]):
			if (global.level_now == j and global.category_mode == global.levels_types.keys()[i]):
				print(global.score)

				# If score is more than in score results => 
				# => save new score in file, 
				# remove old score from array,
				# insert new score in array 
				if (global.score > global.scores[i][j]):
					save_score_file.store_string(str(global.score))
					global.scores[i].remove(j)
					global.scores[i].insert(j, global.score)
				else:
					save_score_file.store_string(str(global.scores[i][j]))
			else:
					#!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!! FOR EXIST SCORES FROM FILE
				save_score_file.store_string(str(global.scores[i][j])) #str(0)
					#!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!! FOR EXIST SCORES FROM FILE
			#else :
			#	save_score_file.store_string(str(global.scores[i][j]))
			if (j != global.questions[global.discipline_mode][global.levels_types.keys()[i]].size() - 1):
				save_score_file.store_string(",")
			save_score_file.store_string("\n")
		save_score_file.store_string("}")
		if (i != global.levels_arr.size() - 1):
			save_score_file.store_string(",")
		save_score_file.store_string("\n")
	save_score_file.store_line("}")
	save_score_file.close()



# Each time when question asked, it erase from dictionary. Function return size of dict
func questions_last(qsts):
	return qsts.size()

# If all questions erased from dictionary - go to the next level!
func ready_next_level(qsts):
	if(questions_last(qsts) == 0): #and global.level_now != (global.lvls_count - 1)):
		return true
	else:
		return false


func _ready():
	pass
	# Called every time the node is added to the scene.
	# Initialization here
	# Get questions from file:
	#var questions_file = File.new()
	#questions_file.open("res://questions/qst.json", File.READ)
	#global.questions.parse_json(questions_file.get_as_text())
