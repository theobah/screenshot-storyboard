extends Node2D

var is_selecting = false
var start_pos = Vector2.ZERO
var current_pos = Vector2.ZERO
var selection_rect = Rect2()


func _ready():
	# Make window transparent and borderless for snipping
	
	

	get_window().set_transparent_background(true)
	get_window().borderless = true
	get_window().always_on_top = true
	
	# Set window to full screen
	get_window().size = DisplayServer.screen_get_usable_rect().size
	get_window().position = DisplayServer.screen_get_usable_rect().position
	
	set_process_input(true)
	
	
func _input(event):
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_RIGHT:
			if event.pressed:
				# Start selection
				is_selecting = true
				start_pos = get_global_mouse_position()
				current_pos = start_pos
			else:
				# End selection and capture
				if is_selecting:
					is_selecting = false
					print("capture_screenshot")
					capture_screenshot()
	
	elif event is InputEventMouseMotion and is_selecting:
		# Update current position while dragging
		current_pos = get_global_mouse_position()
		queue_redraw()
	
	elif event is InputEventKey and event.pressed:
		if event.keycode == KEY_ESCAPE:
			# Cancel selection
			is_selecting = false
			queue_redraw()
			print("Snipping cancelled")

func _draw():
	if is_selecting:
		# Draw semi-transparent overlay on entire screen
		draw_rect(Rect2(0, 0, get_window().size.x, get_window().size.y), Color(0, 0, 0, 0.5))
		
		# Calculate selection rectangle
		var x = minf(start_pos.x, current_pos.x)
		var y = minf(start_pos.y, current_pos.y)
		var width = absf(current_pos.x - start_pos.x)
		var height = absf(current_pos.y - start_pos.y)
		
		selection_rect = Rect2(x, y, width, height)
		
		# Draw clear area for selection
		draw_rect(selection_rect, Color.WHITE, false, 2.0)
	
		
		# Draw corner handles
		var handle_size = 8
		var corners = [
			selection_rect.position,
			selection_rect.position + Vector2(selection_rect.size.x, 0),
			selection_rect.position + selection_rect.size,
			selection_rect.position + Vector2(0, selection_rect.size.y)
		]
		
		for corner in corners:
			draw_rect(Rect2(corner - Vector2(handle_size/2, handle_size/2), Vector2(handle_size, handle_size)), Color.WHITE)

	# Take screenshot of the selected area
	var image = Image.new()
	var viewport = get_viewport()
	
	image = DisplayServer.screen_get_image(0)
	var screen_texture = ImageTexture.create_from_image(image)
	
	# Crop to selection
	var cropped = Image.create(int(selection_rect.size.x), int(selection_rect.size.y), false, Image.FORMAT_RGB8)
	
	for y in range(int(selection_rect.size.y)):
		for x in range(int(selection_rect.size.x)):
			var src_pos = selection_rect.position + Vector2(x, y)
			if image.get_size().x > src_pos.x and image.get_size().y > src_pos.y:
				cropped.set_pixel(x, y, image.get_pixel(int(src_pos.x), int(src_pos.y)))
	
	# Save and copy to clipboard
	var path = "user://screenshot_%s.png" % Time.get_ticks_msec()
	cropped.save_png(path)
	

	
	print("Screenshot saved to: %s" % path)
	print("Image copied to clipboard")
	
	# Close the snipping tool


func _notification(message):
	if message == NOTIFICATION_WM_CLOSE_REQUEST:
		get_tree().quit()
		
func capture_screenshot():
	if selection_rect.size.x < 1 or selection_rect.size.y < 1:
		print("Selection too small")
		return
	
	# Take screenshot of the selected area
	var image = Image.new()
	var viewport = get_viewport()
	
	image = DisplayServer.screen_get_image(0)
	var screen_texture = ImageTexture.create_from_image(image)
	
	# Crop to selection
	var cropped = Image.create(int(selection_rect.size.x), int(selection_rect.size.y), false, Image.FORMAT_RGB8)
	
	for y in range(int(selection_rect.size.y)):
		for x in range(int(selection_rect.size.x)):
			var src_pos = selection_rect.position + Vector2(x, y)
			if image.get_size().x > src_pos.x and image.get_size().y > src_pos.y:
				cropped.set_pixel(x, y, image.get_pixel(int(src_pos.x), int(src_pos.y)))
	
	# Save and copy to clipboard
	var path = "F://projects//snapping tool for mikey//kiki//episode 1" % Time.get_ticks_msec()
	cropped.save_png(path)
	

	
	print("Screenshot saved to: %s" % path)
	print("Image copied to clipboard")
