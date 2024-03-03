extends Node3D

var fishPlacementArray : Array


func _ready():
	for i in range (25):
		var fisherPlacementAngle = 45/4*i
		var placementDist = 9.3 * sin(deg_to_rad(67.5))/sin(deg_to_rad( 112.5-fisherPlacementAngle%45))
		var newNode = Node3D.new()
		add_child(newNode)
		newNode.global_position = global_position + global_basis.x*cos(deg_to_rad( fisherPlacementAngle))*placementDist + global_basis.z*sin(deg_to_rad( fisherPlacementAngle))*placementDist
		newNode.rotate_y(-deg_to_rad(fisherPlacementAngle+90))
		newNode.set_meta("fisherCount", 0)
		fishPlacementArray.append(newNode)
	
	pass



func addFisher():
	$"..".fisherCount+=1
	var fisherCount = $"..".fisherCount
	var layer :int = fisherCount / 25
	

	
	while(true):
		var placement = fishPlacementArray[randi_range(0, 24)]
		if (placement.get_meta("fisherCount")< layer+1):
			placeFisher (placement, layer)
			return
	
	
	pass


func placeFisher(nodeParent : Node3D, layer: int):
	var newNode = preload("res://Scenes/Fisher.gltf").instantiate()
	newNode.position.y +=0.3*layer
	nodeParent.add_child(newNode)
	nodeParent.set_meta ("fisherCount", nodeParent.get_meta("fisherCount")+1)
