extends Node


# MEMBER VARIABLES
# For each correct answer score + 1
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

# What type of level rught now (C++, Java etc.)
var level_now

# For array of levels
var c_level
var java_level

# Array for save game for each discipline and category
var levels_arr = [c_level, java_level]

var check_focus = false

# Each time when question asked, it erase from dictionary. Function return size of dict
func questions_last(qsts):
	return qsts.size()

# If all questions erased from dictionary - go to the next level!
func ready_next_level(qsts):
	if(questions_last(qsts) == 0):
		return true
	else:
		return false

func _ready():
	# Called every time the node is added to the scene.
	# Initialization here
	# Get questions from file:
	var questions_file = File.new()
	questions_file.open("res://questions/qst.json", File.READ)
	global.questions.parse_json(questions_file.get_as_text())
