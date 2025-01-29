extends Button

@export var scene_path: String = "res://game/scenes/fase_1.tscn"

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	self.pressed.connect(_on_pressed)


func _on_pressed():
	get_tree().change_scene_to_file(scene_path)
