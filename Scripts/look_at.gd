extends Camera3D

@export var target : Node3D


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	look_at(target.position)