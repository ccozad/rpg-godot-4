extends CharacterBody2D

@onready var animatedSprite2D = $AnimatedSprite2D

const speed = 100
var current_direction = "down"
var isMoving = false

func _physics_process(delta: float) -> void:
	player_movement(delta)

func player_movement(delta: float) -> void:
	isMoving = true
	if Input.is_action_pressed("ui_right"):
		current_direction = "right"
		velocity.x = speed
		velocity.y = 0
	elif Input.is_action_pressed("ui_left"):
		current_direction = "left"
		velocity.x = -speed
		velocity.y = 0
	elif Input.is_action_pressed("ui_down"):
		current_direction = "down"
		velocity.x = 0
		velocity.y = speed
	elif Input.is_action_pressed("ui_up"):
		current_direction = "up"
		velocity.x = 0
		velocity.y = -speed
	else:
		isMoving = false
		velocity.x = 0
		velocity.y = 0
	
	play_animation()
	move_and_slide()

func play_animation() -> void:
	if isMoving:
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
	else:
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
			 
