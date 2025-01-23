extends Button

var gotRod = false


func _on_pressed() -> void:
	if PlayerVariabgles.coins >= 10 && gotRod == false:
		gotRod = true
		PlayerVariabgles.coins -= 10
		PlayerVariabgles.inventory["fishingRod"] = true
