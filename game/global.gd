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

var used_index = [0,1]

var questions = {
"A cat has five legs" : 0,
"People have two eyes" : 1,
"A car can fly" : 0
}

func _ready():
	# Called every time the node is added to the scene.
	# Initialization here
	pass
