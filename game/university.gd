extends Node2D

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

# Member variables
var screen_size
var teacher_size
var direction = Vector2(1.0, 0.0)

onready var students = get_tree().get_nodes_in_group("students")


#Constant for student speed (in pixels/second)
const INITIAL_STUDENT_SPEED = 280
#Speed of the ball (in pixels/second)
var student_speed = INITIAL_STUDENT_SPEED

onready var dialog = get_node("Control/dialog")
onready var b_correct = get_node("Control/dialog/b_correct")
onready var b_wrong = get_node("Control/dialog/b_wrong")

onready var check = 0

onready var stud_array = []

func _ready():
	# Called every time the node is added to the scene.
	# Initialization here
	screen_size = get_viewport_rect().size
	teacher_size = get_node("teacher").get_texture().get_size()
#	for s in students:
#		stud_array.append(s)
		
	#var students_pos = []
	#for i in range(0, stud_array.size()):
	#	students_pos.append(stud_array[i].get_pos())
	
	#print("students_pos[0] ", students_pos[0])
	for s in students:
		stud_array.append(s)
	
	
	
	set_process(true)
	

func _process(delta):
	
	# trying to make a loop of all students in a group and added them to array

	
		
	#var student_pos = get_node("student").get_pos()
	var students_pos = []
	for i in range(0, stud_array.size()):
		students_pos.append(stud_array[i].get_pos())
	#var student_pos = stud_array[0].get_pos()
	#var student_pos2 = stud_array[1].get_pos()
		# stud_array.size() = 2

	
	#print("student pos ", student_pos)
	print("array of students pos", students_pos)
	#print("second of array ", student_pos2)
	
	


	
	var teacher_pos = get_node("teacher").get_pos()
	var teacher_rect = Rect2(teacher_pos - teacher_size*0.5, teacher_size)
	
	students_pos[0] += direction * student_speed * delta

		# FOR TEST ----

	#--------------
	
	# Pause, change direction and increase speed when come to teacher and check student's answer
	if ((teacher_rect.has_point(students_pos[0]))):
		dialog.show()

		students_pos[0] = get_node("student").get_pos()
		if (b_correct.is_pressed() or b_wrong.is_pressed()):
			direction.x = -direction.x
			student_speed *= 1.1
			
			
	
		
		
		
	
	get_node("student").set_pos(students_pos[0])
	
	



