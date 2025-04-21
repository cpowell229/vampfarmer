extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	### check for level1 beaten (update marker above door, update door2 to open)
	var player = get_node_or_null("Player")
	
	
	
	if player and Global.beat_level1:	
		var marker_scene = preload("res://scenes/level1_donemarker.tscn")
		var marker = marker_scene.instantiate()

		var spawn_point = get_node("Level1MarkerSpawnpoint")
		marker.global_position = spawn_point.global_position

		add_child(marker)
		
	# update door
	
	### check for level2 beaten (update marker above door, update door2 to open)
	### check for level3 beaten (update marker above door, update door2 to open)
	### check for level4 beaten (update marker above door, update door2 to open)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
