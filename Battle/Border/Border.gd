extends NinePatchRect

var ideal: Array = [32, 607, 250, 390]
var speed: = 480

var resizeDone: = false

signal resizeFinished

func _physics_process(delta: float) -> void:
	# Border speed setter.
	var X1 = min(speed * delta, abs(margin_left - ideal[0]))
	var Y1 = min(speed * delta, abs(margin_top - ideal[2]))
	var X2 = min(speed * delta, abs(margin_right - ideal[1]))
	var Y2 = min(speed * delta, abs(margin_bottom - ideal[3]))
	
	# Left resizing
	if margin_left > ideal[0]: margin_left -= X1
	elif margin_left < ideal[0]: margin_left += X1
	# Top resizing
	if margin_top > ideal[2]: margin_top -= Y1
	elif margin_top < ideal[2]: margin_top += Y1
	# Right resizing
	if margin_right > ideal[1]: margin_right -= X2
	elif margin_right < ideal[1]: margin_right += X2
	# Bottom resizing
	if margin_bottom > ideal[3]: margin_bottom -= Y2
	elif margin_bottom < ideal[3]: margin_bottom += Y2
	
	if !resizeDone:
		# Emit signal once all = ideal
		if (margin_left == ideal[0] and margin_top == ideal[2] and
			margin_right == ideal[1] and margin_bottom == ideal[3]
			):
				resizeDone = true
				#print("Border resize complete")
				emit_signal("resizeFinished")
	
	rect_pivot_offset = rect_size / 2.0 # Center the pivot for rotation
	
	$Collisions/Left.shape.extents = Vector2(480, 640)
	$Collisions/Top.shape.extents = Vector2(640, 480)
	$Collisions/Right.shape.extents = $Collisions/Left.shape.extents
	$Collisions/Bottom.shape.extents = $Collisions/Top.shape.extents
	
	$Collisions/Left.position = Vector2(-$Collisions/Left.shape.extents.x + 5, $Collisions/Left.shape.extents.y - 480)
	$Collisions/Top.position = Vector2(rect_size.x / 2.0, -$Collisions/Top.shape.extents.y + 5)
	$Collisions/Right.position = Vector2(rect_size.x + $Collisions/Right.shape.extents.x - 5, $Collisions/Right.shape.extents.y - 480)
	$Collisions/Bottom.position = Vector2(rect_size.x / 2.0, rect_size.y + $Collisions/Top.shape.extents.y - 5)
	
	# Places the CornerBottom node to the bottom corner of the Border
	# CornerTop sticks to the top corner always, so that's why I didn't write code for it
	$CornerBottom.position = rect_size - Vector2(2.5, 2.5)


func changeSize(Left: = margin_left, Right: = margin_right, Top: = margin_top, Bottom: = margin_bottom, newSpeed: = speed):
	resizeDone = false
	ideal = [Left, Right, Top, Bottom]
	speed = newSpeed
	return ideal


func changeSizeInstant(Left: = margin_left, Right: = margin_right, Top: = margin_top, Bottom: = margin_bottom):
	resizeDone = false
	ideal = [Left, Right, Top, Bottom]
	margin_left = Left
	margin_right = Right
	margin_top = Top
	margin_bottom = Bottom
	
	return ideal
