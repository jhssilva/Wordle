extends Control

onready var key_q = $Rows/First/Q
onready var key_w = $Rows/First/W
onready var key_e = $Rows/First/E
onready var key_r = $Rows/First/R
onready var key_t = $Rows/First/T
onready var key_y = $Rows/First/Y
onready var key_u = $Rows/First/U
onready var key_i = $Rows/First/I
onready var key_o = $Rows/First/O
onready var key_p = $Rows/First/P

onready var key_a = $Rows/Second/A
onready var key_s = $Rows/Second/S
onready var key_d = $Rows/Second/D
onready var key_f = $Rows/Second/F
onready var key_g = $Rows/Second/G
onready var key_h = $Rows/Second/H
onready var key_j = $Rows/Second/J
onready var key_k = $Rows/Second/K
onready var key_l = $Rows/Second/L
onready var key_del = $Rows/Second/DEL

onready var key_z = $Rows/Third/Z
onready var key_x = $Rows/Third/X
onready var key_c = $Rows/Third/C
onready var key_v = $Rows/Third/V
onready var key_b = $Rows/Third/B
onready var key_n = $Rows/Third/N
onready var key_m = $Rows/Third/M
onready var key_enter = $Rows/Third/ENTER


onready var dict_buttons = {
	"Q": key_q,
	"W": key_w,
	"E": key_e,
	"R": key_r,
	"T": key_t,
	"Y": key_y,
	"U": key_u,
	"I": key_i,
	"O": key_o,
	"P": key_p,
	"A": key_a,
	"S": key_s,
	"D": key_d,
	"F": key_f,
	"G": key_g,
	"H": key_h,
	"J": key_j,
	"K": key_k,
	"L": key_l,
	"DEL": key_del,
	"Z": key_z,
	"X": key_x,
	"C": key_c,
	"V": key_v,
	"B": key_b,
	"N": key_n,
	"M": key_m,
	"ENTER": key_enter,
}

# Called when the node enters the scene tree for the first time.
func _ready():
	set_all_buttons_default()

func set_all_buttons_default():
	for label in dict_buttons:
		var button = dict_buttons[label]
		set_button_default(button, label)
		button.connect("clicked", self, "_handle_button_click")
		
func set_button_default(button,label):
	button.set_initial(label)

func change_key(label, status):
	var key_label = label.to_upper()
	var button = dict_buttons[key_label]
	
	if status == "green":
		button.set_status_green()
	elif status == "gray":
		button.set_status_gray()
	elif status == "yellow":
		button.set_status_yellow()
	else:
		button.set_status_default()
	
func _handle_button_click(label):
	print("here" + label)
