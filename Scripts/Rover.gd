extends Sprite

export var rover_speed = 10

func _ready():
	$LeftTrackAnimatedSprite.speed_scale = rover_speed
	$RightTrackAnimatedSprite.speed_scale = rover_speed

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var left_track_speed = 0
	var right_track_speed = 0
	$LeftTrackAnimatedSprite.speed_scale = rover_speed
	$RightTrackAnimatedSprite.speed_scale = rover_speed
	
	# If any of the keys are pressed, update value
	if Input.is_key_pressed(KEY_LEFT) or Input.is_key_pressed(KEY_A):
		left_track_speed = left_track_speed - 1
		right_track_speed = right_track_speed + 1
	if Input.is_key_pressed(KEY_RIGHT) or Input.is_key_pressed(KEY_D):
		left_track_speed = left_track_speed + 1
		right_track_speed = right_track_speed - 1
	if Input.is_key_pressed(KEY_UP) or Input.is_key_pressed(KEY_W):
		left_track_speed = left_track_speed + 1
		right_track_speed = right_track_speed + 1
	if Input.is_key_pressed(KEY_DOWN) or Input.is_key_pressed(KEY_S):
		left_track_speed = left_track_speed - 1
		right_track_speed = right_track_speed - 1
	
	# Update left track animation
	if(left_track_speed > 0):
		$LeftTrackAnimatedSprite.play("driving")
	elif(left_track_speed < 0):
		$LeftTrackAnimatedSprite.play("driving", true)
	else:
		$LeftTrackAnimatedSprite.stop()
	
	# Update right track animation
	if(right_track_speed > 0):
		$RightTrackAnimatedSprite.play("driving")
	elif(right_track_speed < 0):
		$RightTrackAnimatedSprite.play("driving", true)
	else:
		$RightTrackAnimatedSprite.stop()
	
	# Move rover depending on the left and right track behavior
	translate(Vector2(0, -((right_track_speed + left_track_speed) * rover_speed * delta)).rotated(rotation))
	rotate((left_track_speed - right_track_speed) * delta)


func _on_RigidBody2D_body_entered(body):
	$LeftTrackAnimatedSprite.stop()
	$RightTrackAnimatedSprite.stop()
	
