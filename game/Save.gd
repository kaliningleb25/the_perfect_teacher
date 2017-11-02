#Stores, saves and loads game Settings in an ini-style file
extends Node

# class member variables go here, for example:
# var a = 2
# var b = "textvar"
const SAVE_PATH = "res://save.json"


func _ready():
	# Called every time the node is added to the scene.
	# Initialization here
	load_game()

func save_game():
	# Get all the save data from persistent nodes
	var save_dict = {}
	var nodes_to_save = get_tree().get_nodes_in_group('persistent') 
	for node in nodes_to_save:
		save_dict[node.get_path()] = node.save()
		
	
	# Create a file
	var save_file = File.new()
	save_file.open(SAVE_PATH, File.WRITE)
	
	# Serialize the data dictionary to JSON
	save_file.store_line(save_dict.to_json())
	# Write the JSON to the file and save to disk
	save_file.close()
	
	
func load_game():
	# Try to load a saved file
	# Parse the file data if it exist
	# load the data into persistent nodes
	pass