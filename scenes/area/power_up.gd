extends Area2D
@onready var sprite: AnimatedSprite2D = $spriteAnchor/sprite
@onready var sprite_anchor: Node2D = $spriteAnchor

@export var ammoType:Global.eAmmo = Global.eAmmo.FIRE
@export var random:bool = true

func _ready() -> void:
	if random: ammoType = Global.eAmmo.FIRE if randi_range(0, 1) == 0 else Global.eAmmo.LASER
	sprite_anchor.rotation_degrees = randi_range(-360, 360)
	setAnimationSprite()

func _physics_process(delta: float) -> void:
	sprite_anchor.rotation_degrees += 5

func _on_body_entered(body) -> void:
	if body.is_in_group("player"):
		ammoType = body.getAmmo(ammoType)
		if ammoType == Global.eAmmo.NONE:
			queue_free()
		setAnimationSprite()

func setAnimationSprite():
	if ammoType == Global.eAmmo.FIRE:
		sprite.play("fire")
	else:
		sprite.play("laser")
