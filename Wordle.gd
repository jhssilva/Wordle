extends Node

var initial_screen_scene
var languages = ["pt", "en"]
var current_language

# Called when the node enters the scene tree for the first time.
func _ready():
	set_initial_variables()
	hide_all_scenes()
	initial_screen_scene.set_language_selection_dropdown(languages)
	initial_screen_scene.show()

func set_initial_variables():
	current_language = languages[0] # Portuguese
	initial_screen_scene = $InitialScreen

func hide_all_scenes():
	initial_screen_scene.hide()

func _on_InitialScreen_language_changed():
	current_language = initial_screen_scene.get_current_language()
