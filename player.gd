extends CharacterBody3D

# How fast the player moves in meters per second.
@export var speed = 14
# The downward acceleration when in the air, in meters per second squared.
@export var fall_acceleration = 75

#const SPEED = 5.0
#const JUMP_VELOCITY = 4.5

var target_velocity = Vector3.ZERO

# Get the gravity from the project settings to be synced with RigidBody nodes.
#var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")


#like _process, this updates every frame
func _physics_process(delta):
	var direction = Vector3.ZERO
	
	# We check for each move input and update the direction accordingly.
	if Input.is_action_pressed("move_right"):
		direction.x += 1
	if Input.is_action_pressed("move_left"):
		direction.x -= 1
	if Input.is_action_pressed("move_back"):
		# Notice how we are working with the vector's x and z axes.
		# In 3D, the XZ plane is the ground plane!!
		direction.z += 1
	if Input.is_action_pressed("move_forward"):
		direction.z -= 1
	
	#normalize vector only if player is player is pressing a key
	if direction != Vector3.ZERO:
		direction = direction.normalized()
		#look at is a built in method?, takes a global coord too look at and up direction
		#position plus direction give a pos 1 meter away from the character
		$Pivot.look_at(position + direction, Vector3.UP)
	
	# Ground Velocity
	target_velocity.x = direction.x * speed
	target_velocity.z = direction.z * speed
	
	# Vertical Velocity
	# If in the air, fall towards the floor. Literally gravity
	if not is_on_floor():
		target_velocity.y = target_velocity.y - (fall_acceleration * delta)

	# Moving the Character
	velocity = target_velocity
	move_and_slide()
	
	# Add the gravity method from the starter asset or template?
#	if not is_on_floor():
#		velocity.y -= gravity * delta
#
#	# Handle Jump.
#	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
#		velocity.y = JUMP_VELOCITY
#
#	# Get the input direction and handle the movement/deceleration.
#	# As good practice, you should replace UI actions with custom gameplay actions.
#	var input_dir = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
#	#var direction = (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
#	if direction:
#		velocity.x = direction.x * SPEED
#		velocity.z = direction.z * SPEED
#	else:
#		velocity.x = move_toward(velocity.x, 0, SPEED)
#		velocity.z = move_toward(velocity.z, 0, SPEED)
