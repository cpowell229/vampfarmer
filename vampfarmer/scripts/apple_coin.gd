extends Area2D

var open_door = false
var collected = false

@onready var scoreboard = %Scoreboard
var coins_left = 3
@onready var level = $".."


func _ready() -> void:
	add_to_group("apple_coins")		# to count + also redraw later
	pass 
	
	
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	
	pass
	# check with this if all 3 are grabbed, then open door on frame where check completes?

func _on_body_entered(body: PhysicsBody2D) -> void:
	# pickup
	if body.name == ("Player") or body.has_method("bat"):
		if collected:
			return

		collected = true
		hide()
		$CollisionShape2D.disabled = true
		#body.collected_l1_coins += 1
		var current_scene = get_tree().current_scene.name
		level.coins_left -= 1
			
		
		# add to score somewhere? (0/3 -> 1/3, etc.)
		scoreboard.add_score()
		
		
		
		# spawning in door when 3 are collected
		if level.coins_left == 0:
			var current_scene_name = get_tree().current_scene.name
			var door_scene = preload("res://scenes/door_home.tscn")
			var door_instance = door_scene.instantiate()
			print(current_scene_name)
			
			if current_scene_name == "level1":
				print("made it here")
				Global.beat_level1 = true
				var spawn_point = get_tree().get_root().get_node("level1/Door_Spawnpoint")
				door_instance.global_position = spawn_point.global_position
				get_tree().get_root().get_node("level1").add_child(door_instance)
		

			if current_scene_name == "Level2":
				print("made it to this point")
				Global.beat_level2 = true
				var spawn_point = get_tree().get_root().get_node("Level2/Door_Spawnpoint")
				door_instance.global_position = spawn_point.global_position
			
				get_tree().get_root().get_node("Level2").add_child(door_instance)
			
			
