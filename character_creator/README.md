# Character Creator for Skeleton2D Demo

## Overview
This character creator allows users to build custom 2D characters with modular parts before playing the platformer game. It's set as the launching scene and transitions to the gameplay after character creation.

## Features

### 0. Race Selection
- **Beast-Human**: Hybrid creature features
- **Human**: Standard human proportions
- **Robot**: Mechanical/technological appearance

### 1. Body Shape Customization
Users can adjust body part scales from 80% to 120% using sliders:
- **Main Body**: Torso size
- **Upper Limbs**: Arm thickness/length
- **Lower Limbs**: Leg thickness/length
- **Neck**: Neck length/thickness
- **Face**: Face size/proportions

#### Tattoos (with position and scale controls)
- Body tattoos
- Upper limbs tattoos
- Lower limbs tattoos
- Face tattoos

### 2. Head Customization
- **Skin Color**: Full color picker
- **Hair Style**: Multiple styles with selection
  - Hair base layer (scales with head)
  - Hair flow layer (animated, moves with wind/character movement)
- **Hair Color**: Full color picker

### 3. Face Customization
- **Eyes**: Multiple style options
- **Nose**: Various shapes and sizes
- **Mouth**: Different expressions
- **Face Tattoo**: Additional facial markings

### 4. Clothing Preview (Try-On System)
Temporary clothing preview without ownership:
- Main body clothes
- Upper limbs clothes
- Lower limbs clothes
- Hair accessories
- Upper limbs accessories (gloves, bracers)
- Lower limbs accessories (boots, greaves)
- Main hand tool (sword, staff, etc.)
- Second hand tool (shield, book, etc.)

All clothing scales according to body part modifications.

## DLC Support
The system supports downloadable content packs defined by JSON configuration files in the `dlc/` folder:

### Example DLC Structure
```
dlc/
├── fantasy_pack.json
└── scifi_pack.json
```

Each DLC defines additional parts that get loaded dynamically.

## Technical Implementation

### Files Created
1. **character_data.gd** - Resource class storing all character customization data
2. **character_creator.tscn** - Main UI scene with tabs for each customization category
3. **character_creator.gd** - UI controller handling all user interactions
4. **modular_character.tscn** - Scene with all body part nodes organized hierarchically
5. **modular_character.gd** - Script that applies character data to visual parts
6. **DLC JSON files** - Configuration for downloadable content

### Modular Character Rig
The character uses a hierarchical node structure:
```
ModularCharacter
└── BodyRoot
    ├── MainBody (Sprite2D)
    ├── UpperLimbs (Node2D)
    │   ├── LeftArm (Sprite2D)
    │   └── RightArm (Sprite2D)
    ├── LowerLimbs (Node2D)
    │   ├── LeftLeg (Sprite2D)
    │   └── RightLeg (Sprite2D)
    ├── Neck (Sprite2D)
    ├── Head (Node2D)
    │   ├── Face (Sprite2D)
    │   ├── Eyes (Sprite2D)
    │   ├── Nose (Sprite2D)
    │   ├── Mouth (Sprite2D)
    │   ├── HairBase (Sprite2D)
    │   ├── HairFlow (Sprite2D) - Animated
    │   └── FaceTattoo (Sprite2D)
    ├── Tattoos (Node2D)
    ├── Clothes (Node2D)
    ├── Accessories (Node2D)
    └── Tools (Node2D)
        ├── MainHandTool (Sprite2D)
        └── SecondHandTool (Sprite2D)
```

### Key Features
- **Procedural Textures**: Demo includes procedural texture generation for all parts
- **Real-time Preview**: All changes update immediately
- **Hair Animation**: Hair flow layer animates based on time (simulating wind/movement)
- **Save System**: Character data can be saved and loaded
- **Randomize Button**: Generate random character configurations
- **Reset Button**: Return to default settings

## Usage
1. Launch the project - Character Creator opens first
2. Customize your character using the tabbed interface
3. Use "Randomize" for inspiration or "Reset" to start over
4. Click "Play!" to save and transition to the platformer level

## Integration with Existing Player
The character creator saves data to `user://character_save.tres`. The existing player scene can be modified to load this data and apply it to the in-game character rig.

## Future Enhancements
- Add actual sprite assets to replace procedural textures
- Implement tattoo drag-and-drop positioning
- Add more animation to hair and accessories
- Create proper skeleton rigging for the modular character
- Add race-specific body part variations
- Implement proper DLC download system
