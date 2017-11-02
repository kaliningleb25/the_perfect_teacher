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
	print(global.level)
	var full_circles = get_tree().get_nodes_in_group("full_circles")
	if (global.level > 0) :
		get_node("Panel/TextureButton").set_disabled(false)
	if (global.level > 1) :
		get_node("Panel/TextureButton1").set_disabled(false)
	if (global.level > 2) :
		get_node("Panel/TextureButton2").set_disabled(false)
	
		

		

	
	
	
	
	
func load_game():
	var save_file = File.new()
	if not save_file.file_exists("res://save.json"):
		return
	save_file.open("res://save.json", File.READ)
	var lvl = save_file.get_as_text()
	global.level = int(lvl)


func _on_btn_start_pressed():
	var new_game = scene.instance()
	get_parent().add_child(new_game)
	queue_free()
