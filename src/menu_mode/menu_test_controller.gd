extends Control


func is_mouse_hover_button():
	if $Margin/Options.visible:
		for option in $Margin/Options.get_children():
			if option.get_global_rect().has_point(get_viewport().get_mouse_position()): 
				return true
	return false


func _on_overworld_test_pressed():
	get_tree().change_scene_to_file("res://scenes/overworld_mode.tscn")


func _on_battle_test_pressed():
	get_tree().change_scene_to_file("res://scenes/battle_mode.tscn")


func _on_vn_test_pressed():
	get_tree().change_scene_to_file("res://scenes/vn_mode.tscn")


func _on_menu_test_pressed():
	get_tree().change_scene_to_file("res://scenes/menu_mode.tscn")


func _on_test_level_pressed():
	get_tree().change_scene_to_file("res://assets/prefabs/test_level.tscn")
