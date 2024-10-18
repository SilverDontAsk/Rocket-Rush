extends RigidBody2D

var speed: float = 50.0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var obs_types = $AnimatedSprite2D.sprite_frames.get_animation_names()
	$AnimatedSprite2D.play(obs_types[randi() % obs_types.size()])


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	position.x += speed * delta
	if position.x > get_viewport().size.x:
		position.x = -$AnimatedSprite2D.texture.get_size().x


func _on_visible_on_screen_notifier_2d_screen_exited() -> void:
	queue_free()
