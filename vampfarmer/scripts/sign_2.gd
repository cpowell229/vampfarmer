extends Area2D

@onready var text_box = $Label
var entered = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	text_box.visible = false
	pass # Replace with function body.



func _on_body_entered(body: Node2D) -> void:
	if body.name == "Player":
		entered = true
		text_box.visible = true


func _on_body_exited(body: Node2D) -> void:
	if body.name == "Player":
		entered = false
		text_box.visible = false
	
