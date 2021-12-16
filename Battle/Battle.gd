extends Node2D


func _ready() -> void:
	randomize()
	global.maxHP = 16 + (global.lv * 4)
	global.kr = 0
	
	global.at = 8 + (global.lv * 2)
	global.df = 9 + ceil(global.lv / 4)
	
	if global.lv == 20:
		global.at = 30
		global.def = 30
		global.maxHP = 99
	
	global.hp = global.maxHP
	
	global.item = [
		# Page 1
		["Pie", "Butterscotch Pie", "", 99],
		["Steak", "Face Steak", "", 60],
		["L. Hero", "Legendary Hero", "ATTACK Increased by 4!", 40],
		["L. Hero", "Legendary Hero", "ATTACK Increased by 4!", 40],
		# Page 2
		["L. Hero", "Legendary Hero", "ATTACK Increased by 4!", 40],
		["SnowPiece", "Snowman Piece", "", 45],
		["SnowPiece", "Snowman Piece", "", 45],
		["SnowPiece", "Snowman Piece", "", 45],
		# Page 3
		["Ketchup", "Ashe Ketchup", "", 100],
		["Ketchup", "Ashe Ketchup", "", 100],
		["Ketchup", "Ashe Ketchup", "", 100],
		["Ketchup", "Ashe Ketchup", "", 100],
	]
	
	for n in $BorderLayer/Border/Collisions.get_children(): if n is CollisionShape2D: n.disabled = true
	
	$HeartLayer/PlayerHeart.connect("camShake", $Camera, "shake")
	$Hud.connect("runAttack", $Attacks, "runAttack")
	$Attacks.connect("menuEnable", $Hud, "menuBattle")
	
	$Hud/Name.text = global.playerName + "   LV " + str(global.lv)
	
	yield(get_tree(), "idle_frame")

	$Hud.menuBattle()
	#$Attacks.endAttack()

# warning-ignore:unused_parameter
func _process(delta: float) -> void:
	$BorderBackground/ColorRect.rect_pivot_offset = $BorderBackground/ColorRect.rect_size / 2.0 # Center the rect.
	$BorderBackground/ColorRect.rect_position = $BorderLayer/Border.rect_position # Position
	$BorderBackground/ColorRect.rect_size = $BorderLayer/Border.rect_size # Size
	$BorderBackground/ColorRect.rect_rotation = $BorderLayer/Border.rect_rotation # Rotate with the Border.
	
	$Background/ColorRect.rect_scale = $Camera.zoom * 6
	
	if !$Attacks/BackBufferCopy/Mask.visible: $Attacks/BackBufferCopy/Mask.visible = true
