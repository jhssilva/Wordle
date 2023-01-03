extends Node

var initial_screen_scene
var modes_control_scene
var modes_scene
var game_scene
var languages = ["pt", "en"]
var current_language
var score = 0
var score_points = [-8, 32, 16, 8 , 4, 2, 1]

# Called when the node enters the scene tree for the first time.
func _ready():
	set_initial_variables()
	hide_all_scenes()
	initial_screen_scene.set_language_selection_dropdown(languages)
	initial_screen_scene.show()

func set_initial_variables():
	current_language = languages[0] # Portuguese
	initial_screen_scene = $InitialScreen
	modes_control_scene = $Modes/Control
	modes_scene = $Modes
	game_scene = $Game
	score = 0

func hide_all_scenes():
	initial_screen_scene.hide()
	modes_control_scene.hide()
	game_scene.hide()
	
func _on_InitialScreen_language_changed():
	current_language = initial_screen_scene.get_current_language()

func _on_InitialScreen_start_pressed():
	initial_screen_scene.hide()
	modes_scene.set_language(current_language)
	modes_control_scene.show()

func _on_Modes_close():
	modes_control_scene.hide()
	initial_screen_scene.show()

func _on_Modes_normal_mode():
	modes_control_scene.hide()
	game_scene.set_current_game_mode("normal")
	game_start()

func game_start():
	game_scene.set_current_language(current_language)
	game_scene.show()
	game_scene.start()

func _on_Game_won_game():
	var level = game_scene.current_row_option
	var points_won = score_points[level]
	score += points_won
	$Timer_end_game.start()
	# Display victory screen with current points and points won

func _on_Game_lost_game():
	var points_lost = score_points[0]
	score += points_lost
	$Timer_end_game.start()
	# Display lost screen with current points and points won
	

func _on_Timer_end_game_timeout():
	hide_all_scenes()
	initial_screen_scene.show() #Change this
