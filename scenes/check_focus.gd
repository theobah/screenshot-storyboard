extends Button

var style := StyleBoxFlat.new()

var lang: String

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	await get_tree().create_timer(0.1).timeout
	lang = $"../../..".lang
	print("lang is the" + lang)
	if lang == "en":
		self.text = "Window in 
		focus"
	else:
		self.text = "ウィンドウに
		フォーカス中"
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _notification(what):
	if what ==  NOTIFICATION_APPLICATION_FOCUS_OUT:
		self.disabled = false
		self.modulate = Color.RED
		print("Goodbye!")
		if lang == "en":
			self.text = "Click to 
				refocus 
				window"
		
		else:
			self.text = "クリックして
			ウィンドウに
			フォーカス"
	elif what == NOTIFICATION_APPLICATION_FOCUS_IN:
		self.disabled = true
		self.modulate = Color.WHITE
		print("hi")
		if lang == "en":
			self.text = "Window in 
			focus"
		else:
			self.text = "ウィンドウに
			フォーカス中"
		
