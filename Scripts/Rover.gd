extends RigidBody2D

export var rover_acceleration = 10

const BATTERY_USAGE = 0.0005
const WATER_TO_BATTERY = 0.1
const WATER_TO_HYDROGEN = 0.1
const WATER_TO_OXYGEN = 0.1
const SOLAR_TO_BATTERY = 0.1
export var max_battery = 100
export var max_water = 100
export var max_hydrogen = 100
export var max_oxygen = 100
var battery = 100
var water = 100
var hydrogen = 0
var oxygen = 0
signal update_battery(new_value)
signal update_water(new_value)
signal update_hydrogen(new_value)
signal update_oxygen(new_value)

const TRACK_WIDTH = 24
var left_track_accel = 0
var right_track_accel = 0

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
	
	# Convert water to electricity, hydrogen, and oxygen
	if(battery < max_battery):
		battery += (WATER_TO_BATTERY + SOLAR_TO_BATTERY) * delta
		water -= WATER_TO_BATTERY * delta
		hydrogen += WATER_TO_HYDROGEN * delta
		oxygen += WATER_TO_OXYGEN * delta
	
	# Update GUI progress bars
	emit_signal("update_battery", battery)
	emit_signal("update_water", water)
	emit_signal("update_hydrogen", hydrogen)
	emit_signal("update_oxygen", oxygen)
	
func _physics_process(delta):
	if(battery >= (left_track_accel + right_track_accel)):
		# Move rover depending on the left and right track behavior	
		apply_impulse(Vector2(0,0), (Vector2(0, -(left_track_accel + right_track_accel)).rotated(rotation)))
		battery -= ((left_track_accel + right_track_accel) * BATTERY_USAGE)
	if(battery >= abs(left_track_accel - right_track_accel)):
		apply_torque_impulse(left_track_accel - right_track_accel)
		battery -= (abs(left_track_accel - right_track_accel) * BATTERY_USAGE)
	