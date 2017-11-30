extends Node2D

# class member variables go here, for example:
# var a = 2
# var b = "textvar"
var screen_size
var door_programming_size

onready var scene = load("res://scenes/interactive_menu_programming/interactive_menu_programming.tscn")
onready var door_programming = get_node("door_programming")

func _ready():
	check_sound()
	AudioServer.set_fx_global_volume_scale(global.sound)
	get_tree().set_auto_accept_quit(true)
	# Called every time the node is added to the scene.
	# Initialization here
	screen_size = get_viewport_rect().size
	
	door_programming_size = get_node("door_programming").get_texture().get_size()	
	global.student_auto_mode = false
	if (not global.student_position == null):
		get_node("stud/torso").set_pos(global.student_position)
	
	set_process(true)

func _process(delta):
	var stud_pos = get_node("stud/torso").get_pos()
	var label = get_node("label")
	var door_programming_rect = Rect2( get_node("door_programming").get_pos() - door_programming_size*0.5, door_programming_size )
		
	if(door_programming_rect.has_point(stud_pos) and Input.is_action_pressed("ui_up")):
		get_node("SamplePlayer").play("door_opened2")
		print("ENTER THE DOOR!")
		global.discipline_mode = "programming"
		global.student_position = stud_pos
		var new_interactive_menu_programming = scene.instance()
		get_parent().add_child(new_interactive_menu_programming)
		queue_free()


func _on_TextureButton_toggled( pressed ):
	if (pressed):
		print("pressed")
		AudioServer.set_fx_global_volume_scale(0)
	else :
		get_node("background/bell").release_focus()
		AudioServer.set_fx_global_volume_scale(1)

func check_sound():
	if (global.sound == 0):
		get_node("bell_on").hide()
		get_node("bell_off").show()
	else:
		get_node("bell_off").hide()
		get_node("bell_on").show()




func _on_bell_on_button_down():
	get_node("bell_on").hide()
	get_node("bell_off").show()
	global.sound = 0
	AudioServer.set_fx_global_volume_scale(global.sound)
	

func _on_bell_off_button_down():
	get_node("bell_off").hide()
	get_node("bell_on").show()
	global.sound = 1
	AudioServer.set_fx_global_volume_scale(global.sound)
