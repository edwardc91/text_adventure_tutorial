extends VBoxContainer

func update_texts(input: String, response: String) -> void:
	%PlayerInput.set_text(" > " + input)
	%Response.set_text(response)
