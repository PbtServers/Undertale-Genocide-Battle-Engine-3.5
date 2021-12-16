extends Node2D


func _process(_delta: float) -> void:
	$Background.rect_size.x = floor(global.maxHP * 1.2) + 1
	$Health.rect_size.x = floor($Background.rect_size.x * global.hp / global.maxHP)
	
	# To Clickteam users: your KR bar is not accurate, fuck off.
	$Karma.rect_size.x = ceil($Background.rect_size.x * global.kr / global.maxHP)
	$Karma.rect_position.x = $Background.rect_position.x + $Background.rect_size.x * (global.hp - global.kr) / global.maxHP
	
	if $Karma.margin_left < $Background.margin_left: $Karma.margin_left = $Background.margin_left
	
	$KRIcon.visible = !(global.kr <= -1)
	$KRIcon.position.x = $Background.margin_right + 5
	
	$Text.rect_position.x = $Background.margin_right + 15 if global.kr <= -1 else $Background.margin_right + 50

	$Text.bbcode_text = str(global.hp).pad_zeros(len(str(global.maxHP))) + " / " + str(global.maxHP)
	$Text.modulate = $Karma.color if global.kr > 0 else Color(1, 1, 1)
