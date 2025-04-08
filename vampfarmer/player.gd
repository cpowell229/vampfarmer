extends CharacterBody2D

var speed = 100.0
@onready var anim_sprite: AnimatedSprite2D = $AnimatedSprite2D

func _ready() -> void: 
	anim_sprite.play("Idle")

func _physics_process(delta):
	var input_vector = Vector2.ZERO
	
	# Using Godot's built-in Input Map (set these actions in Project Settings → Input Map)
	input_vector.x = Input.get_action_strength("move_right") - Input.get_action_strength("move_left")
	input_vector.y = Input.get_action_strength("move_down") - Input.get_action_strength("move_up")
	
	input_vector = input_vector.normalized()

	velocity = input_vector * speed
	move_and_slide()

	# Set sprite flip
	if velocity.x < 0:
		anim_sprite.flip_h = true
	elif velocity.x > 0:
		anim_sprite.flip_h = false

	# Set animation based on movement
	if velocity.length() > 0:
		anim_sprite.play("Walk")
	else:
		anim_sprite.play("Idle")
