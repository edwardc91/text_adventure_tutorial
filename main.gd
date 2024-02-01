extends Control

@export var input_response_scene: PackedScene = preload("res://components/ui/input_response.tscn")

@onready var _history_rows: VBoxContainer = %HistoryRows
@onready var _history_scroll: ScrollContainer = %HistoryScrollContainer
@onready var _history_scrollbar: VScrollBar = _history_scroll.get_v_scroll_bar()


func _ready() -> void:
	_history_scrollbar.changed.connect(_on__history_scroll_changed)


func _process(delta: float) -> void:
	pass


func _on__history_scroll_changed() -> void:
	_history_scroll.set_v_scroll(_history_scrollbar.max_value)


func _on_input_text_submitted(new_text: String) -> void:
	if not new_text.is_empty():
		var new_input_response = input_response_scene.instantiate()
		new_input_response.update_texts(
			new_text, "User input at " + Time.get_datetime_string_from_system()
		)
		_history_rows.add_child(new_input_response)