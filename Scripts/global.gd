extends Node

@onready var current_scene = get_tree().current_scene

func goto_scene(path):
	"""Changes to a given scene based on path but need to make sure that we 
	don't delete current scene before all code is completed so we defer the new
	scene loading
	"""
	_deferred_goto_scene.call_deferred(path)
	
func _deferred_goto_scene(path):
	# Now safe to remove current scene
	current_scene.free()
	
	# Load the new scene
	var new_scene = ResourceLoader.load(path)
	
	# Instance and add to active scene 
	current_scene = new_scene.instantiate()
	
	# Add it to the active scene, as a child of the root
	get_tree().root.add_child(current_scene)
