class_name ModularCharacter
extends Node2D

# Body part nodes
@onready var main_body: Sprite2D = $BodyRoot/MainBody
@onready var left_arm: Sprite2D = $BodyRoot/UpperLimbs/LeftArm
@onready var right_arm: Sprite2D = $BodyRoot/UpperLimbs/RightArm
@onready var left_leg: Sprite2D = $BodyRoot/LowerLimbs/LeftLeg
@onready var right_leg: Sprite2D = $BodyRoot/LowerLimbs/RightLeg
@onready var neck: Sprite2D = $BodyRoot/Neck
@onready var head: Node2D = $BodyRoot/Head
@onready var face: Sprite2D = $BodyRoot/Head/Face
@onready var eyes: Sprite2D = $BodyRoot/Head/Eyes
@onready var nose: Sprite2D = $BodyRoot/Head/Nose
@onready var mouth: Sprite2D = $BodyRoot/Head/Mouth
@onready var hair_base: Sprite2D = $BodyRoot/Head/HairBase
@onready var hair_flow: Sprite2D = $BodyRoot/Head/HairFlow

# Tattoo nodes
@onready var body_tattoo: Sprite2D = $BodyRoot/Tattoos/BodyTattoo
@onready var left_arm_tattoo: Sprite2D = $BodyRoot/Tattoos/UpperLimbsTattoo/LeftArmTattoo
@onready var right_arm_tattoo: Sprite2D = $BodyRoot/Tattoos/UpperLimbsTattoo/RightArmTattoo
@onready var left_leg_tattoo: Sprite2D = $BodyRoot/Tattoos/LowerLimbsTattoo/LeftLegTattoo
@onready var right_leg_tattoo: Sprite2D = $BodyRoot/Tattoos/LowerLimbsTattoo/RightLegTattoo
@onready var face_tattoo: Sprite2D = $BodyRoot/Head/FaceTattoo

# Clothes nodes
@onready var main_body_clothes: Sprite2D = $BodyRoot/Clothes/MainBodyClothes
@onready var left_arm_clothes: Sprite2D = $BodyRoot/Clothes/UpperLimbsClothes/LeftArmClothes
@onready var right_arm_clothes: Sprite2D = $BodyRoot/Clothes/UpperLimbsClothes/RightArmClothes
@onready var left_leg_clothes: Sprite2D = $BodyRoot/Clothes/LowerLimbsClothes/LeftLegClothes
@onready var right_leg_clothes: Sprite2D = $BodyRoot/Clothes/LowerLimbsClothes/RightLegClothes

# Accessory nodes
@onready var hair_accessory: Sprite2D = $BodyRoot/Accessories/HairAccessory
@onready var left_arm_accessory: Sprite2D = $BodyRoot/Accessories/UpperLimbsAccessory/LeftArmAccessory
@onready var right_arm_accessory: Sprite2D = $BodyRoot/Accessories/UpperLimbsAccessory/RightArmAccessory
@onready var left_leg_accessory: Sprite2D = $BodyRoot/Accessories/LowerLimbsAccessory/LeftLegAccessory
@onready var right_leg_accessory: Sprite2D = $BodyRoot/Accessories/LowerLimbsAccessory/RightLegAccessory

# Tool nodes
@onready var main_hand_tool: Sprite2D = $BodyRoot/Tools/MainHandTool
@onready var second_hand_tool: Sprite2D = $BodyRoot/Tools/SecondHandTool

var character_data: CharacterData
var placeholder_color: Color = Color.GRAY

func _ready() -> void:
	_initialize_sprites()

func _initialize_sprites() -> void:
	# Create placeholder textures for all sprites
	var sprites = [
		main_body, left_arm, right_arm, left_leg, right_leg, neck,
		face, eyes, nose, mouth, hair_base, hair_flow,
		body_tattoo, left_arm_tattoo, right_arm_tattoo, left_leg_tattoo, right_leg_tattoo, face_tattoo,
		main_body_clothes, left_arm_clothes, right_arm_clothes, left_leg_clothes, right_leg_clothes,
		hair_accessory, left_arm_accessory, right_arm_accessory, left_leg_accessory, right_leg_accessory,
		main_hand_tool, second_hand_tool
	]
	
	for sprite in sprites:
		if sprite:
			sprite.texture = _create_placeholder_texture(32, 32, placeholder_color)

func _create_placeholder_texture(width: int, height: int, color: Color) -> ImageTexture:
	var image = Image.create(width, height, false, Image.FORMAT_RGBA8)
	image.fill(color)
	return ImageTexture.create_from_image(image)

func update_from_data(data: CharacterData) -> void:
	character_data = data
	_apply_body_shapes()
	_apply_skin_color()
	_apply_hair()
	_apply_face_features()
	_apply_tattoos()
	_apply_clothes()
	_apply_accessories()
	_apply_tools()

func _apply_body_shapes() -> void:
	if not character_data:
		return
	
	# Apply scale modifiers to body parts
	if main_body:
		main_body.scale = Vector2(character_data.main_body_scale, character_data.main_body_scale)
	
	if left_arm and right_arm:
		var arm_scale = character_data.upper_limbs_scale
		left_arm.scale = Vector2(arm_scale, arm_scale)
		right_arm.scale = Vector2(arm_scale, arm_scale)
	
	if left_leg and right_leg:
		var leg_scale = character_data.lower_limbs_scale
		left_leg.scale = Vector2(leg_scale, leg_scale)
		right_leg.scale = Vector2(leg_scale, leg_scale)
	
	if neck:
		neck.scale = Vector2(character_data.neck_scale, character_data.neck_scale)
	
	if face:
		face.scale = Vector2(character_data.face_scale, character_data.face_scale)

func _apply_skin_color() -> void:
	if not character_data:
		return
	
	# Apply skin color to relevant body parts
	var skin_color = character_data.skin_color
	var sprites_to_color = [main_body, left_arm, right_arm, left_leg, right_leg, neck, face]
	
	for sprite in sprites_to_color:
		if sprite:
			sprite.modulate = skin_color

func _apply_hair() -> void:
	if not character_data:
		return
	
	# Apply hair style (in a real implementation, this would load different textures)
	if hair_base:
		if not character_data.hair_style.is_empty() and character_data.hair_style != "Bald":
			hair_base.texture = _create_hair_texture(character_data.hair_style)
			hair_base.modulate = character_data.hair_color
		else:
			hair_base.texture = null
	
	if hair_flow:
		if not character_data.hair_style.is_empty() and character_data.hair_style != "Bald":
			hair_flow.texture = _create_hair_flow_texture(character_data.hair_style)
			hair_flow.modulate = character_data.hair_color
			# Add slight offset for wind/movement effect
			hair_flow.position = Vector2(0, -10 + sin(Time.get_ticks_msec() / 1000.0) * 2)
		else:
			hair_flow.texture = null

func _create_hair_texture(style: String) -> Texture2D:
	var size = 40
	var image = Image.create(size, size, false, Image.FORMAT_RGBA8)
	image.fill(Color.TRANSPARENT)
	
	# Draw different hair shapes based on style
	match style:
		"Short":
			_draw_ellipse(image, size/2, size/2, 15, 10, Color.WHITE)
		"Long":
			_draw_ellipse(image, size/2, size/2, 12, 25, Color.WHITE)
		"Spiky":
			_draw_spiky_shape(image, size/2, size/2, 15, Color.WHITE)
		_:
			_draw_ellipse(image, size/2, size/2, 15, 10, Color.WHITE)
	
	return ImageTexture.create_from_image(image)

func _create_hair_flow_texture(style: String) -> Texture2D:
	var size = 50
	var image = Image.create(size, size, false, Image.FORMAT_RGBA8)
	image.fill(Color.TRANSPARENT)
	
	match style:
		"Long":
			_draw_ellipse(image, size/2, 10, 10, 30, Color.WHITE)
		"Spiky":
			_draw_spiky_shape(image, size/2, 15, 12, Color.WHITE)
		_:
			_draw_ellipse(image, size/2, 15, 12, 15, Color.WHITE)
	
	return ImageTexture.create_from_image(image)

func _draw_ellipse(image: Image, cx: int, cy: int, rx: int, ry: int, color: Color) -> void:
	for x in range(-rx, rx + 1):
		for y in range(-ry, ry + 1):
			if float(x * x) / (rx * rx) + float(y * y) / (ry * ry) <= 1.0:
				if cx + x >= 0 and cx + x < image.get_width() and cy + y >= 0 and cy + y < image.get_height():
					image.set_pixel(cx + x, cy + y, color)

func _draw_spiky_shape(image: Image, cx: int, cy: int, radius: int, color: Color) -> void:
	var spikes = 8
	for i in range(spikes):
		var angle = (2 * PI * i) / spikes
		var outer_x = cx + cos(angle) * radius
		var outer_y = cy + sin(angle) * radius
		var inner_angle = angle + PI / spikes
		var inner_x = cx + cos(inner_angle) * (radius * 0.5)
		var inner_y = cy + sin(inner_angle) * (radius * 0.5)
		
		# Draw triangle from center to outer point
		_draw_triangle(image, Vector2(cx, cy), Vector2(outer_x, outer_y), Vector2(inner_x, inner_y), color)

func _draw_triangle(image: Image, p1: Vector2, p2: Vector2, p3: Vector2, color: Color) -> void:
	# Simple filled triangle drawing
	var min_x = mini(p1.x, p2.x, p3.x)
	var max_x = maxi(p1.x, p2.x, p3.x)
	var min_y = mini(p1.y, p2.y, p3.y)
	var max_y = maxi(p1.y, p2.y, p3.y)
	
	for x in range(int(min_x), int(max_x) + 1):
		for y in range(int(min_y), int(max_y) + 1):
			if _point_in_triangle(Vector2(x, y), p1, p2, p3):
				if x >= 0 and x < image.get_width() and y >= 0 and y < image.get_height():
					image.set_pixel(x, y, color)

func _point_in_triangle(p: Vector2, a: Vector2, b: Vector2, c: Vector2) -> bool:
	var v0 = c - a
	var v1 = b - a
	var v2 = p - a
	
	var dot00 = v0.dot(v0)
	var dot01 = v0.dot(v1)
	var dot02 = v0.dot(v2)
	var dot11 = v1.dot(v1)
	var dot12 = v1.dot(v2)
	
	var inv_denom = 1.0 / (dot00 * dot11 - dot01 * dot01)
	var u = (dot11 * dot02 - dot01 * dot12) * inv_denom
	var v = (dot00 * dot12 - dot01 * dot02) * inv_denom
	
	return (u >= 0) and (v >= 0) and (u + v < 1)

func _apply_face_features() -> void:
	if not character_data:
		return
	
	# Apply face features
	if eyes:
		if not character_data.eyes_style.is_empty():
			eyes.texture = _create_eye_texture(character_data.eyes_style)
	
	if nose:
		if not character_data.nose_style.is_empty():
			nose.texture = _create_nose_texture(character_data.nose_style)
	
	if mouth:
		if not character_data.mouth_style.is_empty():
			mouth.texture = _create_mouth_texture(character_data.mouth_style)

func _create_eye_texture(style: String) -> Texture2D:
	var size = 20
	var image = Image.create(size, size, false, Image.FORMAT_RGBA8)
	image.fill(Color.TRANSPARENT)
	
	match style:
		"Normal":
			_draw_ellipse(image, size/2, size/2, 6, 4, Color.BLACK)
		"Large":
			_draw_ellipse(image, size/2, size/2, 8, 6, Color.BLACK)
		"Narrow":
			_draw_ellipse(image, size/2, size/2, 8, 2, Color.BLACK)
		_:
			_draw_ellipse(image, size/2, size/2, 6, 4, Color.BLACK)
	
	return ImageTexture.create_from_image(image)

func _create_nose_texture(style: String) -> Texture2D:
	var size = 15
	var image = Image.create(size, size, false, Image.FORMAT_RGBA8)
	image.fill(Color.TRANSPARENT)
	
	match style:
		"Small":
			image.set_pixel(size/2, size/2, Color.DARK_GRAY)
		"Large":
			_draw_ellipse(image, size/2, size/2, 4, 5, Color.DARK_GRAY)
		"Button":
			_draw_ellipse(image, size/2, size/2, 3, 3, Color.DARK_GRAY)
		_:
			_draw_ellipse(image, size/2, size/2, 3, 4, Color.DARK_GRAY)
	
	return ImageTexture.create_from_image(image)

func _create_mouth_texture(style: String) -> Texture2D:
	var size = 20
	var image = Image.create(size, size, false, Image.FORMAT_RGBA8)
	image.fill(Color.TRANSPARENT)
	
	match style:
		"Smile":
			for x in range(5, 15):
				image.set_pixel(x, 8 + int(sin(float(x - 5) / 10.0 * PI) * 3), Color.DARK_RED)
		"Frown":
			for x in range(5, 15):
				image.set_pixel(x, 10 - int(sin(float(x - 5) / 10.0 * PI) * 3), Color.DARK_RED)
		"Open":
			_draw_ellipse(image, size/2, size/2, 5, 4, Color.DARK_RED)
		_:
			for x in range(5, 15):
				image.set_pixel(x, 9, Color.DARK_RED)
	
	return ImageTexture.create_from_image(image)

func _apply_tattoos() -> void:
	if not character_data:
		return
	
	# Apply tattoos
	if body_tattoo:
		if not character_data.body_tattoo.is_empty():
			body_tattoo.texture = _create_tattoo_texture(character_data.body_tattoo)
			body_tattoo.scale = Vector2(character_data.body_tattoo_scale, character_data.body_tattoo_scale)
			body_tattoo.position = character_data.body_tattoo_position
		else:
			body_tattoo.texture = null
	
	if face_tattoo:
		if not character_data.face_tattoo.is_empty() and character_data.face_tattoo != "None":
			face_tattoo.texture = _create_tattoo_texture(character_data.face_tattoo)
			face_tattoo.scale = Vector2(character_data.face_tattoo_scale, character_data.face_tattoo_scale)
			face_tattoo.position = character_data.face_tattoo_position
		else:
			face_tattoo.texture = null

func _create_tattoo_texture(design: String) -> Texture2D:
	var size = 30
	var image = Image.create(size, size, false, Image.FORMAT_RGBA8)
	image.fill(Color.TRANSPARENT)
	
	match design:
		"Scar":
			for i in range(20):
				image.set_pixel(5 + i, 15 + int(sin(float(i) / 3.0) * 2), Color.RED)
		"Mark":
			_draw_ellipse(image, size/2, size/2, 8, 8, Color.BLACK)
		"Paint":
			for i in range(5):
				_draw_ellipse(image, 10 + i * 5, 15, 3, 3, Color.BLUE)
		_:
			pass
	
	return ImageTexture.create_from_image(image)

func _apply_clothes() -> void:
	if not character_data:
		return
	
	# Apply clothes
	if main_body_clothes:
		if not character_data.clothes_main_body.is_empty() and character_data.clothes_main_body != "None":
			main_body_clothes.texture = _create_clothes_texture(character_data.clothes_main_body)
			main_body_clothes.modulate = _get_clothes_color(character_data.clothes_main_body)
		else:
			main_body_clothes.texture = null

func _create_clothes_texture(type: String) -> Texture2D:
	var size = 50
	var image = Image.create(size, size, false, Image.FORMAT_RGBA8)
	image.fill(Color.TRANSPARENT)
	
	match type:
		"Shirt":
			_draw_ellipse(image, size/2, size/2, 20, 25, Color.WHITE)
		"Armor":
			_draw_ellipse(image, size/2, size/2, 22, 27, Color.GRAY)
		"Robe":
			_draw_ellipse(image, size/2, size/2, 25, 30, Color.PURPLE)
		_:
			pass
	
	return ImageTexture.create_from_image(image)

func _get_clothes_color(type: String) -> Color:
	match type:
		"Shirt":
			return Color.WHITE
		"Armor":
			return Color(0.5, 0.5, 0.6)
		"Robe":
			return Color(0.6, 0.3, 0.7)
		_:
			return Color.WHITE

func _apply_accessories() -> void:
	if not character_data:
		return
	
	# Hide accessories by default for demo
	if hair_accessory:
		hair_accessory.visible = not character_data.hair_accessory.is_empty()
	if main_hand_tool:
		main_hand_tool.visible = not character_data.main_hand_tool.is_empty()
	if second_hand_tool:
		second_hand_tool.visible = not character_data.second_hand_tool.is_empty()

func _apply_tools() -> void:
	if not character_data:
		return
	
	# Apply tools
	if main_hand_tool:
		if not character_data.main_hand_tool.is_empty() and character_data.main_hand_tool != "None":
			main_hand_tool.texture = _create_tool_texture(character_data.main_hand_tool)
			main_hand_tool.visible = true
		else:
			main_hand_tool.visible = false
	
	if second_hand_tool:
		if not character_data.second_hand_tool.is_empty() and character_data.second_hand_tool != "None":
			second_hand_tool.texture = _create_tool_texture(character_data.second_hand_tool)
			second_hand_tool.visible = true
		else:
			second_hand_tool.visible = false

func _create_tool_texture(type: String) -> Texture2D:
	var size = 40
	var image = Image.create(size, size, false, Image.FORMAT_RGBA8)
	image.fill(Color.TRANSPARENT)
	
	match type:
		"Sword":
			for i in range(30):
				image.set_pixel(size/2, 5 + i, Color.SILVER)
			image.set_pixel(size/2, 35, Color.BROWN)
		"Staff":
			for i in range(35):
				image.set_pixel(size/2, 2 + i, Color.BROWN)
			_draw_ellipse(image, size/2, 5, 5, 5, Color.GOLD)
		"Book":
			_draw_ellipse(image, size/2 - 5, size/2, 8, 10, Color.BROWN)
		"Shield":
			_draw_ellipse(image, size/2, size/2, 12, 15, Color.GOLD)
		"Tome":
			_draw_ellipse(image, size/2, size/2, 10, 12, Color.BLUE)
		"Orb":
			_draw_ellipse(image, size/2, size/2, 10, 10, Color.CYAN)
		_:
			pass
	
	return ImageTexture.create_from_image(image)

func _process(_delta: float) -> void:
	# Animate hair flow for dynamic effect
	if hair_flow and character_data and not character_data.hair_style.is_empty():
		hair_flow.position = Vector2(sin(Time.get_ticks_msec() / 1000.0) * 2, -10 + cos(Time.get_ticks_msec() / 500.0) * 2)
