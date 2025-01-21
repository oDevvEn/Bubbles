extends Node2D

@onready var dialogue : PackedScene = preload("res://scenes/dialogue.tscn")
@onready var godot : CompressedTexture2D = load("res://assets/icon.svg")

func _ready() -> void:
	var d : Control = dialogue.instantiate()
	d.setupDialogue(godot, "Godot", "meowwwwwwwwwww")
	d.setupButtons(["meow", "meow 2"])
	d.connect("click", func(value): print(value))
	add_child(d)
