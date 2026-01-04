extends NinePatchRect

const SPRITE_SIZE = Vector2(64,64)

@export var bkg_color: Color
@export var line_color: Color
@export var options: Array[SpellOption]


func _ready() -> void:
	options = PlayerState._get_known_spells()
	
	


func _process(delta: float) -> void:
	queue_redraw()
