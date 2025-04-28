extends Area2D
@onready var scoreboard = %Scoreboard
@onready var level1 = $".."

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_body_entered(body: Node2D) -> void:
	# on: Touched water
	# TP back to spawn
	if body.name == "Player":
		var spawn = get_node("/root/level1/Spawnpoint")
		body.global_position = spawn.global_position
		#body.collected_l1_coins = 0
		level1.coins_left = 3
		body.health = 50
		scoreboard.reset()
	
	# Unhide Coins
		for coin in get_tree().get_nodes_in_group("apple_coins"):
				coin.show()
				coin.collected = false
				coin.get_node("CollisionShape2D").disabled = false
				
			
	
	
	pass # Replace with function body.
