extends RigidBody2D

var speed: float = 50.0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var obs_types = $AnimatedSprite2D.sprite_frames.get_animation_names()
	$AnimatedSprite2D.play(obs_types[randi() % obs_types.size()])


func _on_visible_on_screen_notifier_2d_screen_exited() -> void:
	queue_free()
