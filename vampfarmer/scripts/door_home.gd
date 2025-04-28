extends Area2D

var entered = false
@onready var level = $".."

func _on_body_entered(body: PhysicsBody2D) -> void:
	entered = true


func _on_body_exited(body: PhysicsBody2D) -> void:
	entered = false

func _ready() -> void:
	print("Door Sound Stream: ", $Door.stream)
	$Door.play()
	
func _process(delta: float) -> void:
	if entered == true:
		
		if Input.is_action_just_pressed("ui_accept"):
			level.coins_left = 3
			get_tree().change_scene_to_file("res://scenes/levelselect.tscn")
			
