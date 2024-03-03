extends StaticBody3D

@onready var priceText : Label = $"../UI/INTERACT"
# Called when the node enters the scene tree for the first time.
func _ready():
	priceText.text = "PRICE: " + str(round($"..".priceForNext))
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	
	pass



func _interact():
	if($"..".money>$"..".priceForNext):
		$"..".money-=$"..".priceForNext
		$"..".priceForNext*=1.1
		$"../FisherArray".addFisher()
	priceText.text = "PRICE: " + str(round($"..".priceForNext))
	
	pass
