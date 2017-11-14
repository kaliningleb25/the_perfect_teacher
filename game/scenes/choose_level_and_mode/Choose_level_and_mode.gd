extends Control

# class member variables go here, for example:
# var a = 2
# var b = "textvar"
onready var scene = load("res://scenes/main/university.tscn")

func _ready():
	# Called every time the node is added to the scene.
	# Initialization here
	set_process(true)
	load_game()
	
	if (global.level_now >= 0) :
		get_node("Panel/btn_first_level").set_disabled(false)
	if (global.level_now >= 1) :
		get_node("Panel/btn_second_level").set_disabled(false)
	if (global.level_now >= 2) :
		get_node("Panel/btn_third_level").set_disabled(false)
	if (global.level_now >= 3) :
		get_node("Panel/btn_fourth_level").set_disabled(false)

func load_game():
	var save_file = File.new()
	if not save_file.file_exists("res://save.json"):
		return
	save_file.open("res://save.json", File.READ)
	global.levels_types.parse_json(save_file.get_as_text())
	# Get a opened levels from choosed category(1,2,3..n): 
	global.level_now = global.levels_types[global.category_mode]
	# Save all levels from each category to array:
	for i in range(0,global.levels_arr.size()) :
		global.levels_arr[i] = global.levels_types.values()[i]

# Start game with selected category and level:
func _on_btn_start_pressed():
	var new_game = scene.instance()
	get_parent().add_child(new_game)
	queue_free()


func _on_first_level_focus_enter():
	global.level_now = 0

func _on_btn_second_level_focus_enter():
	global.level_now = 1
	
func _on_btn_third_level_focus_enter():
	global.level_now = 2

# Open lectures for selected category and level:
# TODO : move all lectures to .json file
func _on_btn_lecture_pressed():
	var t = get_node("Panel/btn_first_level")

	if(global.discipline_mode == "programming" and global.category_mode == "c_plus_plus"):
		if (global.level_now == 0):
			#OS.shell_open("//the_perfect_teacher/c_lecture_1.pdf")
			OS.shell_open("http://cppstudio.com/post/1984/")
			OS.shell_open("http://cppstudio.com/post/1980/")
			OS.shell_open("http://cppstudio.com/post/348/")
			OS.shell_open("http://cppstudio.com/post/352/")
			OS.shell_open("http://cppstudio.com/post/361/")
			OS.shell_open("http://cppstudio.com/post/306/")
		if (global.level_now == 1):
			OS.shell_open("http://cppstudio.com/post/213/")
			OS.shell_open("http://cppstudio.com/post/259/")
			OS.shell_open("http://cppstudio.com/post/297/")
			OS.shell_open("http://cppstudio.com/post/286/")
			OS.shell_open("http://cppstudio.com/post/279/")
			OS.shell_open("http://cppstudio.com/post/310/")
		if (global.level_now == 2):
			OS.shell_open("http://cppstudio.com/post/437/")
			OS.shell_open("http://cppstudio.com/post/429/")
			OS.shell_open("http://cppstudio.com/post/423/")
			OS.shell_open("http://cppstudio.com/post/389//")
		if (global.level_now == 3):
			OS.shell_open("http://cppstudio.com/post/446/")
			



