extends CharacterBody3D


const SPEED = 5.0
const JUMP_VELOCITY = 4.5
@export var mouseSens : int = 1
var mainCamera : Camera3D
var cameraDirection : Node3D
var interactionRay : RayCast3D
var interactionUI : Label

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")


func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	mainCamera = $"Pixelated Camera"
	interactionRay = $Node3D/RayCast3D
	interactionUI = $"../UI/INTERACT"
	cameraDirection = $Node3D
	
func _process(delta):
	
	mainCamera.global_transform = cameraDirection.global_transform
	interactionUI.visible = interactionRay.is_colliding()
	if(Input.is_action_just_pressed("Interact") && interactionRay.is_colliding()):
		interactionRay.get_collider()._interact()
	
	pass
	
	
	
func _physics_process(delta):
	
	# Add the gravity.
	if not is_on_floor():
		velocity.y -= gravity * delta

	# Handle Jump.
	if Input.is_action_just_pressed("Jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY
		


	# Get the input direction and handle the movement/deceleration.
	var input_dir = Input.get_vector("MoveLeft", "MoveRight", "MoveForward", "MoveBack")
	var direction = (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	if direction:
		velocity.x = direction.x * SPEED
		velocity.z = direction.z * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		velocity.z = move_toward(velocity.z, 0, SPEED)
	
	move_and_slide()

func _input(event):
	if event is InputEventMouseMotion and Input.get_mouse_mode() == Input.MOUSE_MODE_CAPTURED:
		var mouseMovement = event.relative * mouseSens/100
		rotation.y -= mouseMovement.x
		mouseMovement.y = clamp(mainCamera.global_rotation.x + mouseMovement.y, deg_to_rad(-70), deg_to_rad(80)) - mainCamera.global_rotation.x;
		cameraDirection.rotate_x(mouseMovement.y)

