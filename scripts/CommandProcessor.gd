extends Node

var _current_area: WorldArea = null

var _player: Player


func initialize(player: Player, starting_area: WorldArea) -> String:
	_player = player
	return change_area(starting_area)


func parse_direction(direction: String) -> String:
	match direction:
		"norte":
			return "north"
		"north":
			return "norte"
		"sur":
			return "south"
		"south":
			return "sur"
		"este":
			return "east"
		"east":
			return "este"
		"oeste":
			return "west"
		"west":
			return "oeste"
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
		"tomar":
			return take(second_word)
		"soltar":
			return drop(second_word)
		"inventario":
			return inventory()
		"inv":
			return inventory()
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


func take(item_name: String) -> String:
	item_name = item_name.to_lower()
	if item_name == "":
		return "¿Que deseas agarrar?"

	for area_item: Item in _current_area.area_items:
		if area_item.name.to_lower() == item_name:
			_player.take_item(area_item)
			_current_area.remove_area_item(area_item)
			return "Has agarrado el objeto %s" % item_name

	return "No se ha encontrado el objeto %s" % item_name


func drop(item_name: String) -> String:
	item_name = item_name.to_lower()
	if item_name == "":
		return "¿Que deseas soltar?"

	for player_item: Item in _player.inventory:
		if player_item.name.to_lower() == item_name:
			_current_area.add_area_item(player_item)
			_player.drop_item(player_item)
			return "Has soltado el objeto %s" % item_name

	return "No tienes el objeto %s" % item_name


func inventory() -> String:
	if len(_player.inventory) == 0:
		return "No tienes objetos en el inventario"

	return _player.get_inventory_items()


func help() -> String:
	return "Puedes usar estas órdenes: ir [dirección]"


func change_area(new_area: WorldArea) -> String:
	_current_area = new_area

	var response = _current_area.get_area_full_description()
	return response
