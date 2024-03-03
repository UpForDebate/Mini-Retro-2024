extends Node3D

var money : float #fisheuros
var moneyUpdateTime = 0.5 #in Seconds
var timeSinceUpdate = 0.0

var holeFill : int #secret
var fisherCount : int
var fisherMoneyPerSec = 1
var priceForNext = 2
var moneyLabel : Label



# Called when the node enters the scene tree for the first time.
func _ready():
	moneyLabel = $UI/money
	fisherCount = 1
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	timeSinceUpdate += delta
	if (timeSinceUpdate>=moneyUpdateTime):
		incrementMoney(timeSinceUpdate)
		timeSinceUpdate = 0
	moneyLabel.text = str(round(money))
	pass


func addFisher():
	fisherCount+=1
	pass
	
func incrementMoney(delta : float):
	money += delta * fisherMoneyPerSec * fisherCount
	
	pass
