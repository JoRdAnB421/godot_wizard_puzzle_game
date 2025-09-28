#@tool
extends Control

const SPRITE_SIZE = Vector2(56,56)

@export var bkg_color: Color
@export var line_color: Color

@export var outer_radii : int = 256
@export var inner_radii : int = 64
@export var line_width  : int = 4
@export var options : Array[SpellOption]
var font

func _ready() -> void:
	options = PlayerState._get_known_spells()
	font = get_theme_default_font()
	print(font)

func _draw() -> void:
	var offset = SPRITE_SIZE / -2
	
	draw_circle(Vector2.ZERO, outer_radii, bkg_color)
	draw_arc(Vector2.ZERO, inner_radii, 0, TAU, 128, line_color, line_width, true)

	if len(options) >= 3:
		
		# Draw separator lines
		for i in range(len(options)-1):
			var rads = TAU * i /((len(options)-1))
			var point = Vector2.from_angle(rads)
			draw_line(
				Vector2(0,0),
				point*outer_radii,
				line_color,
				line_width,
				true
			)
	
	for j in range(1, len(options)):
		var start_rads = (TAU * (j-1)) / (len(options)-1)
		var end_rads = (TAU * (j)) / (len(options)-1)
		var mid_rad = (start_rads + end_rads) / 2.0 * -1 
		var radii_mid = (inner_radii + outer_radii) / 2.0
		
		var draw_pos = radii_mid * Vector2.from_angle(mid_rad) + offset
		
		draw_texture_rect_region(
			options[j].atlas,
			Rect2(draw_pos, SPRITE_SIZE),
			options[j].region
		)
			
		var string_pos = inner_radii / 2.0 * Vector2.from_angle(mid_rad)
		draw_string(
			font,
			string_pos,
			str(j), 0 as HorizontalAlignment, -1, 16)
		
		
func _process(_delta: float) -> void:
	queue_redraw()
