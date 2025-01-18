extends CharacterBody2D
@onready var fire_rate: Timer = $fireRate
const PROJECTILE = preload("res://scenes/projectile/enemy_projectile.tscn")
const SPEED = 300.0
const JUMP_VELOCITY = -400.0

@export var maxHp:int = 250
@export var hp:int = 150
@export var direction:Vector2 = Vector2(0, 0)
@export var fireRate:float = 1.256
@export var player:CharacterBody2D = null

var aim:Vector2 = Vector2(1, 1)

func _ready() -> void:
	fire_rate.start(fireRate)

func _physics_process(delta: float) -> void:
	aim = global_position.direction_to(player.global_position) + Vector2(randf_range(-0.15, 0.15), randf_range(-0.15, 0.15)) if player != null else aim
	if direction:
		velocity = direction * SPEED
	else:
		velocity = Vector2(move_toward(velocity.x, 0, SPEED), move_toward(velocity.y, 0, SPEED))

	if move_and_slide():
		direction *= Vector2(-1, -1)

func getHit(damage = 5):
	hp -= damage
	Global.enemyHit.emit(maxHp, hp)
	if hp <= 0:
		queue_free()

func shoot():
	var bullet = PROJECTILE.instantiate()
	add_sibling(bullet)
	bullet.setValues(self)


func _on_fire_rate_timeout() -> void:
	shoot()
	fire_rate.start(fireRate)
