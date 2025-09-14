extends Control

@onready var animation_player: AnimationPlayer = $AnimationPlayer


func _ready() -> void:
	animation_player.connect("animation_finished", _load_menu)
	animation_player.play("godot_logo_fadein")


func _load_menu(_sig) -> void:
	Global.goto_scene("res://Scenes/main_menu.tscn")
