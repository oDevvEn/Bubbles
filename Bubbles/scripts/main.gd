extends Node2D

@onready var player : CharacterBody2D = $player
@onready var dialogue : PackedScene = preload("res://scenes/dialogue.tscn") #debug
@onready var godot : CompressedTexture2D = load("res://assets/icon.svg") #debug
@onready var saving: Label = $SavingLabel
@onready var timer: Timer = $SavingLabel/Timer

var loadData : Dictionary

func saveGame() -> void:
	var file : FileAccess = FileAccess.open("user://gamesave.save", FileAccess.WRITE)
	var data : Dictionary = {
		"positionX": player.position.x,
		"positionY": player.position.y,
		"special": player.crabbed,
		"inventory": PlayerVariabgles.inventory,
		"coins": PlayerVariabgles.coins}
	saving.position = Vector2(player.position.x-270, (player.position.y-900))
	timer.start()
	file.store_line(JSON.stringify(data))

func _on_timer_timeout() -> void:
	saving.position = Vector2(-100000, -100000)

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
		loadData = json.data		


func _ready() -> void:
	# Load player data
	if loadData:
		player.position = Vector2(loadData["positionX"], loadData["positionY"])
		player.crabbed = loadData["special"]
		PlayerVariabgles.inventory = loadData["inventory"]
		PlayerVariabgles.coins = loadData["coins"]
	elif FileAccess.file_exists("user://gamesave.save"):
		DirAccess.remove_absolute("user://gamesave.save")		
	
	
var rodPresent = false
@onready var fishing_rod: Node2D = $"."

func _process(delta: float) -> void:
	if Input.is_action_just_pressed("save"):
		saveGame()
	if PlayerVariabgles.inventory["fishingRod"] == true && rodPresent == false:
		player.add_child(fishing_rod)


func _notification(what):
	if what == NOTIFICATION_WM_CLOSE_REQUEST:
		saveGame()
