extends CharacterBody3D
class_name OW_Pawn

const Utils = preload("res://src/utils.gd")

@export var pawn_class : Utils.PAWN_CLASSES

var camera : TacticsCamera
var is_joystick = false
var grid_map : GridMap

var curr_frame : int = 0
var animator = null

const SPEED = 7
const ANIMATION_FRAMES = 1
const MIN_HEIGHT_TO_JUMP = 1
const GRAVITY_STRENGTH = 7
const MIN_TIME_FOR_ATTACK = 1

# stats
var move_radious 
var jump_height
var attack_radious
var attack_power
var max_health = 100
var curr_health = 100

# pathfinding
var path_stack = []
var move_direction = null
var is_jumping = false
var gravity = Vector3.ZERO
var wait_delay = 0



# Called when the node enters the scene tree for the first time.
func _ready():
	_load_stats()
	_load_animator_sprite()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	move_camera()
	camera_rotation()
	rotate_pawn_sprite()
	start_animator()

func config_player(cam : TacticsCamera, grid : GridMap):
	camera = cam
	grid_map = grid
	
	for i in grid.get_used_cells(): #references all gridmap cells
		print(i)

# camera follow / rotation logic
func move_camera():
	var h = -Input.get_action_strength("camera_left")+Input.get_action_strength("camera_right")
	var v = Input.get_action_strength("camera_forward")-Input.get_action_strength("camera_backwards")
	camera.move_camera(h, v, is_joystick)

func camera_rotation():
	if Input.is_action_just_pressed("camera_rotate_left"): camera.y_rot -= 90
	if Input.is_action_just_pressed("camera_rotate_right"): camera.y_rot += 90

func rotate_pawn_sprite():
	var camera_forward = -get_viewport().get_camera_3d().global_transform.basis.z
	var dot = global_transform.basis.z.dot(camera_forward)
	$Character.flip_h = global_transform.basis.x.dot(camera_forward) > 0
	if dot < -0.306: $Character.frame = curr_frame
	elif dot > 0.306: $Character.frame = curr_frame + 1 * ANIMATION_FRAMES

func look_at_direction(dir):
	var fixed_dir = dir*(Vector3(1,0,0) if abs(dir.x) > abs(dir.z) else Vector3(0,0,1))
	var angle = Vector3.FORWARD.signed_angle_to(fixed_dir.normalized(), Vector3.UP)+PI
	set_rotation(Vector3.UP*angle)

func start_animator():
	if move_direction == null : animator.travel("IDLE")
	elif is_jumping: animator.travel("JUMP")

func _load_stats():
	move_radious = Utils.get_pawn_move_radious(pawn_class)
	jump_height = Utils.get_pawn_jump_height(pawn_class)
	attack_radious = Utils.get_pawn_attack_radious(pawn_class)
	attack_power = Utils.get_pawn_attack_power(pawn_class)
	max_health = Utils.get_pawn_health(pawn_class)
	curr_health = max_health


func _load_animator_sprite():
	animator = $Character/AnimationTree.get("parameters/playback")
	animator.start("IDLE")
	$Character/AnimationTree.active = true
	$Character.texture = Utils.get_pawn_sprite(pawn_class)
