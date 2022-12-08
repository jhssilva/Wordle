extends Control

var img_pt = load("res://assets/how_to_play_pt.png")
var img_en = load("res://assets/how_to_play_en.png")
var info

signal closed

# Called when the node enters the scene tree for the first time.
func _ready():
	info = $Info

func set_image(language):
	if language == "pt":
		info.set_texture(img_pt)
	else:
		info.set_texture(img_en)

func _on_TextureButton_pressed():
	emit_signal("closed")
