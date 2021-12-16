extends Node2D


onready var speechBubble: Dictionary = {
	"Sans" : [preload("res://Battle/Enemy/Dialogue/SpeechBubbles/SansBubble.tscn"), "Sounds/Voice/Sans"]
}


func createSpeechBubble(Child, SpeechBubble, Position, Text, TextSpeed, SetSpeed, SetPause, Interactable: = true, DestroyTime: = 0.0):
	var i = speechBubble[SpeechBubble][0].instance()
	var t = i.get_node("RPGText")
	
	i.position = Position
	
	t.bbcode_text = Text
	
	t.textSound = speechBubble[SpeechBubble][1]
	t.speed = TextSpeed
	t.setSpeed = SetSpeed
	t.setPause = SetPause
	
	t.interactable = Interactable
	t.destroyTime = DestroyTime
	
	
	Child.add_child(i)
	
	return [i, t]


func runDialogue(Num):
	var text = []
	
	match Num:
		1:
			text = [
				["did you actually try to stab me?", 1.0, {}, {}, true, 0.0],
				["try harder noob.", 1.0, {}, {}, true, 0.0],
			]
	
	if len(text) > 0:
		for n in len(text):
			var bubble: = "Sans"
			var target: = $"../Sans"
			var newPosition: = Vector2(60, 0)
			
			match Num:
				1: match n:
					0:
						$"../Sans/Head".animation = "Tired"
						$"../Sans/Torso".animation = "Shrug"
					1:
						$"../Sans/Head".animation = "NoEyes"
						$"../Sans/Torso".animation = "Default"
			
			var b = createSpeechBubble(target, bubble, newPosition, text[n][0], text[n][1], text[n][2], text[n][3], text[n][4], text[n][5])
			yield(b[1], "con")
	$"../../Attacks".emit_signal("startAttack")
	$"../../BorderLayer/Border".emit_signal("resizeFinished")
	
	$"../Sans/Head".animation = "Default"
	$"../Sans/Torso".animation = "Default"
