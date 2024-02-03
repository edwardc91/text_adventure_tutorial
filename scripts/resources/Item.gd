class_name Item
extends Resource

@export var name: String = "Item name"
@export var type: Types.ItemType = Types.ItemType.EVENT


func initialize(item_name: String, item_type: Types.ItemType) -> void:
	name = item_name
	type = item_type
