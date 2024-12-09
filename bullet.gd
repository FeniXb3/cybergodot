extends RigidBody2D

@export var speed = 1000

func _ready() -> void:
	linear_velocity = Vector2(0, -speed).rotated(rotation)

func _on_body_entered(body: Node) -> void:
	if body.is_in_group("enemies"):
		body.queue_free()
		queue_free()
	#elif body.is_in_group("walls"):
	else:
		$SelfdestructTimer.start()


func _on_screen_exited() -> void:
	queue_free()


func _on_selfdestruct_timer_timeout() -> void:
	queue_free()
