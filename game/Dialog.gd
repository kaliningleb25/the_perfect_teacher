extends AcceptDialog

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

func _ready():
	# Called every time the node is added to the scene.
	# Initialization here
	var dlg = get_node(".")
	dlg.add_button("Wrong!", true, "EXIT")
	
	
	
