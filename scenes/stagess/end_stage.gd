extends Area2D

@export var nextStage:int = 2

func _on_body_entered(body) -> void:
	if body.is_in_group("player"):
		Global.ammo1 = body.ammo1
		Global.ammo2 = body.ammo2
		match nextStage:
			2:
				get_tree().change_scene_to_file("res://scenes/stagess/transition_1.tscn")
			3:
				get_tree().change_scene_to_file("res://scenes/stagess/stage_3.tscn")
			4:
				get_tree().change_scene_to_file("res://scenes/stagess/end.tscn")
