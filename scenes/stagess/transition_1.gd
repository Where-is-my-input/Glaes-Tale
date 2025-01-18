extends TextureRect

func _on_timer_timeout() -> void:
	get_tree().change_scene_to_file("res://scenes/stagess/stage_2.tscn")
