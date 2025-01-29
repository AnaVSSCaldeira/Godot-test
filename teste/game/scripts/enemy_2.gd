extends Area2D

@onready var _animation_enemy = $Anim

@export var variation = 130

var ready_pos
var move_control = true
var didi

func _ready():
	ready_pos = position.x
	didi = get_parent().get_node("Didi")


func _process(delta):

	if position.x > ready_pos - variation and move_control:
		position.x -= 1.5
	else:
		move_control = false
		_animation_enemy.flip_h = true


	if position.x < ready_pos + variation and not move_control:
		position.x += 1.5
	else:
		move_control = true
		_animation_enemy.flip_h = false

func _on_body_entered(body):
	if body == didi:
		didi.damage_player(1)
