extends RigidBody2D
@export var visuals: Sprite2D
@export var speed := 30
@export var can_move := false
@export var can_rotate := true
@export var player_position_resource: PositionResource

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	SignalBus.player_died.connect(_on_player_died)
	$AudioStreamPlayer2D.play()

func _on_player_died() -> void:
	apply_torque_impulse(10000)
	$Visuals.self_modulate = Color.DARK_GOLDENROD

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
	randomize()
	#if can_rotate:
		#linear_velocity = Vector2.ZERO
		#var rotation_multiplier := randf_range(-5, 5)
		#angular_velocity = deg_to_rad(60 * rotation_multiplier)
		#can_rotate = false
		#$MoveCooldownTimer.start()
	
	var angle := position.angle_to_point(player_position_resource.value)
	if is_zero_approx(angle):
		angular_velocity = 0
		$MoveCooldownTimer.start()
	else:
		angular_velocity = angle
	print(angle)
	
	if can_move:
		angular_velocity = 0
		var speed_multiplier := randf_range(-5, 0)
		var target_velocity := Vector2(0, speed_multiplier * speed)
		linear_velocity = target_velocity.rotated(rotation)
	
		can_move = false
		$RotateCooldownTimer.start()


func _on_move_cooldown_timer_timeout() -> void:
	can_move = true


func _on_rotate_cooldown_timer_timeout() -> void:
	can_rotate = true
