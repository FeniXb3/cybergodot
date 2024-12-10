extends RigidBody2D

@export var speed = 1000

func _ready() -> void:
	linear_velocity = Vector2(0, -speed).rotated(rotation)

func _on_body_entered(body: Node) -> void:
	if body.is_in_group("enemies"):
		$ExplosionAudioStreamPlayer2D.play()
		body.queue_free()
		hide()
		die.call_deferred()
		

		#queue_free()
	#elif body.is_in_group("walls"):
	else:
		$SelfdestructTimer.start()

func die() -> void:
	process_mode = PROCESS_MODE_DISABLED

func _on_screen_exited() -> void:
	queue_free()


func _on_selfdestruct_timer_timeout() -> void:
	queue_free()
