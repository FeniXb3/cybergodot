extends Node2D
#@onready var game_over_screen: Control = %GameOverScreen1
@export var game_over_screen: Control
@export var enemy_scene: PackedScene

func _ready() -> void:
	SignalBus.player_died.connect(_on_player_died)


func _on_player_died() -> void:
	game_over_screen.show()


func _on_enemy_spawn_timer_timeout() -> void:
	var enemy: RigidBody2D = enemy_scene.instantiate()
	enemy.position = Vector2(500, 200)
	add_child(enemy)
