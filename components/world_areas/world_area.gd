class_name WorldArea
extends PanelContainer

@export var area_name: String = "New Area"
@export var description: String = "Area description"


func display_texts() -> void:
	%NameLabel.set_text(area_name)
	%DescriptionLabel.set_text(description)
