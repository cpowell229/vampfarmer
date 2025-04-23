extends Node2D

var cur_score = 0
@onready var text_board = $board

func _ready() -> void:
	text_board.text = "Coins Collected: 0"

func add_score():
	cur_score += 1
	text_board.text = "Coins Collected: " + str(cur_score)

func reset():
	cur_score = 0
	text_board.text = "Coins Collected: " + str(cur_score)

func hide_board():
	visible = false
