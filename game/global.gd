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

var questions = {
"Вопрос: Когда необходимо составлять блок-схему программы?\nОтвет: до начала составления самой программы" : 1,
"Вопрос: Наиболее наглядной формой описания алгоритма является структурно-стилизованный метод\nОтвет: язык программирования высокого уровня" : 0,
"Вопрос: Перевод программ с языка высокого уровня на язык более низкого уровня обеспечивает...\nОтвет: компилятор" : 1#,
#"Как" : 1
}

var questions_lvl2 = {
"Test1" : 1,
"Test2" : 1,
"Test3" : 1,
"Test4" : 1
}

var questions_lvl3 = {
"SuperTest1" : 0,
"SuperTest2" : 0,
"SuperTest3" : 0,
"SuperTest4" : 0
}

var level = 0

var all_questions = [questions, questions_lvl2, questions_lvl3]

var can_go = false

var teacher_pos
var teacher_size

var door_programming_pos





func questions_last(qsts):
	return qsts.size()

func ready_next_level(qsts):
	if(questions_last(qsts) == 0):
		return true
	else:
		return false

func _ready():
	# Called every time the node is added to the scene.
	# Initialization here
	pass
