extends Node3D

var node3d = preload("res://Scenes/node_3d.tscn")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_key_pressed(KEY_F):
		get_parent().add_child(node3d.instantiate())
		get_parent().remove_child(self)
	
	if Input.is_key_pressed(KEY_ESCAPE):
		get_tree().quit()
