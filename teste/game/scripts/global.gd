extends Node

@export var coins : int = 0
@export var label : Label

var level
var new_scene = false
var didi = preload("res://game/scenes/didi.tscn")

func _process(delta):

	if get_tree().current_scene and new_scene:
		var instance = didi.instantiate()
		get_tree().current_scene.add_child(instance)
		label = instance.get_node("Camera2D").get_node("HUD_Game").get_node("Txt_coins")
		label.text = "Coins: "+str(coins)
		new_scene = false

func add_coins(value : int):
	label = get_tree().current_scene.get_node("Didi").get_node("Camera2D").get_node("HUD_Game").get_node("Txt_coins")
	coins += value
	label.text = "Coins: "+str(coins)

func game_over():
	coins = 0
	get_tree().change_scene_to_file("res://game/scenes/fase_1.tscn")

func change_scenes():
	if(get_tree().current_scene):
		var file = get_tree().current_scene.scene_file_path.get_file()
		var handle_string_1 = file.split(".")
		var handle_string_2 = handle_string_1[0].split("_")
		var level_name = str((int(handle_string_2[1])+1))
		level = "fase_"+level_name

	get_tree().change_scene_to_file("res://game/scenes/"+level+".tscn")
	new_scene = true