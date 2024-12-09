extends RigidBody2D

@export var speed := 1000
@export var bullet_scene: PackedScene
@export var bullets_parent: Node2D
signal died
@onready var shooting_cooldown_timer: Timer = $ShootingCooldownTimer
@onready var animation_player: AnimationPlayer = $AnimationPlayer
@export var is_dead := false
@export var can_shoot := true
@onready var bullet_spawn_point: Marker2D = %BulletSpawnPoint



# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

func _input(event: InputEvent) -> void:
	if is_dead:
		return
		
	if event.is_action_pressed("shoot") and can_shoot:
		shooting_cooldown_timer.start()
		
		var bullet := bullet_scene.instantiate() as RigidBody2D
		bullet.position = bullet_spawn_point.global_position
		bullet.rotation = rotation
		bullets_parent.add_child(bullet)
		
		can_shoot = false

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
	if is_dead:
		return
		
	var direction := Input.get_vector("move_left", "move_right", "move_up", "move_down")
	#apply_force(direction * speed * delta)
	angular_velocity = deg_to_rad(200*direction.x)
	var target_velocity = Vector2(0, clamp(direction.y, -1, 1) * speed)
	linear_velocity = target_velocity.rotated(rotation)
	pass


func _on_body_entered(body: Node) -> void:
	#died.emit()
	if body.is_in_group("enemies"):
		is_dead = true
		SignalBus.player_died.emit()
		print("Umarłem")
		animation_player.play("dead")
		#queue_free()


func _on_shooting_cooldown_timer_timeout() -> void:
	can_shoot = true
