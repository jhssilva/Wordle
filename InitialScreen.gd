extends Control

var language_dropdown
var languages_list
var current_language
var help_scene

signal language_changed
signal start_pressed

# Called when the node enters the scene tree for the first time.
func _ready():
	set_initial_variables()
	hide_scenes()

func set_initial_variables():
	language_dropdown = $"Top Container/Language Selection"
	help_scene = $"Help"

func hide_scenes():
	help_scene.hide()

func set_language_selection_dropdown(languages = ["pt"]):
	languages_list = languages
	current_language = languages_list[0]
	set_labels_on_language_update()
	for i in range(0, languages.size()):
		language_dropdown.add_item(languages[i], i)

func get_current_language() -> String:
	return current_language

func _on_Exit_pressed():
	get_tree().quit()

func _on_Language_Selection_item_selected(index):
	current_language = languages_list[index]
	set_labels_on_language_update()
	emit_signal("language_changed")

func set_labels_on_language_update():
	#Only for two languages ("pt" and "en")
	if current_language == "pt":
		$Menu/Start.text	= "Começar"
		$Menu/Score.text = "Pontuação"
		$Menu/Help.text = "Ajuda"
		$Menu/Exit.text = "Sair"
	else: 
		$Menu/Start.text = "Start"
		$Menu/Score.text = "Score"
		$Menu/Help.text = "Help"
		$Menu/Exit.text = "Exit"

func _on_Help_pressed():
	help_scene.set_image(current_language)
	help_scene.show()
	
func _on_Help_closed():
	help_scene.hide()

func _on_Start_pressed():
	emit_signal("start_pressed")
