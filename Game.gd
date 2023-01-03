extends Control

var game_mode = ["easy", "normal", "hard", "clock", "timed"]
var current_game_mode
var current_word
var current_language = "en"
var file_path_en = "res://assets/en_US.txt"
var file_path_pt = "res://assets/pt_PT.txt"
var file

# Called when the node enters the scene tree for the first time.
func _ready():
	get_word()
	pass # Replace with function body.

func set_current_game_mode(mode):
	current_game_mode = mode
	
func set_current_language(language):
	current_language = language

func start():
	# Get a word fron the file that will be the word
	# that will be guessed
	set_new_word()
	pass

func set_new_word():
	current_word = get_word()

func get_word():
	# Read from file, depending on the language.
	var array_data = load_data_current_language()
	print(array_data)
	return
	
func load_data_current_language():
	file = File.new()
	file.open(get_current_file_path(), file.READ)
	var array_words = []
	while not file.eof_reached():
		var line = file.get_line()
		if (line.length() == 5):
			array_words.append(line.to_lower())
	file.close()
	return array_words

func get_current_file_path():
	if current_language == "pt":
		return file_path_pt
	return file_path_en

# Called when a key is clicked
func _input(ev):
	if ev is InputEventKey and ev.scancode == KEY_K and not ev.echo:
		print("teste")
