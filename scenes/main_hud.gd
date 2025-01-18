extends CanvasLayer
const ENEMY_BAR = preload("res://scenes/enemy_bar.tscn")
@onready var player_bar: ProgressBar = $playerBar
@onready var h_box_container: HBoxContainer = $HBoxContainer

@export var player:CharacterBody2D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	player_bar.max_value = player.maxHp
	player_bar.value = player.hp
	Global.connect("playerHit", playerHit)
	Global.connect("enemyHit", enemyHit)

func enemyHit(maxHp, hp):
	var eBar = ENEMY_BAR.instantiate()
	h_box_container.add_child(eBar)
	eBar.max_value = maxHp
	eBar.value = hp
	
func playerHit(damage):
	player_bar.value -= damage
