extends Node

var border
var playerHeart
var bullets

signal endAttack


func _ready() -> void:
	randomize()
	for n in 16:
		var r = randi() % 4
		yield(get_tree().create_timer(0.26666), "timeout")
		playerHeart.slam(r)
		sans().armIndex = 0
		match r:
			0: sans().moveArm = 1
			1: sans().moveArm = 3
			2: sans().moveArm = 4
			3: sans().moveArm = 2
		yield(get_tree().create_timer(0.2), "timeout")
		bullets.createBoneStab(0, r, 25, 9, 6)
		yield(get_tree().create_timer(0.43333), "timeout")
	sans().armIndex = 0
	sans().moveArm = 0
	emit_signal("endAttack")


func sans():
	var a: = $"../../Enemy/Sans"
	if is_instance_valid(a): return a
	else: return
