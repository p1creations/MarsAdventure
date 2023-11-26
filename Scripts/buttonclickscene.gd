extends Node2D


func _on_next_scene_pressed():
	get_tree().change_scene_to_file("res://Scenes/test_level1.tscn")

func _on_return_scene_pressed():
	get_tree().change_scene_to_file("res://Scenes/test_level.tscn")


func _on_portal_body_entered(body):
	if body.is_in_group("Player"):
		get_tree().change_scene_to_file("res://Scenes/test_level1.tscn")


func _on_portal_two_body_entered(body):
	if body.is_in_group("Player"):
		get_tree().change_scene_to_file("res://Scenes/test_level.tscn")



func _on_all_spikes_body_entered(body):
	if body.is_in_group("Player"):
		get_tree().change_scene_to_file("res://Scenes/test_level.tscn")
