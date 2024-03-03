extends Node3D

@export var line : Node3D
@export var points : Array
var pointsNodes : Array

# Called when the node enters the scene tree for the first time.
func _ready():
	for point in points:
		pointsNodes.append(get_node(point))
	line.points.resize(points.size())
	
	
	
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	for i in range(pointsNodes.size()):
		line.points[i] = pointsNodes[i].global_position

	pass
