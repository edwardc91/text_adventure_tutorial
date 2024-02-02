class_name AreaManager
extends Node


func create_world() -> void:
    $Lobby.connect_exit("east", $Kitchen)
