extends Control

var game_mode = ["easy", "normal", "hard", "clock", "timed"]
var current_game_mode
var current_word
var word_size = 5
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
$Container/Options/FifthRow,
$Container/Options/SixthRow]

signal won_game
signal lost_game

# Called when the node enters the scene tree for the first time.
func _ready():
	rng.randomize()

func set_current_game_mode(mode):
	current_game_mode = mode
	
func set_current_language(language):
	current_language = language

func start():
	clear_game_variables()
	set_new_word()

func clear_game_variables():
	current_row_option = 1
	word_input = ""
	clear_all_letters()

func clear_all_letters():
	for i in range(row_path.size()):
		for x in range(word_size):
			get_path_letter_pos_row(i, x+1).clear()

func set_new_word():
	current_word = get_word()
	print(current_word)

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
		if(word_input.length() >= current_word.length()):
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
	update_information_on_row()
	if (check_win()):
		handle_win()
		return
	set_new_turn()

func update_information_on_row():
	for i in range(current_word.length()):
		if (current_word.to_lower()[i] == word_input.to_lower()[i]):
			update_letter_green(i+1)
		else:
			var aux_character = word_input.to_lower()[i]
			var found = false
			for x in range(current_word.length()):
				if (i != x && aux_character == current_word[x]):
					update_letter_yellow(i+1)
					found = true
					break
			if(!found):
				update_letter_gray(i+1)

func update_letter_green(position):
	var letter_path = get_path_letter_pos(position)
	letter_path.change_status(2)
	
func update_letter_yellow	(position):
	var letter_path = get_path_letter_pos(position)
	letter_path.change_status(3)

func update_letter_gray(position):
	var letter_path = get_path_letter_pos(position)
	letter_path.change_status(1)

func get_path_letter_pos(position):
	var position_row_on_array = current_row_option - 1
	var letter_to_update_path = row_path[position_row_on_array].get_node("Letter" + String(position))
	return letter_to_update_path

func get_path_letter_pos_row(row, position):
	var letter_to_update_path = row_path[row].get_node("Letter" + String(position))
	return letter_to_update_path

func set_new_turn():
	if(current_row_option >= row_path.size()):
		handle_end_game()
		return
	
	current_row_option += 1
	word_input = ""
	
func check_win():
	return current_word.to_lower() == word_input.to_lower()
	 
func handle_win():
	emit_signal("won_game")
	
func handle_end_game():
	emit_signal("lost_game")

func update_ui_letter(letter):
	var position_letter = word_input.length()
	get_path_letter_pos(position_letter).change_label(letter)

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
	
