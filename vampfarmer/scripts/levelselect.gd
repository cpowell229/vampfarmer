extends Node2D


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
		
		add_child (l2_door_marker)
		
		
	if player and Global.beat_level1 and Global.key1: # can no longer play, beat 100%
		var l1_door = get_node("Door1")
		remove_child(l1_door)
				 
	
	
		
		
		
	### check for level2 beaten (update marker above door, update door2 to open)
	### check for level3 beaten (update marker above door, update door2 to open)
	### check for level4 beaten (update marker above door, update door2 to open)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
