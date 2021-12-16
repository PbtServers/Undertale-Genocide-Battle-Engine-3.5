extends Node

var border
var playerHeart
var bullets

signal endAttack


func _ready() -> void:
	playerHeart.changeMode(2)
	
	yield(get_tree().create_timer(0.2), "timeout")
	for n in 8:
		bullets.createBone(0, Vector2(128 - (n * 120), border.margin_top + 5), 95, 0, 180)
		bullets.createBone(0, Vector2(128 - (n * 120), border.margin_bottom - 20 - 5), 20, 0, 180)
		bullets.createBone(0, Vector2(503 + (n * 120), border.margin_top + 5), 95, 2, 180)
		bullets.createBone(0, Vector2(503 + (n * 120), border.margin_bottom - 20 - 5), 20, 2, 180)
	
	yield(get_tree().create_timer(6.4), "timeout")
	emit_signal("endAttack")
