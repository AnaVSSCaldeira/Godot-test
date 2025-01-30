extends Area2D

var didi
func _ready():
	didi = get_parent().get_node("Didi")

func _on_body_entered(body):
	if body == didi:
		Global.change_scenes()