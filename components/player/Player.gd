class_name Player
extends Node

var inventory: Array[Item] = []


func take_item(item: Item) -> void:
	inventory.append(item)


func drop_item(item: Item) -> void:
	inventory.erase(item)


func get_inventory_items_name() -> Array:
	return inventory.map(func(item: Item): return item.name)


func get_inventory_items() -> String:
	return (
		"""Inventario:
	%s
	"""
		% "\n".join(PackedStringArray(get_inventory_items_name()))
	).trim_suffix("\n")
