extends Area3D


# Called when the node enters the scene tree for the first time.
func _ready():
	connect("body_entered", _fish_bobber)
	pass # Replace with function body.

func _fish_bobber(body : Node3D):
	if(body.name == "Bobber" && !body.get_meta("hasFish")):
		var newNode = preload("res://model/BlowFish.gltf").instantiate()
		body.add_child(newNode)
		newNode.name = "BlowFish"
		body.set_meta("hasFish", true)
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
