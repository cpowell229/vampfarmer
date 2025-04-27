extends Area2D

var open_door = false
var collected = false
@onready var scoreboard = %Scoreboard

func _ready() -> void:
	add_to_group("apple_coins")		# to count + also redraw later
	pass 
	
	
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	
	pass
	# check with this if all 3 are grabbed, then open door on frame where check completes?

func _on_body_entered(body: PhysicsBody2D) -> void:
	# pickup
	if body.name == "Player":
		if collected:
			return

		collected = true
		hide()
		$CollisionShape2D.disabled = true
		body.collected_l1_coins += 1
		
		# add to score somewhere? (0/3 -> 1/3, etc.)
		scoreboard.add_score()
		
		
		
		# spawning in door when 3 are collected
		if body.collected_l1_coins == 3:
			# Handling level detection to se
			if Global.beat_level1 == false:	# means player on level1
				Global.beat_level1 = true
				
				
				var door_scene = preload("res://scenes/door_home.tscn") 
				var door_instance = door_scene.instantiate()
				
				var spawn_point = get_tree().get_root().get_node("level1/Door_Spawnpoint")
				door_instance.global_position = spawn_point.global_position
				
				get_tree().get_root().get_node("level1").add_child(door_instance)
				
				
				
			if Global.beat_level2 == false and Global.beat_level1 == true:		# means player on level2 
				Global.beat_level2 = true
				
				# spawn in door for level 2
				
			
				
	
	
	
	
	
	pass # Replace with function body.
