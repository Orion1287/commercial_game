extends CharacterBody3D

##MOVEMENT##
const SPEED = 5.0
const JUMPVELOCITY = 4
const MOUSESENS = 0.002

var pitch = 0.0


var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")

@onready var camera_pivot = $CameraPivot
func _ready() -> void:
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)

func _unhandled_input(event: InputEvent) -> void:
	if event is InputEventMouseMotion:

		rotate_y(-event.relative.x * MOUSESENS)
		pitch -= event.relative.y * MOUSESENS
		pitch = clamp(pitch, deg_to_rad(-80), deg_to_rad(80))
		camera_pivot.rotation.x = pitch

func _physics_process(delta: float):
	var direction = Vector3.ZERO
	if Input.is_action_pressed("move_forward"):
		direction -= transform.basis.z
	if Input.is_action_pressed("move_back"):
		direction += transform.basis.z
	if Input.is_action_pressed("move_left"):
		direction -= transform.basis.x
	if Input.is_action_pressed("move_right"):
		direction += transform.basis.x

	direction = direction.normalized()

	velocity.x = direction.x * SPEED
	velocity.z = direction.z * SPEED
	if not is_on_floor():
		velocity.y -= gravity * delta
	elif Input.is_action_pressed("jump"):
		velocity.y = JUMPVELOCITY

	move_and_slide()
