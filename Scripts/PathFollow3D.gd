extends PathFollow3D

@export var SPEED = 5

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	progress += delta * SPEED
