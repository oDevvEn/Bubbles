extends Node2D

@onready var player : CharacterBody2D = $player
@onready var dialogue : PackedScene = preload("res://scenes/dialogue.tscn") #debug
@onready var godot : CompressedTexture2D = load("res://assets/icon.svg") #debug

func saveGame() -> void:
	var file : FileAccess = FileAccess.open("user://gamesave.save", FileAccess.WRITE)
	var data : Dictionary = {
		"positionX": player.position.x,
		"positionY": player.position.y,
		"inventory": player.inventory
	}
	file.store_line(JSON.stringify(data))

func loadGame() -> void:
	if not FileAccess.file_exists("user://gamesave.save"):
		return

	var file = FileAccess.open("user://gamesave.save", FileAccess.READ)
	var data = file.get_line()
	var json = JSON.new()
	if not json.parse(data) == OK:
		print("bads ave file uh oh")
		DirAccess.remove_absolute("user://gamesave.save")
	else:
		player.position = Vector2(json.data["positionX"], json.data["positionY"])
		player.inventory = json.data["inventory"]

func _ready() -> void:
	loadGame()
	#debug
	var d : CanvasLayer = dialogue.instantiate()
	d.setupDialogue(godot, "Godot", "meowwwwwwwwwww")
	d.setupButtons(["meow", "meow 2"])
	d.connect("click", func(value): print(value))
	add_child(d)

func _process(delta: float) -> void:
	if Input.is_action_just_pressed("jump"):
		saveGame()
