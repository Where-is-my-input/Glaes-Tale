extends CharacterBody2D
const PROJECTILE = preload("res://scenes/projectile/projectile.tscn")
const FIRE = preload("res://scenes/projectile/fire.tscn")
const LASER_2 = preload("res://scenes/projectile/laser_2.tscn")
const FIRE_2 = preload("res://scenes/projectile/fire_2.tscn")
const FIRE_LASER = preload("res://scenes/projectile/fire_laser.tscn")
@onready var bpm: Timer = $bpm
@onready var sprite: AnimatedSprite2D = $CanvasLayer/sprite
@onready var sprite_2: AnimatedSprite2D = $CanvasLayer/sprite2
@onready var sprite_2d: AnimatedSprite2D = $spr

const SPEED = 300.0
const JUMP_VELOCITY = -400.0

@export var fireRate:float = 0.1

@export var ammo1:Global.eAmmo = 0
@export var ammo2:Global.eAmmo = 0

var maxHp:int = 250
var hp:int = 250

var aim:Vector2 = Vector2(1, 0)
var ammoChange:int = 1

func _physics_process(delta: float) -> void:
	
	aim = global_position.direction_to(get_global_mouse_position())
	sprite_2d.look_at(get_global_mouse_position())
	
	var direction := Vector2(Input.get_axis("ui_left", "ui_right"), Input.get_axis("ui_up", "ui_down"))
	if direction:
		velocity = direction * SPEED
	else:
		velocity = Vector2(move_toward(velocity.x, 0, SPEED), move_toward(velocity.y, 0, SPEED))

	if Input.is_action_pressed("fire") && ammo1 + ammo2 > 0 && bpm.is_stopped():
		fire()

	move_and_slide()

func fire():
	var bullet
	if ammo1 == Global.eAmmo.LASER && ammo2 == 0 || ammo2 == Global.eAmmo.LASER && ammo1 == 0:
		bullet = PROJECTILE.instantiate()
	if ammo1 == Global.eAmmo.FIRE && ammo2 == 0 || ammo2 == Global.eAmmo.FIRE && ammo1 == 0:
		bullet = FIRE.instantiate()
	if ammo1 == Global.eAmmo.FIRE && ammo2 == Global.eAmmo.FIRE:
		bullet = FIRE_2.instantiate()
	if ammo1 == Global.eAmmo.LASER && ammo2 == Global.eAmmo.LASER:
		bullet = LASER_2.instantiate()
	if ammo1 == Global.eAmmo.FIRE && ammo2 == Global.eAmmo.LASER || ammo2 == Global.eAmmo.FIRE && ammo1 == Global.eAmmo.LASER:
		bullet = FIRE_LASER.instantiate()
	add_sibling(bullet)
	bullet.setValues(self)
	bpm.start(fireRate)
		
func getAmmo(ammo:Global.eAmmo = Global.eAmmo.FIRE):
	var removedAmmo = Global.eAmmo.NONE
	if ammo1 == Global.eAmmo.NONE:
		sprite.visible = true
		ammo1 = ammo
	elif ammo2 == Global.eAmmo.NONE:
		sprite_2.visible = true
		ammo2 = ammo
	else:
		if ammoChange == 1:
			removedAmmo = ammo1
			ammo1 = ammo
			ammoChange +=1
		else:
			removedAmmo = ammo2
			ammo2 = ammo
			ammoChange -=1
	setFireRate()
	setAmmoSelectedHUD(ammo1, sprite)
	setAmmoSelectedHUD(ammo2, sprite_2)
	return removedAmmo

func setAmmoSelectedHUD(ammo, spr):
	match ammo:
		Global.eAmmo.FIRE:
			spr.play("fire")
		Global.eAmmo.LASER:
			spr.play("laser")

func setFireRate():
	if ammo1 == Global.eAmmo.LASER && ammo2 == 0 || ammo2 == Global.eAmmo.LASER && ammo1 == 0:
		fireRate = 0.45
	if ammo1 == Global.eAmmo.FIRE && ammo2 == 0 || ammo2 == Global.eAmmo.FIRE && ammo1 == 0:
		fireRate = 0.75
	if ammo1 == Global.eAmmo.FIRE && ammo2 == Global.eAmmo.FIRE:
		fireRate = 0.60
	if ammo1 == Global.eAmmo.LASER && ammo2 == Global.eAmmo.LASER:
		fireRate = 0.20
	if ammo1 == Global.eAmmo.FIRE && ammo2 == Global.eAmmo.LASER || ammo2 == Global.eAmmo.FIRE && ammo1 == Global.eAmmo.LASER:
		fireRate = 0.30
	
func getHit(damage = 1):
	Global.playerHit.emit(damage)
	hp -= damage
	if hp <= 0:
		queue_free()
	
