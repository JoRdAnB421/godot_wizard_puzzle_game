extends Node

@onready var current_scene = get_tree().current_scene
@onready var success_screen = preload("res://Scenes/success_layer.tscn")

func goto_scene(path):
	"""Changes to a given scene based on path but need to make sure that we 
	don't delete current scene before all code is completed so we defer the new
	scene loading
	"""
	_deferred_goto_scene.call_deferred(path)
	get_tree().paused = false
	
func _deferred_goto_scene(path):
	# Now safe to remove current scene
	current_scene.free()
	
	# Load the new scene
	var new_scene = ResourceLoader.load(path)
	
	# Instance and add to active scene 
	current_scene = new_scene.instantiate()
	
	# Add it to the active scene, as a child of the root
	get_tree().root.add_child(current_scene)

func _level_win() -> void:
	get_tree().paused = true
	var win_screen = success_screen.instantiate()
	current_scene.add_child(win_screen)
	
