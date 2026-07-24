class_name CharacterCreatorUI
extends Control

@onready var character_preview: Node = $HSplitContainer/RightPanel/CharacterPreview
@onready var race_option_button: OptionButton = $HSplitContainer/LeftPanel/TabContainer/RaceBody/VBoxContainer/RaceOptionButton
@onready var main_body_slider: HSlider = $HSplitContainer/LeftPanel/TabContainer/RaceBody/VBoxContainer/MainBodySlider
@onready var main_body_label: Label = $HSplitContainer/LeftPanel/TabContainer/RaceBody/VBoxContainer/MainBodyLabel
@onready var upper_limbs_slider: HSlider = $HSplitContainer/LeftPanel/TabContainer/RaceBody/VBoxContainer/UpperLimbsSlider
@onready var upper_limbs_label: Label = $HSplitContainer/LeftPanel/TabContainer/RaceBody/VBoxContainer/UpperLimbsLabel
@onready var lower_limbs_slider: HSlider = $HSplitContainer/LeftPanel/TabContainer/RaceBody/VBoxContainer/LowerLimbsSlider
@onready var lower_limbs_label: Label = $HSplitContainer/LeftPanel/TabContainer/RaceBody/VBoxContainer/LowerLimbsLabel
@onready var neck_slider: HSlider = $HSplitContainer/LeftPanel/TabContainer/RaceBody/VBoxContainer/NeckSlider
@onready var neck_label: Label = $HSplitContainer/LeftPanel/TabContainer/RaceBody/VBoxContainer/NeckLabel
@onready var face_slider: HSlider = $HSplitContainer/LeftPanel/TabContainer/RaceBody/VBoxContainer/FaceSlider
@onready var face_label: Label = $HSplitContainer/LeftPanel/TabContainer/RaceBody/VBoxContainer/FaceLabel
@onready var skin_color_picker: ColorPickerButton = $HSplitContainer/LeftPanel/TabContainer/Head/VBoxContainer/SkinColorPicker
@onready var hair_style_option_button: OptionButton = $HSplitContainer/LeftPanel/TabContainer/Head/VBoxContainer/HairStyleOptionButton
@onready var hair_color_picker: ColorPickerButton = $HSplitContainer/LeftPanel/TabContainer/Head/VBoxContainer/HairColorPicker
@onready var eyes_option_button: OptionButton = $HSplitContainer/LeftPanel/TabContainer/Face/VBoxContainer/EyesOptionButton
@onready var nose_option_button: OptionButton = $HSplitContainer/LeftPanel/TabContainer/Face/VBoxContainer/NoseOptionButton
@onready var mouth_option_button: OptionButton = $HSplitContainer/LeftPanel/TabContainer/Face/VBoxContainer/MouthOptionButton
@onready var face_tattoo_option_button: OptionButton = $HSplitContainer/LeftPanel/TabContainer/Face/VBoxContainer/FaceTattooOptionButton
@onready var main_body_clothes_option_button: OptionButton = $HSplitContainer/LeftPanel/TabContainer/Clothes/VBoxContainer/MainBodyClothesOptionButton
@onready var upper_limbs_clothes_option_button: OptionButton = $HSplitContainer/LeftPanel/TabContainer/Clothes/VBoxContainer/UpperLimbsClothesOptionButton
@onready var lower_limbs_clothes_option_button: OptionButton = $HSplitContainer/LeftPanel/TabContainer/Clothes/VBoxContainer/LowerLimbsClothesOptionButton
@onready var main_hand_tool_option_button: OptionButton = $HSplitContainer/LeftPanel/TabContainer/Clothes/VBoxContainer/MainHandToolOptionButton
@onready var second_hand_tool_option_button: OptionButton = $HSplitContainer/LeftPanel/TabContainer/Clothes/VBoxContainer/SecondHandToolOptionButton
@onready var randomize_button: Button = $HSplitContainer/RightPanel/ButtonsContainer/RandomizeButton
@onready var reset_button: Button = $HSplitContainer/RightPanel/ButtonsContainer/ResetButton
@onready var play_button: Button = $HSplitContainer/RightPanel/ButtonsContainer/PlayButton

var character_data: CharacterData
var available_parts: Dictionary = {}

func _ready() -> void:
	character_data = CharacterData.new()
	_setup_race_options()
	_setup_sliders()
	_setup_color_pickers()
	_scan_available_parts()
	_populate_option_buttons()
	_connect_signals()
	_update_character_preview()

func _setup_race_options() -> void:
	race_option_button.clear()
	race_option_button.add_item("Beast-Human", 0)
	race_option_button.add_item("Human", 1)
	race_option_button.add_item("Robot", 2)

func _setup_sliders() -> void:
	_update_slider_label(main_body_label, main_body_slider.value)
	_update_slider_label(upper_limbs_label, upper_limbs_slider.value)
	_update_slider_label(lower_limbs_label, lower_limbs_slider.value)
	_update_slider_label(neck_label, neck_slider.value)
	_update_slider_label(face_label, face_slider.value)

func _update_slider_label(label: Label, value: float) -> void:
	label.text = label.text.split(":")[0] + ": " + str(int(value * 100)) + "%"

func _setup_color_pickers() -> void:
	skin_color_picker.color = character_data.skin_color
	hair_color_picker.color = character_data.hair_color

func _scan_available_parts() -> void:
	available_parts = {
		"hair": [],
		"eyes": [],
		"nose": [],
		"mouth": [],
		"face_tattoo": [],
		"clothes_main_body": [],
		"clothes_upper_limbs": [],
		"clothes_lower_limbs": [],
		"main_hand_tool": [],
		"second_hand_tool": []
	}
	
	# Scan for demo parts (in a real project, these would be actual files)
	# For demo purposes, we'll add some placeholder options
	available_parts["hair"] = ["Short", "Long", "Spiky", "Bald"]
	available_parts["eyes"] = ["Normal", "Large", "Narrow", "Closed"]
	available_parts["nose"] = ["Small", "Large", "Button", "Roman"]
	available_parts["mouth"] = ["Smile", "Neutral", "Frown", "Open"]
	available_parts["face_tattoo"] = ["None", "Scar", "Mark", "Paint"]
	available_parts["clothes_main_body"] = ["None", "Shirt", "Armor", "Robe"]
	available_parts["clothes_upper_limbs"] = ["None", "Gloves", "Bracers", "Sleeves"]
	available_parts["clothes_lower_limbs"] = ["None", "Pants", "Leggings", "Skirt"]
	available_parts["main_hand_tool"] = ["None", "Sword", "Staff", "Book"]
	available_parts["second_hand_tool"] = ["None", "Shield", "Tome", "Orb"]

func _populate_option_buttons() -> void:
	_populate_option(hair_style_option_button, available_parts["hair"])
	_populate_option(eyes_option_button, available_parts["eyes"])
	_populate_option(nose_option_button, available_parts["nose"])
	_populate_option(mouth_option_button, available_parts["mouth"])
	_populate_option(face_tattoo_option_button, available_parts["face_tattoo"])
	_populate_option(main_body_clothes_option_button, available_parts["clothes_main_body"])
	_populate_option(upper_limbs_clothes_option_button, available_parts["clothes_upper_limbs"])
	_populate_option(lower_limbs_clothes_option_button, available_parts["clothes_lower_limbs"])
	_populate_option(main_hand_tool_option_button, available_parts["main_hand_tool"])
	_populate_option(second_hand_tool_option_button, available_parts["second_hand_tool"])

func _populate_option(option_button: OptionButton, items: Array) -> void:
	option_button.clear()
	for item in items:
		option_button.add_item(item)

func _connect_signals() -> void:
	race_option_button.item_selected.connect(_on_race_selected)
	main_body_slider.value_changed.connect(_on_main_body_slider_changed)
	upper_limbs_slider.value_changed.connect(_on_upper_limbs_slider_changed)
	lower_limbs_slider.value_changed.connect(_on_lower_limbs_slider_changed)
	neck_slider.value_changed.connect(_on_neck_slider_changed)
	face_slider.value_changed.connect(_on_face_slider_changed)
	skin_color_picker.color_changed.connect(_on_skin_color_changed)
	hair_style_option_button.item_selected.connect(_on_hair_style_selected)
	hair_color_picker.color_changed.connect(_on_hair_color_changed)
	eyes_option_button.item_selected.connect(_on_eyes_selected)
	nose_option_button.item_selected.connect(_on_nose_selected)
	mouth_option_button.item_selected.connect(_on_mouth_selected)
	face_tattoo_option_button.item_selected.connect(_on_face_tattoo_selected)
	main_body_clothes_option_button.item_selected.connect(_on_main_body_clothes_selected)
	upper_limbs_clothes_option_button.item_selected.connect(_on_upper_limbs_clothes_selected)
	lower_limbs_clothes_option_button.item_selected.connect(_on_lower_limbs_clothes_selected)
	main_hand_tool_option_button.item_selected.connect(_on_main_hand_tool_selected)
	second_hand_tool_option_button.item_selected.connect(_on_second_hand_tool_selected)
	randomize_button.pressed.connect(_on_randomize_pressed)
	reset_button.pressed.connect(_on_reset_pressed)
	play_button.pressed.connect(_on_play_pressed)

func _on_race_selected(index: int) -> void:
	var races = ["Beast-Human", "Human", "Robot"]
	character_data.race = races[index]
	_update_character_preview()

func _on_main_body_slider_changed(value: float) -> void:
	character_data.main_body_scale = value
	_update_slider_label(main_body_label, value)
	_update_character_preview()

func _on_upper_limbs_slider_changed(value: float) -> void:
	character_data.upper_limbs_scale = value
	_update_slider_label(upper_limbs_label, value)
	_update_character_preview()

func _on_lower_limbs_slider_changed(value: float) -> void:
	character_data.lower_limbs_scale = value
	_update_slider_label(lower_limbs_label, value)
	_update_character_preview()

func _on_neck_slider_changed(value: float) -> void:
	character_data.neck_scale = value
	_update_slider_label(neck_label, value)
	_update_character_preview()

func _on_face_slider_changed(value: float) -> void:
	character_data.face_scale = value
	_update_slider_label(face_label, value)
	_update_character_preview()

func _on_skin_color_changed(color: Color) -> void:
	character_data.skin_color = color
	_update_character_preview()

func _on_hair_style_selected(index: int) -> void:
	if index < available_parts["hair"].size():
		character_data.hair_style = available_parts["hair"][index]
		_update_character_preview()

func _on_hair_color_changed(color: Color) -> void:
	character_data.hair_color = color
	_update_character_preview()

func _on_eyes_selected(index: int) -> void:
	if index < available_parts["eyes"].size():
		character_data.eyes_style = available_parts["eyes"][index]
		_update_character_preview()

func _on_nose_selected(index: int) -> void:
	if index < available_parts["nose"].size():
		character_data.nose_style = available_parts["nose"][index]
		_update_character_preview()

func _on_mouth_selected(index: int) -> void:
	if index < available_parts["mouth"].size():
		character_data.mouth_style = available_parts["mouth"][index]
		_update_character_preview()

func _on_face_tattoo_selected(index: int) -> void:
	if index < available_parts["face_tattoo"].size():
		character_data.face_tattoo = available_parts["face_tattoo"][index]
		_update_character_preview()

func _on_main_body_clothes_selected(index: int) -> void:
	if index < available_parts["clothes_main_body"].size():
		character_data.clothes_main_body = available_parts["clothes_main_body"][index]
		_update_character_preview()

func _on_upper_limbs_clothes_selected(index: int) -> void:
	if index < available_parts["clothes_upper_limbs"].size():
		character_data.clothes_upper_limbs = available_parts["clothes_upper_limbs"][index]
		_update_character_preview()

func _on_lower_limbs_clothes_selected(index: int) -> void:
	if index < available_parts["clothes_lower_limbs"].size():
		character_data.clothes_lower_limbs = available_parts["clothes_lower_limbs"][index]
		_update_character_preview()

func _on_main_hand_tool_selected(index: int) -> void:
	if index < available_parts["main_hand_tool"].size():
		character_data.main_hand_tool = available_parts["main_hand_tool"][index]
		_update_character_preview()

func _on_second_hand_tool_selected(index: int) -> void:
	if index < available_parts["second_hand_tool"].size():
		character_data.second_hand_tool = available_parts["second_hand_tool"][index]
		_update_character_preview()

func _on_randomize_pressed() -> void:
	# Randomize race
	race_option_button.selected = randi() % 3
	_on_race_selected(race_option_button.selected)
	
	# Randomize body sliders
	main_body_slider.value = randf_range(0.8, 1.2)
	upper_limbs_slider.value = randf_range(0.8, 1.2)
	lower_limbs_slider.value = randf_range(0.8, 1.2)
	neck_slider.value = randf_range(0.8, 1.2)
	face_slider.value = randf_range(0.8, 1.2)
	
	# Randomize colors
	skin_color_picker.color = Color(randf(), randf(), randf())
	hair_color_picker.color = Color(randf(), randf(), randf())
	
	# Randomize selections
	hair_style_option_button.selected = randi() % max(1, available_parts["hair"].size())
	eyes_option_button.selected = randi() % max(1, available_parts["eyes"].size())
	nose_option_button.selected = randi() % max(1, available_parts["nose"].size())
	mouth_option_button.selected = randi() % max(1, available_parts["mouth"].size())
	face_tattoo_option_button.selected = randi() % max(1, available_parts["face_tattoo"].size())
	main_body_clothes_option_button.selected = randi() % max(1, available_parts["clothes_main_body"].size())
	upper_limbs_clothes_option_button.selected = randi() % max(1, available_parts["clothes_upper_limbs"].size())
	lower_limbs_clothes_option_button.selected = randi() % max(1, available_parts["clothes_lower_limbs"].size())
	main_hand_tool_option_button.selected = randi() % max(1, available_parts["main_hand_tool"].size())
	second_hand_tool_option_button.selected = randi() % max(1, available_parts["second_hand_tool"].size())

func _on_reset_pressed() -> void:
	character_data = CharacterData.new()
	
	# Reset UI
	race_option_button.selected = 1  # Human
	main_body_slider.value = 1.0
	upper_limbs_slider.value = 1.0
	lower_limbs_slider.value = 1.0
	neck_slider.value = 1.0
	face_slider.value = 1.0
	skin_color_picker.color = Color.WHITE
	hair_color_picker.color = Color.BLACK
	
	hair_style_option_button.selected = 0
	eyes_option_button.selected = 0
	nose_option_button.selected = 0
	mouth_option_button.selected = 0
	face_tattoo_option_button.selected = 0
	main_body_clothes_option_button.selected = 0
	upper_limbs_clothes_option_button.selected = 0
	lower_limbs_clothes_option_button.selected = 0
	main_hand_tool_option_button.selected = 0
	second_hand_tool_option_button.selected = 0
	
	_update_character_preview()

func _on_play_pressed() -> void:
	# Save character data and transition to game scene
	var save_path = "user://character_save.tres"
	var err = ResourceSaver.save(character_data, save_path)
	if err == OK:
		print("Character saved to: ", save_path)
	
	# Change to the level scene
	get_tree().change_scene_to_file("res://level.tscn")

func _update_character_preview() -> void:
	if character_preview and character_preview.has_method("update_from_data"):
		character_preview.update_from_data(character_data)
