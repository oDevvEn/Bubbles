extends Control

signal click(value)

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
		var button : Button = Button.new()
		button.text = choice
		button.size = Vector2(240, 60)
		button.position = Vector2(1920 - 300 - count*300, 240)
		button.add_theme_font_size_override("font_size", 36)
		button.connect("pressed", func(): click.emit(count))
		add_child(button)
		count += 1
