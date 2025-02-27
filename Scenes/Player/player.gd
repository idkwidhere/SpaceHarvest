extends CharacterBody3D
class_name Player

var speed = 5.0
var WALK_SPEED = 5.0
var SPRINT_SPEED = 7.0
const JUMP_VELOCITY = 4.5
@export var sensitivity = 0.003


@onready var head: Node3D = $Head
@onready var player_camera: Camera3D = $Head/PlayerCamera

# head bob shit
@export var bob_freq = 2.0
@export var bob_amp = 0.01
var t_bob = 0.0

# fov shit
var base_fov = 75
const FOV_SHIFT = 1.5

# menu shit
var player_menu_is_open = false
var main_menu_is_open = false
@onready var ui: Control = $Menus/UI
@onready var game_menu: Control = $Menus/GameMenu





func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	print("working")


func _unhandled_input(event: InputEvent) -> void:
	if event is InputEventMouseMotion:
		head.rotate_y(-event.relative.x * sensitivity)
		player_camera.rotate_x(-event.relative.y * sensitivity)
		player_camera.rotation.x = clamp(player_camera.rotation.x, deg_to_rad(-90), deg_to_rad(80))

func _input(event: InputEvent) -> void:
	pass
		
		

func _process(delta: float) -> void:
	if Input.is_action_just_pressed("menu") and !player_menu_is_open:
		game_menu.show()
		player_menu_is_open = true
		print("shown")
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	elif Input.is_action_just_pressed("menu") and player_menu_is_open:
		game_menu.hide()
		player_menu_is_open = false
		print("hidden")
		Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)


func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Handle jump.
	if Input.is_action_just_pressed("space") and is_on_floor():
		velocity.y = JUMP_VELOCITY
	
	# Handle sprint
	if Input.is_action_pressed("modifier"):
		speed = SPRINT_SPEED
	else:
		speed = WALK_SPEED

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var input_dir := Input.get_vector("left", "right", "up", "down")
	var direction := (head.transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	
	if is_on_floor():
		if direction:
			velocity.x = direction.x * speed
			velocity.z = direction.z * speed
		else:
			velocity.x = lerp(velocity.x, direction.x, delta * 8.0)
			velocity.z = lerp(velocity.z, direction.z, delta * 8.0)
	else:
		velocity.x = lerp(velocity.x, direction.x, delta * 2.0)
		velocity.z = lerp(velocity.z, direction.z, delta * 2.0)
		
	# head bob
	t_bob += delta * velocity.length() * float(is_on_floor())
	player_camera.transform.origin = _headbob(t_bob)
	
	# fov
	var velocity_clamped = clamp(velocity.length(), 0.5, SPRINT_SPEED * 2)
	var target_fov = base_fov + FOV_SHIFT * velocity_clamped
	player_camera.fov = lerp(player_camera.fov, target_fov, delta * 8.0)
	


	move_and_slide()



func _headbob(time) -> Vector3:
	var pos = Vector3.ZERO
	pos.y = sin(time * bob_freq) * bob_amp
	return pos
