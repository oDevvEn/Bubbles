extends Control

@onready var picture : TextureRect = $Background/Picture
@onready var speaker : RichTextLabel = $Background/Name
@onready var dialogue : RichTextLabel = $Background/Dialogue

func setup(p, n:String, d:String) -> void:
	picture.texture = p
	speaker.text = n
	dialogue.text = d

