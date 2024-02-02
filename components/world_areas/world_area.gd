@tool
class_name WorldArea
extends PanelContainer

@export var area_name: String = "Area Name":
	set = set_area_name
@export_multiline var description: String = "Area Description":
	set = set_area_description

var area_exits: Dictionary = {}

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


func set_area_name(value: String) -> void:
	if _name_label:
		_name_label.set_text(value)
	area_name = value


func set_area_description(value: String) -> void:
	if _description_label:
		_description_label.text = value
	description = value
