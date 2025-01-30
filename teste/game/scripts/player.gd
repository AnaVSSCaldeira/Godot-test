extends CharacterBody2D

@onready var _animation_player = $Anim
var Health_bar

@export var MAX_HP = 5


const SPEED = 300.0
const JUMP_VELOCITY = -500.0
var isJump = false

func _ready():
	Health_bar = $Camera2D.get_node("HUD_Game").get_node("Bar_health")
	Health_bar.max_value = MAX_HP

func _physics_process(delta: float) -> void:
	if is_on_floor():
		isJump = false

	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta
		

	# Handle jump.
	if Input.is_action_just_pressed("tecla_w") and is_on_floor():
		isJump = true
		velocity.y = JUMP_VELOCITY
		_animation_player.play("jump")

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction := Input.get_axis("tecla_a", "tecla_d")
	if direction:
		velocity.x = direction * SPEED
		if is_on_floor() and not isJump:
			_animation_player.play("walk")
	elif is_on_floor:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		if is_on_floor() and not isJump:
			_animation_player.play("idle")
	if direction < 0: 
		_animation_player.flip_h = true
	if direction > 0: 
		_animation_player.flip_h = false
	move_and_slide()

func damage_player(xeila):
	Health_bar.value = Health_bar.value - xeila
	if Health_bar.value == 0:
		Global.game_over()

func heal_player(xeila):
	Health_bar.value = Health_bar.value + xeila
