extends CharacterBody3D


const SPEED = 5.0
const JUMP_VELOCITY = 4.5
@export var mouseSens : int = 1
var mainCamera : Camera3D
var cameraDirection : Node3D
var interactionRay : RayCast3D
var interactionUI : Label
@onready var danglingRope : Node3D =  $"../DanglingRope"
@onready var throwBobber : RigidBody3D = $"../Bobber"

enum state {
	rodInHand = 0,
	fishing = 1,
	pulling = 2,
} 
var gameState : state = state.rodInHand


# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")


func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	mainCamera = $"Pixelated Camera"
	interactionRay = $Node3D/RayCast3D
	interactionUI = $"../UI/INTERACT"
	cameraDirection = $Node3D
	
	
func _process(delta):
	if Input.is_key_pressed(KEY_ESCAPE):
		get_tree().quit()
	
	mainCamera.global_transform = cameraDirection.global_transform
	interactionUI.visible = interactionRay.is_colliding()
	if(Input.is_action_just_pressed("Interact") && interactionRay.is_colliding()):
		interactionRay.get_collider()._interact()
	if(Input.is_action_just_pressed("Shoot")):
		shoot()
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
	
	
	if (gameState==state.pulling):
		if((global_position - throwBobber.global_position).length() < 1.2):
			$"../DanglingRope"/RigidBody3D/PinJoint3D/RigidBody3D/PinJoint3D/RigidBody3D/PinJoint3D/Bobber.global_transform = throwBobber.global_transform
			$"../DanglingRope"/RigidBody3D/PinJoint3D/RigidBody3D/PinJoint3D/RigidBody3D/PinJoint3D/Bobber.linear_velocity = throwBobber.linear_velocity
			danglingRope.visible = true
			throwBobber.visible = false
			gameState = state.rodInHand
			if(throwBobber.get_meta("hasFish")):
				$"..".money+=1
				#var fish =throwBobber.find_child("BlowFish")
				var fish = throwBobber.get_child(3)
				throwBobber.remove_child(fish)
				fish.queue_free()
				throwBobber.set_meta("hasFish", false)
		throwBobber.linear_velocity =  (global_position + Vector3.UP*0.5 - throwBobber.global_position).normalized()*10
		throwBobber.position += global_position + Vector3.UP*0.5 - throwBobber.global_position
		
	
	
	
	move_and_slide()

func _input(event):
	if event is InputEventMouseMotion and Input.get_mouse_mode() == Input.MOUSE_MODE_CAPTURED:
		var mouseMovement = event.relative * mouseSens/100
		rotation.y -= mouseMovement.x
		mouseMovement.y = clamp(mainCamera.global_rotation.x + mouseMovement.y, deg_to_rad(-70), deg_to_rad(80)) - mainCamera.global_rotation.x;
		cameraDirection.rotate_x(mouseMovement.y)

func shoot():
	if(gameState == state.rodInHand):
		danglingRope.visible = false
		throwBobber.visible = true
		throwBobber.position = position + Vector3.UP *0.7 + Vector3.BACK + Vector3.RIGHT
		throwBobber.linear_velocity = -global_basis.z * 10 + global_basis.y*2;
		gameState = state.fishing
		$"Fish Fetcher/Fetcher/AnimationPlayer".play("Fetcher_Throw")
		return
	gameState = state.pulling


	$"Fish Fetcher/Fetcher/AnimationPlayer".play("Fetcher_Catch")
