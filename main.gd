extends Control

@export var max_input_remembered: int = 30

@export var response_scene: PackedScene = preload("res://components/ui/response.tscn")
@export var input_response_scene: PackedScene = preload("res://components/ui/input_response.tscn")

@onready var _command_processor: Node = %CommandProcessor
@onready var _area_manager: Node = %AreaManager
@onready var _history_rows: VBoxContainer = %HistoryRows
@onready var _history_scroll: ScrollContainer = %HistoryScrollContainer
@onready var _history_scrollbar: VScrollBar = _history_scroll.get_v_scroll_bar()


func add_game_info_object(object: Control) -> void:
	_history_rows.add_child(object)
	delete_history_beyond_limit()


func delete_history_beyond_limit() -> void:
	var history_cld_count = _history_rows.get_child_count()
	if history_cld_count > max_input_remembered:
		for i in range(history_cld_count - max_input_remembered):
			_history_rows.get_child(i).queue_free()


func handle_response_added(response_text: String) -> void:
	var response_scene_inst = response_scene.instantiate()
	response_scene_inst.set_text(response_text)
	add_game_info_object(response_scene_inst)


func _ready() -> void:
	_history_scrollbar.changed.connect(_on_history_scroll_changed)
	_command_processor.response_added.connect(_on_command_process_response_added)
	handle_response_added(
		'Bienvenido a esta simple aventura de texto. Introduzca "ayuda" para ver las posibles órdenes.'
	)
	_command_processor.initialize(_area_manager.get_child(0))


func _on_command_process_response_added(response_text: String) -> void:
	handle_response_added(response_text)


func _on_history_scroll_changed() -> void:
	_history_scroll.set_v_scroll(int(_history_scrollbar.max_value))


func _on_input_text_submitted(new_text: String) -> void:
	if new_text.is_empty():
		return

	var response = _command_processor.process_command(new_text)

	var new_input_response = input_response_scene.instantiate()
	new_input_response.update_texts(new_text, response)

	add_game_info_object(new_input_response)
