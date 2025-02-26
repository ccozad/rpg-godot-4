extends CharacterBody2D

@onready var animatedSprite2D = $AnimatedSprite2D

var speed = 25
var current_state = "idle"
var current_direction = "left"
var target: Node2D = null

func _physics_process(delta: float) -> void:
	slime_movement(delta)

func slime_movement(delta: float) -> void:
	if current_state == "idle":
		velocity.x = 0
		velocity.y = 0
	elif current_state == "chase": 
		velocity = (target.global_position - global_position).normalized() * speed
		if velocity.x < 0:
			current_direction = "left"
		else:
			current_direction = "right"
		
	move_and_slide()
	play_animation()

func _on_chase_area_body_entered(body: Node2D) -> void:
	current_state = "chase"
	target = body

func _on_chase_area_body_exited(body: Node2D) -> void:
	current_state = "idle"
	target = null

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
