extends CharacterBody2D
const PROJECTILE = preload("res://scenes/projectile/projectile.tscn")

const SPEED = 300.0
const JUMP_VELOCITY = -400.0

var aim:Vector2 = Vector2(1, 0)

func _physics_process(delta: float) -> void:
	
	aim = global_position.direction_to(get_global_mouse_position())
	
	var direction := Vector2(Input.get_axis("ui_left", "ui_right"), Input.get_axis("ui_up", "ui_down"))
	if direction:
		velocity = direction * SPEED
	else:
		velocity = Vector2(move_toward(velocity.x, 0, SPEED), move_toward(velocity.y, 0, SPEED))

	if Input.is_action_pressed("fire"):
		var bullet = PROJECTILE.instantiate()
		add_sibling(bullet)
		bullet.setValues(self)

	move_and_slide()
