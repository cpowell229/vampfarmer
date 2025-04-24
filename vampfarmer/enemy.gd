extends CharacterBody2D
var gravity = 500 
var speed = 15
var health = 100
var in_range = false
var can_attack = true
var attack_range = false
var dead = false
var can_take_damage = true
@export var group_name : String = "strafe"
var positions : Array 
var temp_positions : Array
var current_position : Marker2D
var direction : Vector2 = Vector2.ZERO
 
func enemy():
	pass

func _ready() -> void: 
	positions = get_tree().get_nodes_in_group(group_name)
	print("Found %d markers in group '%s'" % [positions.size(), group_name])
	_get_positions()
	_get_next_position()
func _physics_process(delta: float) -> void:
		attack()
		deal_with_attacks()
		attack()
		update_health()
		if dead:
			return
		var movement_direction = Vector2.ZERO
		# WANDERING MODE: Move towards current marker
		if current_position:
			var diff = current_position.position - position
			movement_direction = diff.normalized()
			position += movement_direction * speed * delta
			move_and_collide(movement_direction * speed * delta)
			
			# When near the target marker, get the next one
			if position.distance_to(current_position.position) < 15:
				_get_next_position()
			
			# Set animation similar to chase mode, based on direction
			if abs(diff.x) > abs(diff.y):
				if diff.x < 0:
					$AnimatedSprite2D.play("move_left")
				else:
					$AnimatedSprite2D.play("move_right")
		else:
			# Fallback if for some reason no marker is available
			$AnimatedSprite2D.play("move_left")


	
func _get_positions():
	temp_positions = positions.duplicate()
	temp_positions.shuffle()
 
func _get_next_position():
	if temp_positions.is_empty():
		_get_positions()
	if not temp_positions.is_empty():
		current_position = temp_positions.pop_front()
		direction = (current_position.position - position).normalized()

func deal_with_attacks():
	if can_take_damage and in_range and Global.is_attacking and not dead:
		health = health - 34
		print("Enemy took 34 damage, now at", health)
		can_take_damage = false
		$take_damage_cooldown.start()
		if health <= 0:
			health = 0
			dead = true
			self.queue_free()

func attack():
	if in_range and can_attack and not dead:
		can_attack = false  
		$attack_cooldown.start()
			
func _on_range_body_entered(body: Node2D) -> void:
	if body.has_method("player"):
		in_range = true


func _on_range_body_exited(body: Node2D) -> void:
	if body.has_method("player"):
		in_range = false


func _on_hitbox_body_entered(body: Node2D) -> void:
	if body.has_method("player") and can_attack and in_range:
		attack_range = true
		
		


func _on_hitbox_body_exited(body: Node2D) -> void:
	if body.has_method("player") and can_attack and in_range:
		attack_range = false


func _on_take_damage_cooldown_timeout() -> void:
	can_take_damage = true


func _on_attack_cooldown_timeout() -> void:
	can_attack = true


func _on_heal_timeout() -> void:
	if health < 100:
		health = health + 20
		if health > 100:
			health = 100
	if health <= 0:
		health = 0
func update_health():
	var healthBar = $health_bar
	healthBar.value = health 
	if health >= 100:
		healthBar.visible = false
	else:
		healthBar.visible = true
