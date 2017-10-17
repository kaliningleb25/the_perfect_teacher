extends Node2D

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

# Member variables
var screen_size
var teacher_size
var direction = Vector2(1.0, 0.0)


#Constant for student speed (in pixels/second)
const INITIAL_STUDENT_SPEED = 280
#Speed of the ball (in pixels/second)
var student_speed = INITIAL_STUDENT_SPEED

onready var dialog = get_node("Control/dialog")
onready var question = get_node("Control/dialog/question")
onready var b_right = get_node("Control/dialog/b_right")
onready var b_wrong = get_node("Control/dialog/b_wrong")

func _ready():
	# Called every time the node is added to the scene.
	# Initialization here
	screen_size = get_viewport_rect().size
	teacher_size = get_node("teacher").get_texture().get_size()
	

	
	set_process(true)
	
func _process(delta):
	var student_pos = get_node("student").get_pos()
	var teacher_pos = get_node("teacher").get_pos()
	var teacher_rect = Rect2(teacher_pos - teacher_size*0.5, teacher_size)
	
	student_pos += direction * student_speed * delta

	# Pause, change direction and increase speed when come to teacher and check student's answer
	if ((teacher_rect.has_point(student_pos))):
		dialog.show()
		student_pos = get_node("student").get_pos()
		if (b_right.is_pressed() or b_wrong.is_pressed()):
			direction.x = -direction.x
			#direction = direction.normalized()
			student_speed *= 1.1
		
	
	get_node("student").set_pos(student_pos)
	

