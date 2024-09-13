extends CharacterBody3D


const SPEED = 15.0
const JUMP_VELOCITY = 4.5
const MOUSE_SENS = 0.01
const MIN_CAMERA_ANG = -90
const MAX_CAMERA_ANG = 90

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")
@onready var viewport := $Viewport
@onready var camera := $Viewport/Camera3D

func _unhandled_input(event):
	if event is InputEventMouseButton:  # if an event is a mouse button pressed
		Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)  # start capturing mouse
	elif event.is_action_pressed("ui_cancel"):
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)  # free the mouse from traking
	if Input.get_mouse_mode() == Input.MOUSE_MODE_CAPTURED:
		if event is InputEventMouseMotion:
			viewport.rotate_y(-event.relative.x * MOUSE_SENS)
			camera.rotate_x(-event.relative.y * MOUSE_SENS)
			camera.rotation.x = clamp(camera.rotation.x, deg_to_rad(MIN_CAMERA_ANG), deg_to_rad(MAX_CAMERA_ANG))

func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y -= gravity * delta

	# Handle jump.
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var input_dir = Input.get_vector("left", "right", "forward", "back")
	var direction = (viewport.transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	if direction:
		velocity.x = direction.x * SPEED
		velocity.z = direction.z * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		velocity.z = move_toward(velocity.z, 0, SPEED)

	move_and_slide()
