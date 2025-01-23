extends CanvasLayer

# slot: {name, count}
var inventory : Dictionary = {}

# name: {texture, max}
var items : Dictionary = {
	"FishingRod": {"texture":load("res://assets/fishingRod.png"),                                "max":1},
	"Cod": {"texture":load("res://assets/fish/Cod.png"),                                         "max":10},
	"Clownfish": {"texture":load("res://assets/fish/Clownfish.png"),                             "max":10},
	"CopperbandButterflyfish": {"texture":load("res://assets/fish/CopperbandButterflyfish.png"), "max":10},
	"JewelCichild": {"texture":load("res://assets/fish/JewelCichild.png"),                       "max":10},
	"PurpleTang": {"texture":load("res://assets/fish/PurpleTang.png"),                           "max":10},
}

@onready var background : TextureRect = $Background
var slots : Array[TextureRect] = []

func _ready() -> void:
	for count in range(1,17):
		var slot : TextureRect = background.get_node(str(count))
		slot.visible = false
		slots.append(slot)

func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("inventory"):
		background.visible = not background.visible

func updateInventory() -> void:
	for slot in slots:
		if inventory.has(slot.name):
			var item : Dictionary = inventory[slot.name]
			slot.texture = items[item["name"]]["texture"]
			slot.get_node("Count").text = str(item["count"])
			slot.get_node("Count").visible = true
			slot.visible = true
		else:
			slot.visible = false

func addItem(itemName : String, count : int) -> void:
	for key in inventory:
		var slot : Dictionary = inventory[key]
		var change : int = min(count, items[slot["name"]]["max"] - slot["count"])
		if slot["name"] == itemName and change > 0:
			slot["count"] += change
			count -= change

	for i in range(1,17):
		if !inventory.has(str(i)):
			var slot : Dictionary = {}
			var change : int = min(count, items[itemName]["max"])
			slot["name"] = itemName
			slot["count"] = change
			count -= change
			inventory[str(i)] = slot

		if count <= 0:
			break

	updateInventory()

func removeAtSlot(num : int):
	var slot : Dictionary = inventory[str(num)]
	if slot:
		slot.count -= 1
		if slot.count <= 0:
			inventory[str(num)] = null

	updateInventory()
