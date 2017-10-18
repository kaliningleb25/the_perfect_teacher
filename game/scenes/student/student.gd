extends Sprite

# class member variables go here, for example:
# var a = 2
# var b = "textvar"
const MOVEMENT_SPEED = 2
#onready var dialog = get_tree().get_root().get_node("/Control/dialog")
onready var dialog_scene = load("res://scenes/dialog/dialog.tscn") # will load when parsing the script
onready var check = true


func _ready():
	# Called every time the node is added to the scene.
	# Initialization here

	
	set_process(true)
	set_process_input(true)
	
#func _input(event):
	#var new_dialog = dialog_scene.instance()
	#get_parent().add_child(new_dialog)
	
func _process(delta):
	set_pos(Vector2(get_pos().x + MOVEMENT_SPEED, get_pos().y))
	#print(get_pos().x)
	#print(get_pos().x)
	#if (get_pos().x >= 650 and get_pos().x <= 650.6):
	if (get_pos().x == 624.565674):
		var new_dialog = dialog_scene.instance()
		get_parent().add_child(new_dialog)
		global.dialog_scene_counter += 1
		print("global.dialog_scene_counter ", str(global.dialog_scene_counter))


		
	if ((get_pos().x > OS.get_window_size().x) or (get_pos().x == 624.565674)):#or (get_pos().x >= 650 and get_pos().x <= 670)):
		queue_free()

