extends Control

export (int) var minutes = 0
export (int) var seconds = 0
var dsec = 0
signal timer_timeout
var timer_is_active = false

onready var minutes_scene = $Container/minutes
onready var seconds_scene = $Container/seconds
onready var dsec_scene = $Container/dsec

onready var timer =  $Timer

func _ready():
	stop_timer()

func stop_timer():
	timer.autostart = false
	timer_is_active = false
	set_physics_process(false)
	timer.stop()
	
func start_timer():
	timer.autostart = true
	timer_is_active = true
	set_physics_process(true)
	timer.start()

func set_time(time):
	timer.wait_time(time)
	
func _physics_process(delta):	
	if(!timer_is_active):
		return
		
	if seconds > 0 and dsec <= 0:
		seconds -= 1
		dsec = 10
	if minutes > 0 and seconds <= 0:
		minutes -= 1
		seconds = 60
	
	if seconds >= 10:
		seconds_scene.text = str(seconds)
	else:
		seconds_scene.text = "0" + str(seconds)
	if dsec >= 10:
		dsec_scene.text = str(dsec)
	else:
		dsec_scene.text = "0" + str(dsec)
	
	if (seconds <= 0 && dsec <= 0):
		stop_timer()
		emit_signal("timer_timeout")
		return
	
func _on_Timer_timeout():
	dsec -= 1
