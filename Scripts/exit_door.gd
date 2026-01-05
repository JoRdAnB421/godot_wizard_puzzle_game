extends Area2D

func _ready() -> void:
	body_entered.connect(_on_area_entered)

func _on_area_entered(body) -> void:
	if body.is_in_group("player"):
		print("You win!")
		PlayerState._unlock_spells()
		Global._level_win()
	
