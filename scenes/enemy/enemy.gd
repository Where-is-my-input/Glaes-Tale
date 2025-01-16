extends CharacterBody2D


const SPEED = 300.0
const JUMP_VELOCITY = -400.0

@export var hp:int = 50
@export var direction:Vector2 = Vector2(15, 0)

func _physics_process(delta: float) -> void:
	if direction:
		velocity = direction * SPEED
	else:
		velocity = Vector2(move_toward(velocity.x, 0, SPEED), move_toward(velocity.y, 0, SPEED))

	move_and_slide()

func getHit(damage = 5):
	hp -= damage
	if hp <= 0:
		queue_free()
