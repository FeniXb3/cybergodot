extends RigidBody2D

@export var speed := 1000
@export var bullet_scene: PackedScene
@export var bullets_parent: Node2D
signal died
@onready var shooting_cooldown_timer: Timer = $ShootingCooldownTimer

@export var can_shoot := true
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("shoot") and can_shoot:
		shooting_cooldown_timer.start()
		
		var bullet: RigidBody2D = bullet_scene.instantiate()
		bullet.position = position
		bullets_parent.add_child(bullet)
		
		can_shoot = false

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
	var direction := Input.get_vector("move_left", "move_right", "move_up", "move_down")
	apply_force(direction * speed * delta)
	pass


func _on_body_entered(body: Node) -> void:
	#died.emit()
	if body.is_in_group("enemies"):
		SignalBus.player_died.emit()
		print("Umarłem")
		queue_free()


func _on_shooting_cooldown_timer_timeout() -> void:
	can_shoot = true
