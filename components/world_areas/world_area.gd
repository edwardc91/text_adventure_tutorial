@tool
class_name WorldArea
extends PanelContainer

@export var area_name: String = "Area Name":
	set = set_area_name
@export_multiline var description: String = "Area Description":
	set = set_area_description

var area_exits: Dictionary = {}
var area_items: Array[Item] = []

@onready var _name_label: Label = %NameLabel
@onready var _description_label: Label = %DescriptionLabel


func _ready() -> void:
	_name_label.text = area_name
	_description_label.text = description


func connect_exit(direction: String, area: WorldArea) -> void:
	var exit = Exit.new()
	exit.area1 = area
	exit.area2 = self
	area_exits[direction] = exit
	match direction:
		"east":
			area.area_exits["west"] = exit
		"west":
			area.area_exits["east"] = exit
		"north":
			area.area_exits["south"] = exit
		"south":
			area.area_exits["north"] = exit


func add_area_item(item: Item) -> void:
	area_items.append(item)


func get_area_items() -> String:
	var items_names = area_items.map(func(item: Item): return item.name)

	var objects_names = PackedStringArray(items_names)
	var objects_string = (
		objects_names
		if len(objects_names) > 0
		else PackedStringArray(["No hay objetos en el área"])
	)

	return " ".join(objects_string)


func get_area_exits() -> String:
	var exits = PackedStringArray(area_exits.keys())
	var exits_string = exits if len(exits) > 0 else PackedStringArray(["No hay salida ups"])
	return " ".join(exits_string)


func get_area_full_description() -> String:
	var strings: PackedStringArray = PackedStringArray(
		[
			"Has entrado en %s" % area_name,
			description,
			"Salidas: %s" % get_area_exits(),
			"Objetos: %s" % get_area_items()
		]
	)

	return "\n".join(strings)


func set_area_name(value: String) -> void:
	if _name_label:
		_name_label.set_text(value)
	area_name = value


func set_area_description(value: String) -> void:
	if _description_label:
		_description_label.text = value
	description = value
