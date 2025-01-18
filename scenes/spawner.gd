extends Area2D
@onready var spawnpoints: Node = $spawnpoints
const ENEMY = preload("res://scenes/enemy/enemy.tscn")

@export var space:bool = false

func _on_body_entered(body) -> void:
	if body.is_in_group("player"):
		for c in spawnpoints.get_children():
			var enemy = ENEMY.instantiate()
			add_sibling(enemy)
			enemy.global_position = c.global_position
			enemy.player = body
			if space: enemy.direction = Vector2(0.3, 0)
		queue_free()
