extends Node2D

# Member variables
var screen_size
var teacher_size
var direction = Vector2(1.0, 0.0)

onready var students = get_tree().get_nodes_in_group("students")


#Constant for student speed (in pixels/second)
const INITIAL_STUDENT_SPEED = 280
#Speed of the ball (in pixels/second)
var student_speed = INITIAL_STUDENT_SPEED

#onready var dialog = get_node("Control/dialog")
#onready var b_correct = get_node("Control/dialog/b_correct")
#onready var b_wrong = get_node("Control/dialog/b_wrong")


onready var check = 0

onready var stud_array = []
onready var students_pos = []

onready var scene = load("res://scenes/student/student.tscn") # will load when parsing the script

onready var scr = get_node("Control/score")
onready var counter = 0
# Timer
#var timer = null
var student_delay = 1
var can_go = true
onready var timer = get_node("Timer")

func _ready():
	# Called every time the node is added to the scene.
	# Initialization here

	# Create timer for student delay
	#timer = Timer.new()
	#timer.set_one_shot(true)
	#timer.set_wait_time(student_delay)
	#timer.connect("timeout", self, "on_timeout_complete") 
	#add_child(timer) 

	
	screen_size = get_viewport_rect().size
	teacher_size = get_node("teacher").get_texture().get_size()
#	for s in students:
#		stud_array.append(s)
		
	#var students_pos = []
	#for i in range(0, stud_array.size()):
	#	students_pos.append(stud_array[i].get_pos())
	
	#print("students_pos[0] ", students_pos[0])
	##for s in students:
	##	stud_array.append(s)
	

	##for i in range(0, stud_array.size()):
	##	students_pos.append(stud_array[i].get_pos())
	
	
	
	set_process_input(true)
	
	set_process(true)
	

# On Timer's timeout complete
#func on_timeout_complete():
#	can_go = true
	

#func _input(event):
	
		
	
	# Disable going until timer's timeout complete
	
	
	# Start timer
	
	

func _process(delta):
	
	if (can_go):
		if (global.dialog_scene_counter > 0):
			var new_student = scene.instance()
			get_parent().add_child(new_student)
		#counter += 1
		#scr.set_text(str(counter))
			can_go = false
			timer.start()
	
	if (global.gameovercheck):
		queue_free()
	
		
	#var student_pos = get_tree().get_root().get_node("res://scenes/student/student1").get_pos()
	#var student_pos = get_node("/root/student").get_pos()

	#var student_pos = stud_array[0].get_pos()
	#var student_pos2 = stud_array[1].get_pos()
		# stud_array.size() = 2

	
	#print("student pos ", student_pos)
	#print("array of students pos", students_pos)
	#print("second of array ", student_pos2)
	
	


	
	var teacher_pos = get_node("teacher").get_pos()
	#print(teacher_pos.x)

	var teacher_rect = Rect2(teacher_pos - teacher_size*0.5, teacher_size)
	
	##for i in range(0, students_pos.size()):
	##	students_pos[i] += direction * (student_speed/(i+2)) * delta

		# FOR TEST ----

	#--------------
	
	# Pause, change direction and increase speed when come to teacher and check student's answer
	##for i in range(0, students_pos.size()):
	#if ((teacher_rect.has_point(student_pos))):
	#if (teacher_pos.x == student_pos.x):
	#	dialog.show()
		
			#get_tree().get_root().add_child(scene.instance())

	##		students_pos[i] = stud_array[i].get_pos()
			
	##		if (b_correct.is_pressed() or b_wrong.is_pressed()):
				#direction.x = direction.x * (-1)
				#students_pos[i] += direction * (student_speed/(i+2)) * delta
				#stud_array[i].set_pos(students_pos[i])
				#direction.x = -direction.x
				#student_speed *= 1.1
	##			students_pos.erase(students_pos[i])
	##			stud_array.erase(stud_array[i])
	##			stud_array[i].queue_free()
			
				
			
			
	
		
		
	#for i in range(0, students_pos.size()):
		#stud_array[i].set_pos(students_pos[i])
	##stud_array[0].set_pos(students_pos[0])
	
	





func _on_Timer_timeout():
	can_go = true
