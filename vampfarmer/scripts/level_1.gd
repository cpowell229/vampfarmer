extends Node2D

var coins_left = 3

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Global.cur_uses = 0

	print(Global.cur_uses)
	print(Global.disabled)
	Global.check()
	print(Global.disabled)
	
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
