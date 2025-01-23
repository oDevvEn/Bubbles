extends Button

@onready var player: CharacterBody2D = %player
var gotRod = false
@onready var fishing_rod: Sprite2D = $"../FishingRod"


func _on_pressed() -> void:
	if player.coins >= 10 && gotRod == false:
		gotRod = true
		player.coins -= 10
		player.inventory["fishingRod"] = true
		fishing_rod.visible = false
