extends CharacterBody2D


const SPEED = 150.0
const JUMP_VELOCITY = -300.0
var collected_l1_coins = 0
var beat_level1 = false
var attacking = false
var health = 50
var alive = true
var enemy_in_range = false
var enemy_attack_cooldown = true

@onready var level1 = $".."


@onready var label : Label = $"Label"

#@onready var spawn_point = get_node("/root/level1/Spawnpoint")
@onready var spawn_point = $"../Spawnpoint"
@onready var scoreboard = %Scoreboard
var bat_scene = preload("res://scenes/bat.tscn")

func player():
	pass
func _ready() -> void:
	label.visible = false
	#Global.start()

func _physics_process(delta: float) -> void:
	attack()
	move_and_slide()
	enemy_attack()
	update_health()

	
	if health <= 0:
		health = 0
		$AnimatedSprite2D.play("Death")
		alive = false
		respawn()
		
		
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Handle jump.
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY
	if Input.is_action_just_pressed("bat_mode"):
		Global.check()
		if not Global.disabled:
			start_bat_mode()
		else: 
			show_prompt() 

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
func start_bat_mode():            # grab current camera
	var old_transform = global_transform
	queue_free()
	var lvl   = get_parent()
	var bat = Global.BatScene.instantiate()
	bat.global_transform = old_transform
	
	lvl.add_child(bat)
	
	
func show_prompt():
	label.visible = true
	$prompt.start() 
func respawn():
	global_position = spawn_point.global_position
	#collected_l1_coins = 0
	level1.coins_left = 3
	
	alive = true 
	scoreboard.reset()
	health = 50
	
	# Unhide Coins
	for coin in get_tree().get_nodes_in_group("apple_coins"):
			coin.show()
			coin.collected = false
			coin.get_node("CollisionShape2D").disabled = false
	
			
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
		$attack_cooldown.start()
		print("player -15 health")

func _on_attack_cooldown_timeout() -> void:
	enemy_attack_cooldown = true


func _on_deal_attack_timeout() -> void:
	$deal_attack.stop()
	Global.is_attacking = false
	attacking = false


func _on_heal_timeout() -> void:
	if health < 50:
		health = health + 20
		if health > 50:
			health = 50
	if health <= 0:
		health = 0
func update_health():
	var healthBar = $health_bar
	healthBar.value = health 
	if health >= 50:
		healthBar.visible = false
	else:
		healthBar.visible = true

func _on_hitbox_body_entered(body: Node2D) -> void:
	if body.has_method("enemy"):
		enemy_in_range = true
func _on_hitbox_body_exited(body: Node2D) -> void:
	if body.has_method("enemy"):
		enemy_in_range = false


func _on_prompt_timeout() -> void:
	label.visible = false
