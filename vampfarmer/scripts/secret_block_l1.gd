extends Area2D

var entered = false
@onready var secret_label = $Label
@onready var secret_block_activated = $SecretBlock_Activated

func _ready() -> void:
	secret_label.visible = false

func _process(_delta: float) -> void:
	
	if entered and Input.is_action_just_pressed("reveal"):   ## need to update this to be the x keys
		Global.key1 = true
		secret_label.visible = true
		secret_block_activated.visible = true
		

func _on_body_entered(body: Node2D) -> void:
	if body.name == "Player":
		entered = true

func _on_body_exited(body: Node2D) -> void:
	if body.name == "Player":
		entered = false
		secret_label.visible = false 
