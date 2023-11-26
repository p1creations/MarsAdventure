extends CharacterBody2D


@export var speed : float = 150.0
@export var jump_velocity : float = -175.0
@export var double_jump_velocity : float = -150

@onready var animated_sprite : AnimatedSprite2D = $AnimatedSprite2D

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var has_double_jumped : bool = false
var direction : Vector2 = Vector2.ZERO
var was_in_air : bool = false


func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta
	else:
		has_double_jumped = false
		
	was_in_air = false

	# Handle Jump.
	if Input.is_action_just_pressed("jump"):
		if is_on_floor():
			# Normal jump from floor
			jump()
		elif not has_double_jumped:
			# Double jump in air
			double_jump()

	# Get the input direction and handle the movement/deceleration.
	direction = Input.get_vector("left", "right", "up", "down")
	
	if direction.x != 0:
		velocity.x = direction.x * speed
	else:
		velocity.x = move_toward(velocity.x, 0, speed)

	move_and_slide()
	update_animation()
	update_facing_direction()
	
	
func update_animation():
	if not has_double_jumped:
		if not is_on_floor():
			animated_sprite.play("jumploop")
		else:
			if direction.x != 0:
				animated_sprite.play("run")
			else:
				animated_sprite.play("idle")
			

#handle facing direction
func update_facing_direction():
	if direction.x > 0:
		animated_sprite.flip_h = false
	elif direction.x < 0:
		animated_sprite.flip_h = true
		
#handle jumping
func jump():
	velocity.y = jump_velocity
	animated_sprite.play("jump")
	
#handle double jump
func double_jump():
	velocity.y = double_jump_velocity
	animated_sprite.play("doublejump")
	has_double_jumped = true
	
	

