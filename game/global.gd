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

# Array for save game for each category
var c_plus_plus
var java

var levels_arr = [c_plus_plus, java]
# ------------------------------------------

var scores_c = []
var scores_java = []

var scores = [scores_c, scores_java]

# 0 = c_level, 1 = java_level
var index_of_level
var check_focus = false
var student_reach_teacher = false
var question_answered = false
var check_start_new_game = false

var check_return
var student_auto_mode
var student_position

var answer_is_true = false
var check_restart_game_or_exit_to_menu = false
var test = {}
var levels_enabled
var check_exit = false

var sound = 1
var question_answered_for_sound = false

var lvls_count
var student_wait = false
var key_up_pressed = false
var check_start = false

var student_step_right = false
var student_step_left = false
var student_enter_the_door = false
var sound_timer = false

var music_play = false


func save_score():
	var save_score_file = File.new()
	save_score_file.open_encrypted_with_pass("res://score/score.json", File.WRITE, "score")
	save_score_file.store_line("{")
	for i in range (0, global.levels_arr.size()):
		save_score_file.store_string("\"")
		save_score_file.store_string(global.levels_types.keys()[i])
		save_score_file.store_string("\"")
		save_score_file.store_string(" : ")
		save_score_file.store_string("{\n")
		for j in range(0, global.questions[global.discipline_mode][global.levels_types.keys()[i]].size()): 
			save_score_file.store_string("\"")
			save_score_file.store_string(str(j))
			save_score_file.store_string("\"")
			save_score_file.store_string(" : ")
			if (global.level_now == j and global.category_mode == global.levels_types.keys()[i]):
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
				save_score_file.store_string(str(global.scores[i][j]))
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
