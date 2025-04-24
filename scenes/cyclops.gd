extends Node2D

const SPEED = 40
const TURN_BUFFER = 8  # Pixels to move back when turning

var direction = 1
var just_turned = false

@onready var ray_cast_right: RayCast2D = $RayCastRight
@onready var ray_cast_left: RayCast2D = $RayCastLeft
@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D

func _process(delta: float) -> void:
	# Check for collisions with turn cooldown
	if ray_cast_right.is_colliding() and not just_turned:
		direction = -1
		animated_sprite_2d.flip_h = true
		position.x -= TURN_BUFFER  # Small backward movement
		just_turned = true
		await get_tree().create_timer(0.1).timeout
		just_turned = false
		
	elif ray_cast_left.is_colliding() and not just_turned:
		direction = 1
		animated_sprite_2d.flip_h = false
		position.x += TURN_BUFFER  # Small backward movement
		just_turned = true
		await get_tree().create_timer(0.1).timeout
		just_turned = false
	
	# Normal movement
	position.x += direction * SPEED * delta
