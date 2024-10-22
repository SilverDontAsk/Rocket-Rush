extends Area2D
signal hit

@onready var animations : AnimatedSprite2D = $AnimatedSprite2D
@onready var ray_up : RayCast2D = $Raycast/up
@onready var ray_down : RayCast2D = $Raycast/down
@onready var ray_left : RayCast2D = $Raycast/left
@onready var ray_rigt : RayCast2D = $Raycast/right
const PIXELS : int = 15
var tween : Tween

func _ready():
	pass 

func _process(delta):
	var direction = Input.get_vector("move_left", "move_right", "move_up", "move_down")
	
	if direction:
		move_me(direction)
		
		
func move_me(direction):
	
	var next_position : Vector2
	
	if direction.x < 0 && !ray_left.is_colliding():
		next_position = position + Vector2(-PIXELS, 0)
		animations.play("Spaceship_flying")
		move_by_tween(next_position)
		#left
	elif direction.x > 0 && !ray_down.is_colliding():
		next_position = position + Vector2(PIXELS, 0)
		animations.play("Spaceship_flying")
		move_by_tween(next_position)
		#right
	elif direction.y < 0 && !ray_up.is_colliding():
		next_position = position + Vector2(0, -PIXELS)
		animations.play("Spaceship_flying")
		move_by_tween(next_position)
		#up
	elif direction.y > 0 && !ray_down.is_colliding():
		next_position = position + Vector2(0, PIXELS)
		animations.play("Spaceship_flying")
		move_by_tween(next_position)
		#down
		
func move_by_tween(next_position : Vector2):
	tween = create_tween()
	tween.tween_property(self, "position", next_position, 0.2)
	tween.tween_callback(end_of_tween)
	
func end_of_tween():
	animations.play("Spaceship_flying")


func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("obstacle"):
		hide()
		hit.emit()
		$CollisionShape2D.set_deferred("disabled", true)
	elif body.is_in_group("Border"):
		pass
