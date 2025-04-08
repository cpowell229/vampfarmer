extends CharacterBody2D


var speed = 300.0
@onready var anim_sprite: AnimatedSprite2D = $AnimatedSprite2D

func _ready() -> void: 
	$AnimatedSprite2D.play("Idle")

func move(direction):
	if direction == null:
		velocity = Vector2.ZERO
		return
	var new_vel = Vector2.ZERO
	match direction:
		Global.InputDirection.LEFT:
			new_vel.x = -1
		Global.InputDirection.RIGHT:
			new_vel.x = 1
		Global.InputDirection.UP:
			new_vel.y = -1
		Global.InputDirection.DOWN:
			new_vel.y = 1
	velocity = new_vel * speed

func _physics_process(delta):
	move_and_slide()
	if velocity.x < 0:
		$AnimatedSprite2D.flip_h = true
	elif velocity.x > 0:
		$AnimatedSprite2D.flip_h = false
		if velocity.length() > 0:
			anim_sprite.play("Run")  # Moving animation
		else:
			anim_sprite.play("Idle")  # Idle animation
