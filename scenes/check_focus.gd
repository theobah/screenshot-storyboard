extends Button

var style := StyleBoxFlat.new()

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _notification(what):

	if what ==  NOTIFICATION_APPLICATION_FOCUS_OUT:
		self.disabled = false
		self.modulate = Color.RED
		print("Goodbye!")
		self.text = "Click to 
			refocus 
			window"
	elif what == NOTIFICATION_APPLICATION_FOCUS_IN:
		self.disabled = true
		self.modulate = Color.WHITE
		print("hi")
		self.text = "Window in 
		focus"
		
