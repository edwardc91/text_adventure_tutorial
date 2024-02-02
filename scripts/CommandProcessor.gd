extends Node

signal response_added(response_text: String)

var _current_area: WorldArea = null


func initialize(starting_area: WorldArea) -> void:
	change_area(starting_area)


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


func change_area(new_area: WorldArea) -> void:
	_current_area = new_area
	var strings: PackedStringArray = PackedStringArray(
		["You entered %s" % new_area.area_name, new_area.area_name]
	)
	var response = "\n".join(strings)
	response_added.emit(response)
