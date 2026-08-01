extends Node2D

var saved_character_data: CharacterData

func _ready() -> void:
	var camera: Camera2D = find_child("Camera2D")
	var min_pos: Vector2 = $CameraLimit_min.global_position
	var max_pos: Vector2 = $CameraLimit_max.global_position
	camera.limit_left = round(min_pos.x)
	camera.limit_top = round(min_pos.y)
	camera.limit_right = round(max_pos.x)
	camera.limit_bottom = round(max_pos.y)
	
	# Load saved character data and apply to player
	_load_character_data()

func _load_character_data() -> void:
	var save_path = "user://character_save.tres"
	if ResourceLoader.exists(save_path):
		var loaded_data = ResourceLoader.load(save_path)
		if loaded_data is CharacterData:
			saved_character_data = loaded_data
			# Apply character data to the player
			var player = $SkeletalPlayer
			if player and player.has_method("apply_character_data"):
				player.apply_character_data(saved_character_data)
			print("Character data loaded and applied to player")
