extends Camera2D

var intensity = 0
var shakeTimer = 0


func _process(delta: float) -> void:
	if intensity > 0: shakeTimer += delta
	else: offset = Vector2.ZERO
	if shakeTimer >= 1.0 / 30.0: # To make it work at 30 FPS
		randomize() # I guess randomize() helps??
		shakeTimer -= 1.0 / 30.0
		intensity -= 1
		offset = Vector2(intensity * random.choose([1, -1]), intensity * random.choose([1, -1]))


func shake(amount): intensity = amount
