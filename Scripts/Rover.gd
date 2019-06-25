extends RigidBody2D

export var rover_acceleration = 10

const TRACK_WIDTH = 24
var left_track_accel = 0
var right_track_accel = 0

func _ready():
	pass
# Called every frame. 'delta' is the elapsed time since the previous frame.

func _process(delta):
	var new_left_accel = 0
	var new_right_accel = 0
	
	# If any of the keys are pressed, update value
	if Input.is_key_pressed(KEY_LEFT) or Input.is_key_pressed(KEY_A):
		new_left_accel -= rover_acceleration
		new_right_accel += rover_acceleration
	if Input.is_key_pressed(KEY_RIGHT) or Input.is_key_pressed(KEY_D):
		new_left_accel += rover_acceleration
		new_right_accel -= rover_acceleration
	if Input.is_key_pressed(KEY_UP) or Input.is_key_pressed(KEY_W):
		new_left_accel += rover_acceleration
		new_right_accel += rover_acceleration
	if Input.is_key_pressed(KEY_DOWN) or Input.is_key_pressed(KEY_S):
		new_left_accel -= rover_acceleration
		new_right_accel -= rover_acceleration

	left_track_accel = new_left_accel
	right_track_accel = new_right_accel

	# Update left track animation
	if(left_track_accel > 0):
		$LeftTrackAnimatedSprite.play("driving")
	elif(left_track_accel < 0):
		$LeftTrackAnimatedSprite.play("driving", true)
	else:
		$LeftTrackAnimatedSprite.stop()

	# Update right track animation
	if(right_track_accel > 0):
		$RightTrackAnimatedSprite.play("driving")
	elif(right_track_accel < 0):
		$RightTrackAnimatedSprite.play("driving", true)
	else:
		$RightTrackAnimatedSprite.stop()
	
	# Update track animation speed
	$LeftTrackAnimatedSprite.speed_scale = linear_velocity.length() + abs(angular_velocity * (TRACK_WIDTH / 2))
	$RightTrackAnimatedSprite.speed_scale = linear_velocity.length() + abs(angular_velocity * (TRACK_WIDTH / 2))
	
func _physics_process(delta):
	# Move rover depending on the left and right track behavior	
	apply_impulse(Vector2(0,0), (Vector2(0, -(left_track_accel + right_track_accel)).rotated(rotation)))
	apply_torque_impulse(left_track_accel - right_track_accel)
	
func _on_Rover_body_entered(body):
	print("Entered")