extends Area2D

@onready var timer: Timer = $Timer

func _on_body_entered(body: Node2D) -> void:
	print("You Died!!")
	Engine.time_scale = 0.5
	
	# Try to call the die() function if it exists on the body
	if body.has_method("die"):
		body.die()
	else:
		# Fallback to the original behavior if no die() method exists
		body.get_node("CollisionShape2D").queue_free()
	
	timer.start()

func _on_timer_timeout() -> void:
	Engine.time_scale = 1.0
	get_tree().reload_current_scene()
