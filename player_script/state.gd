extends Node
class_name State

var state_machine : StateMachine

# Player animation and sprite
@onready var player_animation: AnimationPlayer = $"../../AnimationPlayer"
@onready var player_sprite: Sprite2D = $"../../PlayerBasicMovementSprite"

# Nodes inside BowAnimation Node2D. Player with bow animation, sprite, and marker2d/pivot
@onready var bow_animation: Node2D = $"../../BowAnimation"
@onready var player_bow_arrow_sprite: Sprite2D = $"../../BowAnimation/PlayerBow&ArrowSprite"
@onready var bow_draw_sprite: Sprite2D = $"../../BowAnimation/Marker2D/BowDrawSprite"
@onready var bow_pivot: Marker2D = $"../../BowAnimation/Marker2D"

# For checking if dash is ready or not with dash_state.dash_ready
@onready var dash_state: DashState = $"../DashState"

const WALK_SPEED := 200.0
const GRAVITY := 980.0
const JUMP_VELOCITY := -400.0

func enter(): pass
func exit(): pass
func update(delta: float): pass
func physics_update(delta: float): pass
func handle_input(event: InputEvent): pass
