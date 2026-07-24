class_name CharacterData
extends Resource

# Race selection
@export_enum("Beast-Human", "Human", "Robot") var race: String = "Human"

# Body shape modifiers (0.8 to 1.2 scale)
@export_range(0.8, 1.2, 0.01) var main_body_scale: float = 1.0
@export_range(0.8, 1.2, 0.01) var upper_limbs_scale: float = 1.0
@export_range(0.8, 1.2, 0.01) var lower_limbs_scale: float = 1.0
@export_range(0.8, 1.2, 0.01) var neck_scale: float = 1.0
@export_range(0.8, 1.2, 0.01) var face_scale: float = 1.0

# Tattoos
@export var body_tattoo: String = ""
@export var upper_limbs_tattoo: String = ""
@export var lower_limbs_tattoo: String = ""
@export var body_tattoo_scale: float = 1.0
@export var body_tattoo_position: Vector2 = Vector2.ZERO
@export var upper_limbs_tattoo_scale: float = 1.0
@export var upper_limbs_tattoo_position: Vector2 = Vector2.ZERO
@export var lower_limbs_tattoo_scale: float = 1.0
@export var lower_limbs_tattoo_position: Vector2 = Vector2.ZERO

# Head customization
@export var skin_color: Color = Color.WHITE
@export var hair_style: String = ""
@export var hair_color: Color = Color.BLACK
@export var hair_offset: Vector2 = Vector2.ZERO

# Face customization
@export var eyes_style: String = ""
@export var nose_style: String = ""
@export var mouth_style: String = ""
@export var face_tattoo: String = ""
@export var face_tattoo_scale: float = 1.0
@export var face_tattoo_position: Vector2 = Vector2.ZERO

# Clothing preview (temporary)
@export var clothes_main_body: String = ""
@export var clothes_upper_limbs: String = ""
@export var clothes_lower_limbs: String = ""
@export var hair_accessory: String = ""
@export var upper_limbs_accessory: String = ""
@export var lower_limbs_accessory: String = ""
@export var main_hand_tool: String = ""
@export var second_hand_tool: String = ""

# Loaded textures
var loaded_parts: Dictionary = {}

func get_part_path(part_type: String, part_name: String) -> String:
	var base_path = "res://character_creator/assets/"
	match part_type:
		"body":
			return base_path + "body_parts/" + part_name + ".png"
		"hair":
			return base_path + "hair/" + part_name + ".png"
		"face":
			return base_path + "faces/" + part_name + ".png"
		"tattoo":
			return base_path + "tattoos/" + part_name + ".png"
		"clothes":
			return base_path + "clothes/" + part_name + ".png"
		"accessory":
			return base_path + "accessories/" + part_name + ".png"
	return ""

func load_texture(part_type: String, part_name: String) -> Texture2D:
	if part_name.is_empty():
		return null
	var path = get_part_path(part_type, part_name)
	if ResourceLoader.exists(path):
		return load(path)
	# Try DLC paths
	for dlc_id in get_dlc_ids():
		var dlc_path = "res://character_creator/dlc/" + dlc_id + "/" + part_type + "/" + part_name + ".png"
		if ResourceLoader.exists(dlc_path):
			return load(dlc_path)
	return null

func get_dlc_ids() -> Array:
	var dlc_ids: Array = []
	var dir = DirAccess.open("res://character_creator/dlc")
	if dir:
		dir.list_dir_begin()
		var file_name = dir.get_next()
		while file_name != "":
			if dir.current_is_dir() and not file_name.begins_with("."):
				dlc_ids.append(file_name)
			file_name = dir.get_next()
	return dlc_ids
