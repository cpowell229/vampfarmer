extends Node2D

@onready var game_won_label = $Label
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var player = get_node_or_null("Player")
	
	###### LEVEL 1 - KEY, BEAT LEVEL, REMOVE DOOR IF BOTH
	
	if player and Global.key1:
		# spawn in marker
		var key1_marker_scene = preload("res://scenes/level1_keymarker.tscn")
		var key1_marker = key1_marker_scene.instantiate()
		var key1_spawn = get_node("./Spawnpoints/Level1KeyMarkerSP")
		key1_marker.global_position = key1_spawn.global_position
		add_child(key1_marker)
		#var EnemyScene = preload("res://enemy.tscn")		# No idea what this does, commenting out to avoid b
		#var enemy = EnemyScene.instantiate()
		#var sp = get_node("Spawnpoints/EnemySP")    # create this Node2D in your scene
		#enemy.global_position = sp.global_position
		#add_child(enemy)


	if player and Global.beat_level1:
		# spawn in marker
		var l1_marker_scene = preload("res://scenes/level1_donemarker.tscn")
		var l1_marker = l1_marker_scene.instantiate()

		var l1_spawn = get_node("./Spawnpoints/Level1MarkerSpawnpoint")
		l1_marker.global_position = l1_spawn.global_position

		add_child(l1_marker)
		
		# spawn in level 2 door:
		var l2_door_scene = preload("res://scenes/door_l2.tscn")
		var l2_door_marker = l2_door_scene.instantiate()
		var l2_doorspawn = get_node("./Spawnpoints/Level2DoorSP")
		l2_door_marker.global_position = l2_doorspawn.global_position

		l2_door_marker.name = "door_l2"
		add_child(l2_door_marker)

		
		
	if player and Global.beat_level1 and Global.key1: # can no longer play, beat 100%
		var l1_door = get_node("Door1")
		remove_child(l1_door)
		
		
	# level 2 Checks
	
	### level 2 - just beat	level so add marker
	if player and Global.beat_level2:
		var l1_marker_scene = preload("res://scenes/level1_donemarker.tscn")
		var l2_marker = l1_marker_scene.instantiate()
		
		var l2_spawn = get_node("./Spawnpoints/Level2MarkerSpawnpoint")
		l2_marker.global_position = l2_spawn.global_position
		add_child(l2_marker)
		
		# ADD CODE TO SPAWN IN DOOR TO LEVEL3
		var l3_door_scene = preload("res://scenes/door_l3.tscn")
		var l3_door_marker = l3_door_scene.instantiate()
		var l3_doorspawn = get_node("./Spawnpoints/Level3DoorSP")
		l3_door_marker.global_position = l3_doorspawn.global_position

		l3_door_marker.name = "door_l3"
		add_child(l3_door_marker)
		
				 
	### level2 - just beat level with key, add marker
	if player and Global.key2:
		var key2_marker_scene = preload("res://scenes/level1_keymarker.tscn")
		var key2_marker = key2_marker_scene.instantiate()
		var key2_spawn = get_node("./Spawnpoints/Level2KeyMarkerSP")
		key2_marker.global_position = key2_spawn.global_position
		add_child(key2_marker)
		
	if player and Global.key2 and Global.beat_level2:		# shouldn't be allowed to go back into level, 
		var l2_door = get_node("door_l2")
		remove_child(l2_door)
	
	
		
		
		
	### check for level3 beaten (update marker above door)
	if player and Global.beat_level3:
		var l1_marker_scene = preload("res://scenes/level1_donemarker.tscn")
		var l3_marker = l1_marker_scene.instantiate()
		
		var l3_spawn = get_node("./Spawnpoints/Level3MarkerSpawnpoint")
		l3_marker.global_position = l3_spawn.global_position
		add_child(l3_marker)
		
	if player and Global.key3:
		var key3_marker_scene = preload("res://scenes/level1_keymarker.tscn")
		var key3_marker = key3_marker_scene.instantiate()
		var key3_spawn = get_node("./Spawnpoints/Level3KeyMarkerSP")
		key3_marker.global_position = key3_spawn.global_position
		add_child(key3_marker)
	
	if player and Global.beat_level3 and Global.key3:
		var l3_door = get_node("door_l3")
		remove_child(l3_door)
		
	
	if player and Global.key1 and Global.key2 and Global.key3:
		game_won_label.visible = true
		


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
