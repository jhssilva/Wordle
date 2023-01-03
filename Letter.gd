extends Label

var bg_default = load("res://assets/bg_default.tres")
var bg_gray = load("res://assets/bg_gray.tres")
var bg_green = load("res://assets/bg_green.tres")
var bg_yellow = load("res://assets/bg_yellow.tres")

var array_status = [bg_default, bg_gray, bg_green, bg_yellow]

onready var letter = $"."

func _ready():
	change_status(0)

func change_status(status):
	theme = array_status[status]
	
func clear_label():
	change_label("")
	
func change_label(label):
	letter.text = label
