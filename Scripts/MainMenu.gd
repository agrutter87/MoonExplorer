extends Panel

signal new_button_pressed
signal load_button_pressed
signal quit_button_pressed


func _on_NewButton_pressed():
	emit_signal("new_button_pressed")
	get_tree().change_scene("res://Scenes/MoonExplorerGame.tscn")


func _on_LoadButton_pressed():
	emit_signal("load_button_pressed")


func _on_QuitButton_pressed():
	emit_signal("quit_button_pressed")
