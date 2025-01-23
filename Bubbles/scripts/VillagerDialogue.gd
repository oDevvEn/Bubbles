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
		d.connect("click", First1)
		add_child(d)

#Function names first state how many choices deep in the conversation you are
#And then the number states which set of choices it was sent from
func First1(choice):
	match choice:
		0:
			var d : CanvasLayer = dialogue.instantiate()
			d.setupDialogue(FISH, "You seem confused, how's your memory holding up?")
			d.setupButtons(["I can't think of anything", "Where am I?"])
			d.connect("click", Intermediary)
			add_child(d)
		1:
			var d : CanvasLayer = dialogue.instantiate()
			d.setupDialogue(FISH, "Why, you're on Dock Island, of course!")
			d.setupButtons(["What's that?"])
			d.connect("click", Second2)
			add_child(d)

func Intermediary(choice):
	match choice:
		0:
			Second1()
		1:
			First1(1)

func Second1():
		var d : CanvasLayer = dialogue.instantiate()
		d.setupDialogue(FISH, "Oh, you're fully gone. Wow! I haven't met a newbie before!")
		d.setupButtons(["What's that supposed to mean?", "What's going on?"])
		d.connect("click", Third1)
		add_child(d)
		
		
		
func Second2(choice):
		var d : CanvasLayer = dialogue.instantiate()
		d.setupDialogue(FISH, "The main fishing island of this place. You've got the dock off to the west and the shop down to the east")
		d.setupButtons(["You're a shark, why would you be fishing?"])
		d.connect("click", Third2)
		add_child(d)
		
func Third1(choice):
	match choice:
		0:
			var d : CanvasLayer = dialogue.instantiate()
			d.setupDialogue(FISH, "Oh, I meant no harm by it. Please don't take offense, I've just never met someone new here before!")
			d.setupButtons(["What's going on?"])
			d.connect("click", Fourth1)
			add_child(d)
		1:
			Fourth1(0)

func Fourth1(choice):
		var d : CanvasLayer = dialogue.instantiate()
		d.setupDialogue(FISH, "Right. We've all shown up here without any memory of what's going on. Supposedly, the only way to regain any memory is to get 'The Orb' and look through into it")
		d.setupButtons(["And where is this orb?"])
		d.connect("click", Fifth1)
		add_child(d)

func Fifth1(choice):
		var d : CanvasLayer = dialogue.instantiate()
		d.setupDialogue(FISH, "For just a few thousand coins in the shop!")
		d.setupButtons(["Behind a pay wall, makes sense..."])
		d.connect("click", Sixth1)
		add_child(d)
		
func Sixth1(choice):
		var d : CanvasLayer = dialogue.instantiate()
		d.setupDialogue(FISH, "Oh, don't worry. Look, here's a few coins. Go grab yourself a fishing rod and you can gather up some fish, and sell them at the shop to earn your thousands!")
		d.setupButtons(["Alright then"])
		d.connect("click", End)
		add_child(d)
		
func End():
	pass
		
func Third2(choice):
			var d : CanvasLayer = dialogue.instantiate()
			d.setupDialogue(FISH, "You seem confused, how's your memory holding up?")
			d.setupButtons(["I can't think of anything"])
			d.connect("click", Second1)
			add_child(d)
		
