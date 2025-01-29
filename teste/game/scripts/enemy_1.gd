extends CharacterBody2D

@export var speed: float = 50  # Velocidade do inimigo
@export var patrol_time: float = 2.0  # Tempo antes de mudar de direção
@export var damage: int = 1

var direction: int = 1  # 1 = direita, -1 = esquerda

@onready var patrol_timer: Timer = $Timer  # Referência ao Timer
@onready var hitbox: CollisionShape2D = $Cool2D  # Referência ao Area2D
@onready var enemy_Anim = $Anim

func _ready():
	patrol_timer.wait_time = patrol_time  # Define o tempo da patrulha
	patrol_timer.timeout.connect(_on_patrol_timer_timeout)  # Conecta o Timer ao método
	patrol_timer.start()  # Inicia o Timer

func _physics_process(delta):
	velocity.x = speed * direction  # Move o inimigo na direção atual
	move_and_slide()  # Aplica o movimento

func _on_patrol_timer_timeout():
	direction *= -1  # Inverte a direção
	patrol_timer.start()  # Reinicia o Timer
	if direction == 1:
		enemy_Anim.flip_h = false
	if direction == -1:
		enemy_Anim.flip_h = true

func _on_area_2d_body_entered(body: Node2D) -> void:
	var didi = get_parent().get_node("Didi")
	if body == didi:
		didi.damage_player(damage)