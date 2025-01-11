extends Area2D

@export var direction:Vector2 = Vector2(1, 0)
@export var speed:float = 10.0

func _physics_process(delta: float) -> void:
	global_position += direction * speed

func setValues(shooter:CharacterBody2D):
	direction = shooter.aim
	global_position = shooter.global_position

func _on_body_entered(body: Node2D) -> void:
	return
	queue_free()
