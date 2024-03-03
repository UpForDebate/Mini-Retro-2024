extends Label

@export var interval = 0.5

var time = 0.0
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	time += delta
	
	if time > interval:
		self.visible = !self.visible
		time = 0.0
