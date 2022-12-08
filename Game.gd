extends Control

var game_mode = ["easy", "normal", "hard", "clock", "timed"]
var current_game_mode

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func set_current_game_mode(mode):
	current_game_mode = mode
	
func start():
	pass
