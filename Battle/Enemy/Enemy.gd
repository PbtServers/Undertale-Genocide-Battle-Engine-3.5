extends CanvasLayer

var Name = ["Sans"]
var actOptions = ["Check", "Inspect"]
var actChoiceText: Array = [
	[ # Enemy 1
		# Choice 1
		[
			["* SANS 1 ATK 1 DEF\n* The easiest enemy.\n  Can only deal 1 damage.", 1.0, {}, {}],
		],
		# Choice 2
		[
			["* You inspected Sans...", 1.0, {}, {}],
			["* .....What?", 10.0, {7 : 1.0}, {7 : 1.0}],
		],
	],
	[ # Enemy 2
		
	]
]

var timerBonus: = 0.0

var dodge: = false
var dodgeSpeed: = 0.0
var dodgeTimer: = 0.0
var dodgePosition: = 0.0

onready var enemyStrikePos: Array = [$Sans.position - Vector2(5, 5)]
onready var damageWriter: = preload("res://Battle/Enemy/DamageWriter/DamageWriter.tscn")


func _process(delta: float) -> void:
	$Sans.position.y = $"../BorderLayer/Border".ideal[2] - 130
	
	if dodge:
		$Sans.position.x += dodgeSpeed * (delta * 30)
		
		if $Sans.position.x < dodgePosition - 60 and dodgeTimer < 20:
			if dodgeSpeed < 0: dodgeSpeed = dodgeSpeed + 2 * delta * 30
			else: dodgeSpeed = 0
		
		dodgeTimer += 1 * (delta * 30)	
		
		if dodgeTimer >= 20 + timerBonus:
			if dodgeSpeed < 12: dodgeSpeed = dodgeSpeed + 2 * delta * 30
			if $Sans.position.x >= (dodgePosition - (1.0 / 30.0)):
				dodge = false
				dodgeSpeed = 0
				$Sans.position.x = dodgePosition
				
				for n in get_tree().get_nodes_in_group("DamageWriter"): n.destroy(15)
				for n in get_tree().get_nodes_in_group("Target"): n.state = 2
				
				$Dialogue.runDialogue($"../Attacks".attack)
				$"../Attacks".runAttack()


func playerAttack(Who, TakeDamage, DamageTime):
	$"../Attacks".attack += 1
	
	match Who:
		0:
			timerBonus = DamageTime
			
			dodge = true
			dodgeSpeed = -12
			dodgeTimer = 0
			dodgePosition = $Sans.position.x
			
			yield(get_tree().create_timer(DamageTime / 30.0), "timeout")
			createDamageWriter(Vector2(270, 75), 114, 10, 10, 0)


func createDamageWriter(Position, Width, Health, MaxHealth, DamageTaken, DestroyTime: = -1.0):
	var i = damageWriter.instance()
	i.position = Position
	i.stretchWidth = Width
	
	i.displayHealth = Health
	i.trueHealth = Health
	i.maxHealth = MaxHealth
	
	i.damageTaken = DamageTaken
	
	add_child(i)
	if DestroyTime > -1: i.destroy(DestroyTime)
	
	return i
