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
	if (global.check_focus):
		var new_game = scene.instance()
		get_parent().add_child(new_game)
		queue_free()
	else :
		get_node("PopupDialog").show()


func _on_first_level_focus_enter():
	global.level_now = 0
	global.check_focus = true
	get_node("PopupDialog").hide()

func _on_btn_second_level_focus_enter():
	global.level_now = 1
	global.check_focus = true
	get_node("PopupDialog").hide()
	
func _on_btn_third_level_focus_enter():
	global.level_now = 2
	global.check_focus = true
	get_node("PopupDialog").hide()
	
func _on_btn_fourth_level_focus_enter():
	global.level_now = 3
	global.check_focus = true
	get_node("PopupDialog").hide()

# Open lectures for selected category and level:
func _on_btn_lecture_pressed():
	if(global.check_focus) :
		var t = get_node("Panel/btn_first_level")

		var lectures_file = File.new()
		lectures_file.open("res://lectures/lectures.json", File.READ)
	
		var lectures = {}
	
		lectures.parse_json(lectures_file.get_as_text())
		# Parse from .json file all lectures for selected discipline, category and level:
		var lects = lectures[global.discipline_mode][global.category_mode][str(global.level_now)]

		# Open all lectures for selected discipline, category and level in browser:
		for i in range(0, lects.size()) :
			OS.shell_open(lects[i])
	else :
		get_node("PopupDialog").show()
		
	






