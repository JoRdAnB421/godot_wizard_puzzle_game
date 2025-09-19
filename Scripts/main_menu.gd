extends PanelContainer

@onready var continue_on: RichTextLabel = $MarginContainer/VBoxContainer/HBoxContainer/MenuOptions/RichTextLabel
@onready var new_game: RichTextLabel = $MarginContainer/VBoxContainer/HBoxContainer/MenuOptions/RichTextLabel2
@onready var options: RichTextLabel = $MarginContainer/VBoxContainer/HBoxContainer/MenuOptions/RichTextLabel3
@onready var controls: RichTextLabel = $MarginContainer/VBoxContainer/HBoxContainer/MenuOptions/RichTextLabel4
@onready var animation_player: AnimationPlayer = $AnimationPlayer

func _ready() -> void:
	# connecting button signals
	continue_on.connect("meta_clicked", _on_meta_clicked)
	new_game.connect("meta_clicked", _on_meta_clicked)
	options.connect("meta_clicked", _on_meta_clicked)
	controls.connect("meta_clicked", _on_meta_clicked)
	
	animation_player.connect("animation_finished", remove_cover)
	animation_player.play("fade_in")

func remove_cover(_sig) -> void:
	animation_player.get_children()[0].queue_free()
	
func _on_meta_clicked(sig) -> void:
	match sig:
		"Continue":
			print("Continue")
		"New":
			Global.goto_scene("res://Scenes/level1.tscn")
		"Options":
			print("Options")
		"Controls":
			print("Controls")
	
	release_focus()
