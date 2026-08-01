extends CharacterBody2D

@onready var character: ModularCharacter = $Character

const SPEED = 300.0
const JUMP_VELOCITY = -400.0

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

var saved_character_data: CharacterData = null

func _ready() -> void:
	# Load saved character data if available
	if FileAccess.file_exists("user://character_save.json"):
		var file = FileAccess.open("user://character_save.json", FileAccess.READ)
		if file:
			var json_string = file.get_as_text()
			file.close()
			
			var json = JSON.new()
			var error = json.parse(json_string)
			if error == OK:
				saved_character_data = CharacterData.new()
				saved_character_data.from_dict(json.data)
				
				# Apply the saved character data
				if character:
					character.update_from_data(saved_character_data)

func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta

	# Handle jump.
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	var direction = Input.get_axis("ui_left", "ui_right")
	
	if direction:
		velocity.x = direction * SPEED
		# Set facing direction based on movement
		if character:
			character.set_facing(direction)
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()
