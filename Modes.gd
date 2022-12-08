extends Node

signal close
signal normal_mode


# Called when the node enters the scene tree for the first time.
func _ready():
	pass

func set_language(language):
	if language == "pt":
		$Control/Options/EasyMode.text = "Facil"
		$Control/Options/NormalMode.text = "Normal"
		$Control/Options/HardMode.text = "Dificil"
		$Control/Options/AgainstTheClockMode.text = "Contra o Relogio"
		$Control/Options/TimedMode.text = "Cronometrado"
	else:
		$Control/Options/EasyMode.text = "Easy"
		$Control/Options/NormalMode.text = "Normal"
		$Control/Options/HardMode.text = "Hard"
		$Control/Options/AgainstTheClockMode.text = "Against the Clock"
		$Control/Options/TimedMode.text = "Timed"

func _on_CloseButton_pressed():
	emit_signal("close")

func _on_NormalMode_pressed():
	emit_signal("normal_mode")
