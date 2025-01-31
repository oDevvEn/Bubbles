extends Area2D

@onready var fishingRod = get_parent().get_node("player/fishingRod")

func _on_body_entered(_body:Node2D) -> void:
	fishingRod.canCast = true
	print("true")

func _on_body_exited(_body:Node2D) -> void:
	fishingRod.canCast = false