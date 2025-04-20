extends RigidBody3D

var impulse_strength = 10.0
var has_started = false

func _ready():
	gravity_scale = 0.0  # Kill gravity for space movement

func _physics_process(delta):
	if not has_started:
		var forward = -transform.basis.z
		print("Applying impulse in direction: ", forward)
		apply_impulse(Vector3.ZERO, forward * impulse_strength)
		has_started = true
