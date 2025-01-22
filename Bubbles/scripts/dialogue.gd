extends Control

signal click(value)
const button : PackedScene = preload("res://assets/dialogue_button.tscn")

func setupDialogue(speakerPicture, speakerName:String, dialog:String) -> void:
	var picture : TextureRect = $Background/Picture
	var speaker : RichTextLabel = $Background/Name
	var dialogue : RichTextLabel = $Background/Dialogue

	picture.texture = speakerPicture
	speaker.text = "[b]%s[/b]" % speakerName
	dialogue.text = dialog

func setupButtons(choices:Array) -> void:
	var count = 0
	for choice in choices:
		var btn : Button = button.instantiate()
		btn.text = choice
		btn.position = Vector2(1920 - 400 - count*340, 235)
		btn.add_theme_font_size_override("font_size", 36)
		btn.connect("pressed", func(): click.emit(count))
		add_child(btn)
		count += 1
