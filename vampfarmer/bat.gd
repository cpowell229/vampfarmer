extends CharacterBody2D


var max_speed = 150
var acceleration = 400
var bat_damp = 6.0           
var bat_turn_boost = 1.7  
var player_scene := preload("res://scenes/player.tscn")
@onready var cam   : Camera2D = $Camera2D
var already_swapped = false
var exit = false

func _ready() -> void:
	$AnimatedSprite2D.play("fly")
	$bat_duration.start()

func move(delta):
	var input_vec := Vector2(
		Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left"),
		Input.get_action_strength("ui_down")  - Input.get_action_strength("ui_up")
	)
	if Input.is_action_just_pressed("bat_mode"):
		end_bat_mode()
	input_vec = input_vec.normalized()
	if not input_vec.is_zero_approx():
		var same_dir = sign(velocity.dot(input_vec))   
		var accel_mag = acceleration * (bat_turn_boost if same_dir < 0 else 1.0)
		velocity += input_vec * accel_mag * get_physics_process_delta_time()
	if velocity.length() > max_speed:
		velocity = velocity.normalized() * max_speed
	if input_vec.is_zero_approx():
		velocity = velocity.move_toward(Vector2.ZERO, bat_damp * get_physics_process_delta_time())
	move_and_slide()
	if velocity.length() > 10:
		rotation_degrees = lerp_angle(rotation_degrees,
		velocity.angle() * 180.0 / PI,         
		0.15) 
	if velocity.x < 0:
			$AnimatedSprite2D.flip_h = false
	elif velocity.x > 0:
			$AnimatedSprite2D.flip_h = true                                

func _physics_process(delta: float) -> void:
	move(delta)
	if exit:
		end_bat_mode()
	
func end_bat_mode():
	print("swap called  frame:", Engine.get_frames_drawn())

	if already_swapped:
		return
	already_swapped = true
	$bat_duration.stop()
	var old_transform = global_transform
	queue_free()
	var player = Global.PlayerScene.instantiate()
	player.global_transform = old_transform
	get_tree().current_scene.add_child(player)
	Global.cur_uses = Global.cur_uses + 1 



func _on_bat_duration_timeout() -> void:
	end_bat_mode()
