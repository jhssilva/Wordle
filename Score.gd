extends Control


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
signal timeout

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func change_language(language):
	if (language == "en"):
		$Container/Label.text = "Score:"
	else:
		$Container/Label.text = "Pontuacao:"
	
func change_score(score):
	$Container/Score.text = String(score)
	
func start():
	$Timer.start()
	
func _on_Timer_timeout():
	emit_signal("timeout")
