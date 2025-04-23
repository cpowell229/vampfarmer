extends CharacterBody2D


const SPEED = 150.0
const JUMP_VELOCITY = -300.0
var collected_l1_coins = 0
var beat_level1 = false
var attacking = false
var health = 150
var enemy_in_range = false
var enemy_attack_cooldown = true

func player():
	pass

func _physics_process(delta: float) -> void:
	attack()
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Handle jump.
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction := Input.get_axis("ui_left", "ui_right")
	if Input.is_action_just_pressed("move_left") or Input.is_action_just_pressed("move_left"):
		$AnimatedSprite2D.play("Walk")
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
	if velocity.x < 0:
		$AnimatedSprite2D.flip_h = true
	elif velocity.x > 0:
		$AnimatedSprite2D.flip_h = false

	move_and_slide()

func attack():
	if Input.is_action_just_pressed("attack") and not attacking:
		attacking = true
		Global.is_attacking = true
		$AnimatedSprite2D.play("Attack")
		$deal_attack.start()

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
			health = 100
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
