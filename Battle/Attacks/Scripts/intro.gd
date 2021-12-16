extends Node

var border
var playerHeart
var bullets

signal endAttack


func _ready() -> void:
	sans().get_node("Head").play("BlueEye")
	sans().bounce = 0
	sans().armIndex = 0
	sans().moveArm = 3
	audio.play("Sounds/Bullets/GasterBlaster", 1.4)
	yield(get_tree().create_timer(0.26666), "timeout")
	playerHeart.slam(1)
	yield(get_tree().create_timer(0.5), "timeout")
	bullets.createBoneStab(0, 1, 55, 6, 30)
	
	yield(get_tree().create_timer(0.2), "timeout")
	sans().get_node("Head").play("NoEyes")
	sans().armIndex = 0
	sans().moveArm = 2
	
	yield(get_tree().create_timer(0.5), "timeout")
	playerHeart.changeMode(1)
	audio.play("Sounds/Bell")
	yield(get_tree().create_timer(0.4), "timeout")
	sans().armIndex = 0
	sans().moveArm = 1
	audio.play("Sounds/Bullets/GasterBlaster", 1.4)
	
	for n in 20:
		var Sine = floor(sin(deg2rad(n / 3.0 * 180.0 / PI)) * 28)
		bullets.createBone(0, Vector2(border.margin_left + (n * -24), border.margin_top + 5), 25 + Sine, 0, 360)
		bullets.createBone(0, Vector2(border.margin_left + (n * -24), border.margin_top + 5 + 25 + Sine + 39), border.margin_bottom - 5 - (border.margin_top + 5 + 25 + Sine + 39), 0, 360)
	
	yield(get_tree().create_timer(1.1), "timeout")
	sans().armIndex = 0
	sans().moveArm = 0
	
	bullets.createGasterBlaster(1, Vector2(2, 2), Vector2(0, 0), Vector2(border.margin_left - 50, border.margin_top + 20), 0, 10, 8)
	bullets.createGasterBlaster(1, Vector2(2, 2), Vector2(640, 480), Vector2(border.margin_right + 50, border.margin_bottom - 20), 180, 10, 8)
	bullets.createGasterBlaster(1, Vector2(2, 2), Vector2(0, 0), Vector2(border.margin_left + 20, border.margin_top - 60), 90, 10, 8)
	bullets.createGasterBlaster(1, Vector2(2, 2), Vector2(640, 480), Vector2(border.margin_right - 20, border.margin_bottom + 60), 270, 10, 8)
	
	yield(get_tree().create_timer(0.9), "timeout")
	
	bullets.createGasterBlaster(1, Vector2(2, 2), Vector2(0, 0), Vector2(border.margin_left - 50, border.margin_top - 50), 45, 10, 8)
	bullets.createGasterBlaster(1, Vector2(2, 2), Vector2(640, 0), Vector2(border.margin_right + 50, border.margin_top - 50), 135, 10, 8)
	bullets.createGasterBlaster(1, Vector2(2, 2), Vector2(0, 480), Vector2(border.margin_left - 50, border.margin_bottom + 50), 315, 10, 8)
	bullets.createGasterBlaster(1, Vector2(2, 2), Vector2(640, 480), Vector2(border.margin_right + 50, border.margin_bottom + 50), 225, 10, 8)
	
	yield(get_tree().create_timer(0.9), "timeout")
	
	bullets.createGasterBlaster(1, Vector2(2, 2), Vector2(0, 0), Vector2(border.margin_left - 50, border.margin_top + 20), 0, 10, 8)
	bullets.createGasterBlaster(1, Vector2(2, 2), Vector2(640, 480), Vector2(border.margin_right + 50, border.margin_bottom - 20), 180, 10, 8)
	bullets.createGasterBlaster(1, Vector2(2, 2), Vector2(0, 0), Vector2(border.margin_left + 20, border.margin_top - 60), 90, 10, 8)
	bullets.createGasterBlaster(1, Vector2(2, 2), Vector2(640, 480), Vector2(border.margin_right - 20, border.margin_bottom + 60), 270, 10, 8)
	
	yield(get_tree().create_timer(0.7), "timeout")
	
	bullets.createGasterBlaster(1, Vector2(3, 3), Vector2(0, 240), Vector2(border.margin_left - 100, border.margin_top + 80), 0, 20, 15)
	bullets.createGasterBlaster(1, Vector2(3, 3), Vector2(640, 240), Vector2(border.margin_right + 100, border.margin_top + 80), 180, 20, 15)
	
	yield(get_tree().create_timer(3), "timeout")
	
	sans().get_node("Head").play("Default")
	sans().bounce = 1
	
	emit_signal("endAttack")

func sans():
	var a: = $"../../Enemy/Sans"
	if is_instance_valid(a): return a
	else: return
