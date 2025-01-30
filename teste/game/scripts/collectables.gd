extends Area2D
class_name Collectible  # Nome da classe para reutilização fácil

enum CollectibleType { COIN, HEART }  # Define tipos de coletáveis

@export var type: CollectibleType = CollectibleType.COIN  # Escolha no Editor
@export var value: int = 1  # Define o valor do efeito (moedas, cura, etc.)
@export var pickup_sound: AudioStreamPlayer2D  # Som opcional

func _ready():
    body_entered.connect(_on_body_entered)

func _on_body_entered(body):
    if body.is_in_group("player"):  # Verifica se é o jogador
        apply_effect(body)
        if pickup_sound:
            pickup_sound.play()
        queue_free()  # Remove o objeto após ser coletado

func apply_effect(body):
    match type:
        CollectibleType.COIN:
            body.add_coins(value)  # Supondo que o jogador tenha um sistema de moedas
        CollectibleType.HEART:
            body.heal_player(value)  # Supondo que o jogador tenha um sistema de vida
        _:
            push_warning("Tipo de coletável desconhecido!")
