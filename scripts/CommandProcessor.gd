extends Node

var _current_area: WorldArea = null


func initialize(starting_area: WorldArea) -> String:
	return change_area(starting_area)


func parse_direction(direction: String) -> String:
	match direction:
		"norte":
			return "north"
		"sur":
			return "south"
		"este":
			return "east"
		"oeste":
			return "west"
		_:
			return ""


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

	var parsed_direction = parse_direction(direction)
	if _current_area.area_exits.has(parsed_direction):
		var exit = _current_area.area_exits[parsed_direction]
		var exit_area_data = exit.get_direction_exit_data(_current_area)
		if exit_area_data[0]:
			if not exit_area_data[1]:
				return "Has ido hacia el %s" % direction + "\n" + change_area(exit_area_data[0])

			return "La salida hacia el %s está bloqueada" % direction

		return "No puedes avanzar porque dios se equivocó"

	return "No hay salida hacia el %s" % direction


func help() -> String:
	return "Puedes usar estas órdenes: ir [dirección]"


func change_area(new_area: WorldArea) -> String:
	_current_area = new_area

	var response = _current_area.get_area_full_description()
	return response
