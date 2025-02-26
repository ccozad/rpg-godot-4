extends CharacterBody2D

@onready var animatedSprite2D = $AnimatedSprite2D

const one_eighths = PI/4.0
const three_eighths = 3*PI/4
const five_eighths = 5*PI/4
const seven_eights = 7*PI/4

var speed = 25
var current_state = "idle"
var current_direction = "down"
var target: Node2D = null
var angle = 0.0


func _physics_process(delta: float) -> void:
	slime_movement(delta)

func slime_movement(delta: float) -> void:
	if current_state == "idle":
		velocity.x = 0
		velocity.y = 0
	elif current_state == "chase": 
		current_direction = calculate_direction()
		print_debug(current_direction)
		if current_direction == "right":
			velocity.x = speed
			velocity.y = 0
		elif current_direction == "left":
			velocity.x = -speed
			velocity.y = 0
		elif current_direction == "down":
			velocity.x = 0
			velocity.y = speed
		elif current_direction == "up":
			velocity.x = 0
			velocity.y = -speed
		
	move_and_slide()
	play_animation()

func _on_chase_area_body_entered(body: Node2D) -> void:
	current_state = "chase"
	target = body

func _on_chase_area_body_exited(body: Node2D) -> void:
	current_state = "idle"
	target = null

func calculate_direction() -> String:
	var direction = "down"
	if target != null:
		angle = get_angle_to(target.global_position)
		if angle >= seven_eights or angle < one_eighths:
			direction = "right"
		elif angle >= one_eighths or angle < three_eighths:
			direction = "up"
		elif angle >= three_eighths or angle < five_eighths:
			direction = "left"
	
	return direction
	

func play_animation() -> void:
	if current_state == "chase":
		animatedSprite2D.flip_h = false
		if current_direction == "up":
			animatedSprite2D.play("back_walk")
		elif current_direction == "down":
			animatedSprite2D.play("front_walk")
		elif current_direction == "left":
			animatedSprite2D.flip_h = true
			animatedSprite2D.play("side_walk")
		elif current_direction == "right":
			animatedSprite2D.play("side_walk")
	elif current_state == "idle":
		animatedSprite2D.flip_h = false
		if current_direction == "up":
			animatedSprite2D.play("back_idle")
		elif current_direction == "down":
			animatedSprite2D.play("front_idle")
		elif current_direction == "left":
			animatedSprite2D.flip_h = true
			animatedSprite2D.play("side_idle")
		elif current_direction == "right":
			animatedSprite2D.play("side_idle")
