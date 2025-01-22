extends CollisionShape2D

@onready var dialogue : PackedScene = preload("res://scenes/dialogue.tscn") #debug
const FISH = preload("res://assets/DialogueBoxFish4.png")
var inCollider = false

func _on_interactive_ui_body_entered(body: Node2D) -> void:
	inCollider = true
func _on_interactive_ui_body_exited(body: Node2D) -> void:
	inCollider = false

func _process(delta: float) -> void:
	if Input.is_action_pressed("interact") && inCollider == true:
		var d : CanvasLayer = dialogue.instantiate()
		d.setupDialogue(FISH, "Villager", "Morning there! Who might you be?")
		d.setupButtons(["I don't know", "Where am I?"])
		d.connect("click", new)
		add_child(d)

func new(value):
	pass
