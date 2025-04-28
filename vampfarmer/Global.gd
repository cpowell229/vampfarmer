extends Node

# level beat checks
var beat_level1 = false
var beat_level2 = false
var beat_level3 = false
#var beat_level4 = false	# woops, ran out of time!

# secret key checks
var key1 = false
var key2 = false
var key3 = false
var is_attacking = false
var disabled = false
var bat_uses = 3
var cur_uses = 0
var PlayerScene : PackedScene = preload("res://scenes/player.tscn")
var BatScene    : PackedScene = preload("res://scenes/bat.tscn")

## comment out "or not key1" if you want to test bat 
func check():
	if cur_uses >= bat_uses or not key1:
		var disabled = true
