extends Node2D

var screen_width: int

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	screen_width = get_viewport().size.x


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	for obstacle in get_children():
		if obstacle.name.begins_with("obs"):
			obstacle.position.x += obstacle.speed * delta
			if obstacle.position.x > screen_width:
				obstacle.position.x = -obstacle.texture.get_size().x
