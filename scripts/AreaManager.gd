class_name AreaManager
extends Node


func create_world() -> void:
	var key = Item.new()
	key.initialize("llave", Types.ItemType.EVENT)
	$Lobby.connect_exit("east", $Kitchen)
	$Lobby.add_area_item(key)
