extends Area2D

# Define the size of the grid. This example uses a 64x64 grid.
var grid_size: Vector2 = Vector2(64, 64)

# Define the player's movement speed (how fast it moves from one grid tile to another)
var move_speed: float = 4.0

# Current destination the player is moving towards
var target_position: Vector2

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	# Start with the player's current position snapped to the grid
	target_position = position.snapped(grid_size)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	# Handle player input for grid-based movement
	handle_movement()

	# Move the player towards the target position smoothly
	move_towards_target(delta)

# Function to handle player input and set the target position
func handle_movement() -> void:
	if position == target_position:
		# If the player is at the target position, allow input to set a new target
		if Input.is_action_just_pressed("ui_up"):
			target_position.y -= grid_size.y
		elif Input.is_action_just_pressed("ui_down"):
			target_position.y += grid_size.y
		elif Input.is_action_just_pressed("ui_left"):
			target_position.x -= grid_size.x
		elif Input.is_action_just_pressed("ui_right"):
			target_position.x += grid_size.x

# Function to move the player smoothly towards the target position
func move_towards_target(delta: float) -> void:
	if position != target_position:
		# Move towards the target position at the specified speed
		position = position.move_toward(target_position, move_speed * grid_size.x * delta)
