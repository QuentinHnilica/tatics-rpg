extends Control

func _ready():
	for option in $Margin/Options.get_children():
		option.connect("pressed",Callable(self,"_on_" + option.name + "_pressed"))

func _on_OverworldTest_pressed():
	print("test overworld")
	get_tree().change_scene_to_file("res://scenes/overworld_mode.tscn")


func _on_BattleTest_pressed():
	print("test battle")
	get_tree().change_scene_to_file("res://scenes/battle_mode.tscn")


func _on_VNTest_pressed():
	print("test vn")
	get_tree().change_scene_to_file("res://scenes/vn_mode.tscn")


func _on_MenuTest_pressed():
	print("test menu")
	get_tree().change_scene_to_file("res://scenes/menu_mode.tscn")


func _on_TestLevel_pressed():
	print("test level")
	get_tree().change_scene_to_file("res://assets/prefabs/test_level.tscn")


func _on_DialogueTest_pressed():
	print("test dialogue")
	DialogueManager.show_example_dialogue_balloon(load("res://assets/dialogues/test_dialogue.dialogue"), "start")
