extends TextureRect
@onready var timer: Timer = $Timer

func _ready() -> void:
	InGameTimer.paused = true

func _input(event: InputEvent) -> void:
	if timer.is_stopped():
		get_tree().change_scene_to_file("res://scenes/splash_screen/splash_screen.tscn")
