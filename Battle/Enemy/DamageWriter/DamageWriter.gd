extends Node2D

var displayHealth: = 0.0
var trueHealth: = 0.0
var maxHealth: = 0.0

var stretchWidth: = 10.0
var stretchFactor: = 0

var damageTaken: = 0.0
var timer: = 0.0

var negative: = false
var drawBar: = true

var vSpeed: = -4.0
var gravity: = 0.5


func _ready() -> void:
	if damageTaken == 0 or !drawBar:
		$Health/Outline.hide()
		$Health/Background.hide()
		$Health.hide()
	
	if damageTaken == 0:
		$Text.bbcode_text = "[center]MISS"
		$Text.modulate = Color(0.752941, 0.752941, 0.752941)
	else: $Text.bbcode_text = "[center]" + str(damageTaken if damageTaken > 0 else 0)


func _process(delta: float) -> void:
	timer += delta
	if timer >= 2.0 / 30.0:
		timer = 0
		if displayHealth > (trueHealth - damageTaken): displayHealth -= (damageTaken / 15.0)
		
		if $Text.rect_position.y > -38:
			$Text.rect_position.y = -38
			vSpeed = 0
			gravity = 0
	
	if displayHealth < (trueHealth - damageTaken): displayHealth = trueHealth - damageTaken
	if !negative: if displayHealth < 0: displayHealth = 0
	
	stretchFactor = (stretchWidth / maxHealth)
	
	$Health/Outline.margin_right = round(maxHealth * stretchFactor) + 1
	$Health/Background.margin_right = round(maxHealth * stretchFactor)
	$Health.margin_right = round(displayHealth * stretchFactor)
	
	$Text.margin_left = -30
	$Text.margin_right = $Health/Background.margin_right + 30
	
	$Text.rect_position.y = $Text.rect_position.y + vSpeed * (delta * 30)
	vSpeed = vSpeed + gravity * (delta * 30)


func destroy(time):
	yield(get_tree().create_timer(time / 30.0), "timeout")
	queue_free()
