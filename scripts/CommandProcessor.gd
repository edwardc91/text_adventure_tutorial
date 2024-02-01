extends Node


func process_command(input: String) -> String:
	var words = input.split(" ", false)

	if len(words) == 0:
		return "Necesitas introducir una orden"

	var first_word = words[0].to_lower()

	var second_word = ""
	if len(words) >= 2:
		second_word = words[1].to_lower()

	match first_word:
		"ir":
			return go(second_word)
		"ayuda":
			return help()
		_:
			return "No reconozco esa orden"


func go(direction: String) -> String:
	if direction == "":
		return "¿Hacia donde desea ir?"

	return "Te dirigiste al %s" % direction


func help() -> String:
	return "Puedes usar estas órdenes: ir [dirección]"
