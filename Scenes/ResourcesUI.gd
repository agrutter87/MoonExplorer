extends CanvasLayer

# Called when the node enters the scene tree for the first time.
func _ready():
	pass

func _on_Rover_update_battery(new_value):
	$PanelContainer/HBoxContainer/ProgressVBoxContainer/BatteryProgressBar.value = new_value


func _on_Rover_update_hydrogen(new_value):
	$PanelContainer/HBoxContainer/ProgressVBoxContainer/HydrogenProgressBar.value = new_value


func _on_Rover_update_oxygen(new_value):
	$PanelContainer/HBoxContainer/ProgressVBoxContainer/OxygenProgressBar.value = new_value


func _on_Rover_update_water(new_value):
	$PanelContainer/HBoxContainer/ProgressVBoxContainer/WaterProgressBar.value = new_value
