extends Node

var border
var playerHeart
var bullets

signal endAttack


func _ready() -> void:
	playerHeart.changeMode(1)
	yield(get_tree().create_timer(0.5), "timeout")
	loop()
	yield(get_tree().create_timer(8), "timeout")
	emit_signal("endAttack")


func loop():
	for n in 14:
		randomize()
		var ang = randi() % 360
		var xy = Vector2(cos(ang), sin(ang))
		var xy1 = Vector2(xy.x * 300.0, xy.y * 400.0)
		var end = Vector2(xy.x * 200.0, xy.y * 200.0)
		end.x += playerHeart.position.x
		end.y += playerHeart.position.y
		xy1.x += playerHeart.position.x
		xy1.y += playerHeart.position.y
		if end.x < 50: end.x = 50
		if end.x > 590: end.x = 590
		if end.y < 40: end.y = 40
		if end.y > 440: end.y = 440
		var angle = rad2deg(playerHeart.position.angle_to_point(end))
		bullets.createGasterBlaster(1, Vector2(2, 2), xy1, end, angle, 14, 1)
		yield(get_tree().create_timer(0.53333), "timeout")
