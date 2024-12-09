extends RigidBody2D
@export var visuals: Sprite2D
@export var speed := 1000

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	SignalBus.player_died.connect(_on_player_died)

func _on_player_died() -> void:
	apply_torque_impulse(10000)
	$Visuals.self_modulate = Color.DARK_GOLDENROD

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
	var direction := Vector2(-1, 0)
	apply_force(direction * speed * delta)
