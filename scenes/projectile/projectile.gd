extends CharacterBody2D

@export var direction:Vector2 = Vector2(1, 0)
@export var speed:float = 750.0

@export var bounces:int = 3
@export var damage:int = 25

var bouncesCount:int = 0

func _physics_process(delta: float) -> void:
	
	var collision = move_and_collide(velocity * delta)
	if collision:
		if collision.get_collider().has_method("getHit"):
			collision.get_collider().getHit(damage)
			queue_free()
		velocity = velocity.bounce(collision.get_normal())
		if bouncesCount == bounces:
			queue_free()
		else:
			bouncesCount += 1

func setValues(shooter:CharacterBody2D):
	direction = shooter.aim
	global_position = shooter.global_position
	velocity = direction * speed
