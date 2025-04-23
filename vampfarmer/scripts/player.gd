extends CharacterBody2D


const SPEED = 150.0
const JUMP_VELOCITY = -300.0
var collected_l1_coins = 0
var beat_level1 = false
var attacking = false
var health = 150
var alive = true
var enemy_in_range = false
var enemy_attack_cooldown = true

func player():
	pass

func _physics_process(delta: float) -> void:
	attack()
	move_and_slide()
	enemy_attack()
	update_health()

	
	if health <= 0:
		alive = false
		health = 0
		$AnimatedSprite2D.play("Death")
		print("player died...")
		
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Handle jump.
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	if not attacking:
		var direction := Input.get_axis("ui_left", "ui_right")
		$AnimatedSprite2D.play("Walk")
		if direction:
			velocity.x = direction * SPEED
		else:
			velocity.x = move_toward(velocity.x, 0, SPEED)
		if velocity.x < 0:
			$AnimatedSprite2D.flip_h = true
		elif velocity.x > 0:
			$AnimatedSprite2D.flip_h = false


func attack():
	if Input.is_action_just_pressed("attack") and not attacking:
		attacking = true
		Global.is_attacking = true
		$AnimatedSprite2D.play("Attack")
		$deal_attack.start()
func enemy_attack():
	if enemy_in_range and enemy_attack_cooldown == true:
		health = health - 15
		enemy_attack_cooldown = false
		$Attack_Cooldown.start()
		print("player -15 health")

func _on_attack_cooldown_timeout() -> void:
	enemy_attack_cooldown = true


func _on_deal_attack_timeout() -> void:
	$deal_attack.stop()
	Global.is_attacking = false
	attacking = false


func _on_heal_timeout() -> void:
	if health < 150:
		health = health + 20
		if health > 150:
			health = 150
	if health <= 0:
		health = 0
func update_health():
	var healthBar = $health_bar
	healthBar.value = health 
	if health >= 150:
		healthBar.visible = false
	else:
		healthBar.visible = true

func _on_hitbox_body_entered(body: Node2D) -> void:
	if body.has_method("enemy"):
		enemy_in_range = true
func _on_hitbox_body_exited(body: Node2D) -> void:
	if body.has_method("enemy"):
		enemy_in_range = false
