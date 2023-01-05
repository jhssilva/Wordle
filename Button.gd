extends Button

var bg_default = load("res://assets/bg_default_button.tres")
var bg_green = load("res://assets/bg_green_button.tres")
var bg_yellow = load("res://assets/bg_yellow_button.tres")

var array_status = [bg_default, bg_green, bg_yellow]

var current_key = ""

signal clicked(label)

onready var key = $"."

func _ready():
	clear()
	clear_status()

func change_status(status_pos):
	theme = array_status[status_pos]
	
func clear_label():
	change_label("")
	current_key = ""
	
func clear_status():
	key.disabled = false
	change_status(0)

func set_initial(label):
	clear_status()
	change_label(label)
	
func set_status_default():
	clear_status()

func set_status_gray():
	key.disabled = true

func set_status_green():
	change_status(1)

func set_status_yellow():
	change_status(2)
	
func change_label(label):
	key.text = label
	current_key = label

func clear():
	clear_label()
	change_status(0)

func _on_Key_pressed():
	emit_signal("clicked", current_key)
