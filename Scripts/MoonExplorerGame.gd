extends Node

func _process(delta):
	$Camera2D.translate($Rover.position - $Camera2D.position - $Camera2D.get_viewport().get_visible_rect().size / 2)