#!/usr/bin/env python3
"""Generate 30-degree angled character sprites for platformer view"""

from PIL import Image, ImageDraw
import os

def create_angled_body():
    """Create main body sprite at 30% left/right angle (70% face visible)"""
    size = (64, 80)
    img = Image.new('RGBA', size, (0, 0, 0, 0))
    draw = ImageDraw.Draw(img)
    
    # Draw torso with slight angle - wider on one side to show 30% turn
    points = [
        (20, 10),  # top left shoulder
        (48, 14),  # top right shoulder (slightly higher for angle)
        (52, 60),  # bottom right hip
        (16, 56),  # bottom left hip
    ]
    draw.polygon(points, fill=(200, 160, 140, 255))  # skin tone
    
    # Add chest definition
    draw.ellipse([(24, 20), (44, 45)], fill=(190, 150, 130, 255))
    
    return img

def create_angled_arm():
    """Create single smooth arm that can bend"""
    size = (48, 70)
    img = Image.new('RGBA', size, (0, 0, 0, 0))
    draw = ImageDraw.Draw(img)
    
    # Draw smooth curved arm from shoulder to hand
    # Upper arm
    draw.ellipse([(10, 5), (30, 35)], fill=(200, 160, 140, 255))
    # Forearm (connected smoothly)
    draw.ellipse([(8, 30), (28, 55)], fill=(200, 160, 140, 255))
    # Hand
    draw.ellipse([(6, 52), (24, 68)], fill=(200, 160, 140, 255))
    
    return img

def create_angled_leg():
    """Create leg sprite"""
    size = (44, 75)
    img = Image.new('RGBA', size, (0, 0, 0, 0))
    draw = ImageDraw.Draw(img)
    
    # Draw leg
    draw.ellipse([(8, 5), (36, 35)], fill=(200, 160, 140, 255))  # thigh
    draw.ellipse([(6, 32), (34, 58)], fill=(200, 160, 140, 255))  # shin
    draw.ellipse([(4, 55), (32, 72)], fill=(190, 150, 130, 255))  # foot
    
    return img

def create_angled_neck():
    """Create neck sprite"""
    size = (32, 24)
    img = Image.new('RGBA', size, (0, 0, 0, 0))
    draw = ImageDraw.Draw(img)
    
    draw.rectangle([(10, 2), (22, 22)], fill=(200, 160, 140, 255))
    
    return img

def create_angled_face():
    """Create face sprite with 30% angle"""
    size = (56, 64)
    img = Image.new('RGBA', size, (0, 0, 0, 0))
    draw = ImageDraw.Draw(img)
    
    # Draw face oval with slight angle
    draw.ellipse([(8, 4), (52, 60)], fill=(200, 160, 140, 255))
    
    # Add subtle cheek definition for angled view
    draw.ellipse([(30, 25), (48, 45)], fill=(210, 170, 150, 180))
    
    return img

def create_hair_base():
    """Create hair base that scales with head"""
    size = (60, 50)
    img = Image.new('RGBA', size, (0, 0, 0, 0))
    draw = ImageDraw.Draw(img)
    
    # Hair covering top of head
    draw.ellipse([(8, 2), (52, 42)], fill=(60, 40, 20, 255))
    
    return img

def create_hair_flow():
    """Create flowing hair part"""
    size = (56, 70)
    img = Image.new('RGBA', size, (0, 0, 0, 0))
    draw = ImageDraw.Draw(img)
    
    # Flowing hair strands
    for i in range(5):
        x_offset = 8 + i * 10
        length = 30 + (i % 3) * 10
        draw.ellipse([(x_offset, 5), (x_offset + 8, 5 + length)], fill=(60, 40, 20, 255))
    
    return img

def create_eye():
    """Create eye sprite"""
    size = (24, 16)
    img = Image.new('RGBA', size, (0, 0, 0, 0))
    draw = ImageDraw.Draw(img)
    
    # Almond shaped eye for angled view
    draw.ellipse([(2, 2), (22, 14)], fill=(255, 255, 255, 255))
    draw.ellipse([(8, 4), (18, 12)], fill=(60, 40, 20, 255))  # iris
    draw.ellipse([(12, 6), (16, 10)], fill=(0, 0, 0, 255))  # pupil
    
    return img

def create_nose():
    """Create nose sprite with angle"""
    size = (20, 24)
    img = Image.new('RGBA', size, (0, 0, 0, 0))
    draw = ImageDraw.Draw(img)
    
    # Nose from side angle
    draw.polygon([(10, 2), (16, 12), (12, 20), (8, 12)], fill=(180, 140, 120, 255))
    
    return img

def create_mouth():
    """Create mouth sprite"""
    size = (28, 16)
    img = Image.new('RGBA', size, (0, 0, 0, 0))
    draw = ImageDraw.Draw(img)
    
    # Curved mouth line
    draw.arc([(4, 4), (24, 12)], 0, 180, fill=(140, 80, 60, 255), width=2)
    
    return img

def create_tattoo_body():
    """Create body tattoo design"""
    size = (48, 48)
    img = Image.new('RGBA', size, (0, 0, 0, 0))
    draw = ImageDraw.Draw(img)
    
    # Tribal-style design
    for i in range(3):
        y = 10 + i * 12
        draw.line([(8, y), (40, y + 8)], fill=(50, 50, 50, 200), width=2)
    
    return img

def create_tattoo_face():
    """Create face tattoo design"""
    size = (32, 32)
    img = Image.new('RGBA', size, (0, 0, 0, 0))
    draw = ImageDraw.Draw(img)
    
    # Small tribal marks
    draw.line([(8, 8), (24, 16)], fill=(50, 50, 50, 200), width=2)
    draw.line([(8, 16), (24, 8)], fill=(50, 50, 50, 200), width=2)
    
    return img

def create_sword():
    """Create sword sprite"""
    size = (24, 80)
    img = Image.new('RGBA', size, (0, 0, 0, 0))
    draw = ImageDraw.Draw(img)
    
    # Blade
    draw.polygon([(10, 4), (14, 4), (12, 60)], fill=(200, 200, 210, 255))
    # Guard
    draw.rectangle([(4, 58), (20, 64)], fill=(150, 130, 100, 255))
    # Handle
    draw.rectangle([(10, 64), (14, 76)], fill=(100, 60, 40, 255))
    
    return img

def create_shield():
    """Create shield sprite"""
    size = (40, 56)
    img = Image.new('RGBA', size, (0, 0, 0, 0))
    draw = ImageDraw.Draw(img)
    
    # Shield shape
    draw.polygon([(20, 2), (38, 14), (38, 42), (20, 54), (2, 42), (2, 14)], 
                 fill=(100, 100, 120, 255))
    draw.ellipse([(12, 20), (28, 36)], fill=(120, 120, 140, 255))
    
    return img

def create_staff():
    """Create staff sprite"""
    size = (16, 90)
    img = Image.new('RGBA', size, (0, 0, 0, 0))
    draw = ImageDraw.Draw(img)
    
    # Staff pole
    draw.rectangle([(6, 20), (10, 90)], fill=(120, 80, 40, 255))
    # Crystal on top
    draw.ellipse([(4, 4), (12, 24)], fill=(100, 200, 255, 200))
    
    return img

def create_book():
    """Create book sprite"""
    size = (36, 44)
    img = Image.new('RGBA', size, (0, 0, 0, 0))
    draw = ImageDraw.Draw(img)
    
    # Book cover
    draw.rectangle([(4, 4), (32, 40)], fill=(80, 40, 20, 255))
    # Pages
    draw.rectangle([(8, 8), (30, 36)], fill=(240, 230, 200, 255))
    
    return img

def create_hat():
    """Create hat accessory"""
    size = (56, 40)
    img = Image.new('RGBA', size, (0, 0, 0, 0))
    draw = ImageDraw.Draw(img)
    
    # Hat brim
    draw.ellipse([(4, 28), (52, 38)], fill=(60, 40, 20, 255))
    # Hat top
    draw.ellipse([(12, 8), (44, 30)], fill=(60, 40, 20, 255))
    
    return img

def create_glove():
    """Create glove accessory"""
    size = (32, 36)
    img = Image.new('RGBA', size, (0, 0, 0, 0))
    draw = ImageDraw.Draw(img)
    
    # Glove shape
    draw.ellipse([(4, 4), (28, 32)], fill=(100, 80, 60, 255))
    
    return img

def create_boot():
    """Create boot accessory"""
    size = (32, 40)
    img = Image.new('RGBA', size, (0, 0, 0, 0))
    draw = ImageDraw.Draw(img)
    
    # Boot shape
    draw.rectangle([(6, 4), (26, 28)], fill=(60, 40, 20, 255))
    draw.rectangle([(4, 28), (28, 38)], fill=(50, 30, 10, 255))
    
    return img

def create_shirt():
    """Create shirt clothes"""
    size = (64, 70)
    img = Image.new('RGBA', size, (0, 0, 0, 0))
    draw = ImageDraw.Draw(img)
    
    # Shirt body
    draw.polygon([(16, 8), (48, 8), (52, 56), (12, 56)], fill=(60, 100, 160, 255))
    # Collar
    draw.polygon([(24, 8), (40, 8), (32, 16)], fill=(50, 90, 150, 255))
    
    return img

def create_pants():
    """Create pants clothes"""
    size = (56, 60)
    img = Image.new('RGBA', size, (0, 0, 0, 0))
    draw = ImageDraw.Draw(img)
    
    # Pants
    draw.polygon([(12, 4), (26, 4), (24, 56), (8, 56)], fill=(40, 60, 100, 255))
    draw.polygon([(30, 4), (44, 4), (48, 56), (32, 56)], fill=(40, 60, 100, 255))
    
    return img

def save_sprite(img, name, directory):
    """Save sprite to file"""
    filepath = os.path.join(directory, f"{name}.png")
    img.save(filepath)
    print(f"Created: {filepath}")
    
    # Create .import file
    import_content = f"""[remap]

importer="texture"
type="CompressedTexture2D"
uid="uid://{name}"
path="res://character_creator/assets/sprites_30deg/{name}.ctex"

[deps]

source_file="res://character_creator/assets/sprites_30deg/{name}.png"

[params]

compress/mode=0
compress/high_quality=false
compress/lossy_quality=0.7
compress/hdr_compression=1
compress/bptc_ldr=0
compress/normal_map=0
compress/channel_pack=0
mipmaps/generate=false
mipmaps/limit=-1
roughness/mode=0
roughness/src_normal=""
process/fix_alpha_border=true
process/premult_alpha=false
process/invert_color=false
process/normal_map_invert_y=false
process/hdr_as_srgb=false
process/hdr_clamp_exposure=false
process/size_limit=0
detect_3d/compress_to=1
"""
    import_path = os.path.join(directory, f"{name}.png.import")
    with open(import_path, 'w') as f:
        f.write(import_content)
    print(f"Created: {import_path}")

def main():
    output_dir = "/workspace/character_creator/assets/sprites_30deg"
    os.makedirs(output_dir, exist_ok=True)
    
    sprites = {
        "body": create_angled_body,
        "arm_smooth": create_angled_arm,
        "leg": create_angled_leg,
        "neck": create_angled_neck,
        "face": create_angled_face,
        "hair_base": create_hair_base,
        "hair_flow": create_hair_flow,
        "eye": create_eye,
        "nose": create_nose,
        "mouth": create_mouth,
        "tattoo_body": create_tattoo_body,
        "tattoo_face": create_tattoo_face,
        "sword": create_sword,
        "shield": create_shield,
        "staff": create_staff,
        "book": create_book,
        "hat": create_hat,
        "glove": create_glove,
        "boot": create_boot,
        "shirt": create_shirt,
        "pants": create_pants,
    }
    
    for name, func in sprites.items():
        img = func()
        save_sprite(img, name, output_dir)
    
    print(f"\nGenerated {len(sprites)} sprites in {output_dir}")

if __name__ == "__main__":
    main()
