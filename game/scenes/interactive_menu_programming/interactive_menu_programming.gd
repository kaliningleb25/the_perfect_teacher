extends Node2D

var screen_size
var door_size


onready var scene = load("res://scenes/choose_level_and_mode/choose_level_and_mode.tscn")
onready var exit_to_previous_corridor_scene = load("res://scenes/interactive_menu/interactive_menu.tscn") # Back to previous corridor

onready var door_c = get_node("door_c")
onready var door_java = get_node("door_java")

onready var stud_pos


func _ready():
	# Check sound on or off
	check_sound()
	AudioServer.set_fx_global_volume_scale(global.sound)
	get_tree().set_auto_accept_quit(true)

	global.student_auto_mode = false

	screen_size = get_viewport_rect().size
	# Can refactor using .JSOM
	if (global.discipline_mode == "programming"):
		get_node("label_c").set_text("C++")
		get_node("label_java").set_text("Java")
		
	door_size = get_node("door_c").get_texture().get_size()
	

	
	set_process(true)

func _process(delta):
	if (not (get_node("music_menu_2d").is_voice_active(0) )):
		get_node("music_menu_2d").play("music_menu")	
	print("test")
#	print(global.student_auto_mode)
	if (global.student_auto_mode == false):
		stud_pos = get_node("stud/torso").get_pos()
	
	var door_c_rect = Rect2( get_node("door_c").get_pos() - door_size*0.5, door_size )
	var door_java_rect = Rect2( get_node("door_java").get_pos() - door_size*0.5, door_size)

	if(door_c_rect.has_point(stud_pos) and Input.is_action_pressed("ui_up")):
		if (!global.key_up_pressed):
			get_node("SamplePlayer").play("knock_on_the_door2")
			print("ENTER THE DOOR!")
			global.category_mode = "c_plus_plus"
			global.ekz_type = "\"" + "C++" + "\""
			global.index_of_level = 0
			global.student_wait = true
			var goto_choose_level_and_mode = scene.instance()
			get_parent().add_child(goto_choose_level_and_mode)

	if(door_java_rect.has_point(stud_pos) and Input.is_action_pressed("ui_up")):
		if (!global.key_up_pressed):
			get_node("SamplePlayer").play("knock_on_the_door2")
			print("ENTER THE DOOR!")
			global.category_mode = "java"
			global.ekz_type = "\"" + "Java" + "\""
			global.index_of_level = 1
			global.student_wait = true
			var goto_choose_level_and_mode = scene.instance()
			get_parent().add_child(goto_choose_level_and_mode)
		
	if(stud_pos.x < 0): 
		var exit_to_prev_cor = exit_to_previous_corridor_scene.instance()
		get_parent().add_child(exit_to_prev_cor)
		global.check_return = 0
		queue_free()
		
	if (global.check_start_new_game): 
		queue_free()
		global.check_start_new_game = false
		
	if (global.check_start):
		queue_free()

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
