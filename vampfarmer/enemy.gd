extends CharacterBody2D

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
 
var patrol_y : float
func enemy():
	pass

func _ready() -> void: 
	patrol_y = position.y
	positions = get_tree().get_nodes_in_group(group_name)
	print("Found %d markers in group '%s'" % [positions.size(), group_name])
	_get_positions()
	_get_next_position()
func _physics_process(delta: float) -> void:
	if dead:
		return
	position.y = patrol_y
	update_health()
	deal_with_attacks()
	attack()
	
	
	if current_position == null:
		velocity.x = 0
	else:
		var dx = current_position.position.x - position.x
		var step = speed * delta

		# 2) if we’re close enough, snap and pick the next point
		if abs(dx) <= step:
			position.x = current_position.position.x
			_get_next_position()
			velocity.x = 0
		else:
			velocity.x = speed * sign(dx)
			
		velocity.y = 0
		move_and_slide()
		if velocity.x < 0:
			$AnimatedSprite2D.play("move_left")
		elif velocity.x > 0:
			$AnimatedSprite2D.play("move_right")

	
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
