extends Control

var game_mode = ["easy", "normal", "hard", "clock", "timed"]
var current_game_mode
var current_word
var current_language = "en"
var current_row_option = 1
var file_path_en = "res://assets/en_US.txt"
var file_path_pt = "res://assets/pt_PT.txt"
var file
var rng = RandomNumberGenerator.new()
var word_input: String = ""
onready var row_path = [$Container/Options/FirstRow,
 $Container/Options/SecondRow,
$Container/Options/ThirdRow,
$Container/Options/ForthRow,
$Container/Options/FifthRow]

# Called when the node enters the scene tree for the first time.
func _ready():
	rng.randomize()
	set_new_word()
	pass # Replace with function body.

func set_current_game_mode(mode):
	current_game_mode = mode
	
func set_current_language(language):
	current_language = language

func start():
	clear_game_variables()
	set_new_word()

func clear_game_variables():
	current_row_option = 1

func set_new_word():
	current_word = get_word()

func get_word():
	var array_data = load_data_current_language()
	var random_number = get_random_number(0, array_data.size()-1)
	return array_data[random_number]
	
func get_random_number(begin, end):
	return rng.randi_range(begin, end)

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
func _input(event):
	if event.is_action_pressed("enter"):
		game_iteraction()
	elif event.is_action_pressed("backspace"):
		handle_backspace_pressed()
	elif (
		event is InputEventKey and
		event.is_echo() == false and
		event.is_pressed() and
		event.as_text().length() == 1 and
		word_input.length() < current_word.length()
	):
		var letter = event.as_text()
		word_input += letter
		update_ui_letter(letter)

func game_iteraction():
	current_row_option += 1
	word_input = ""

func update_ui_letter(letter):
	var position_row_on_array = current_row_option - 1
	var position_letter = word_input.length()
	var letter_to_update_path = row_path[position_row_on_array].get_node("Letter" + String(position_letter))
	letter_to_update_path.change_label(letter)

func handle_backspace_pressed():
	if(word_input.length() == 0):
		return
	delete_letter()

func delete_letter():
	update_ui_letter("")
	var prev_size = word_input.length()
	if(prev_size == 1):
		word_input = ""
	else:
		word_input = word_input.substr(0, prev_size-1)
	
