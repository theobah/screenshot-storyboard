extends Node2D

var interactive_polygon = PackedVector2Array([
		Vector2(0, 0),
		Vector2(720, 0),
		Vector2(720, 300),
		Vector2(0, 300)
	])
var is_taking_screenshot = false

var file_path = ""
var cut_range = ""
var episode_number = ""

var cut_folder_toggle : bool = 0
var cut_range_toggle : bool = 0
var from_last_toggle : bool = 0
var cut_list = []
var cut_range_list = []

var cut = 1
var panel = 1
var cut_number = 0

var is_selecting = false
var start_pos = Vector2.ZERO
var current_pos = Vector2.ZERO
var selec_rec = Rect2()

var toggle_bk_draw = false
var screenshot_assist = false
var default_size_on = false
var default_size_configure = false
var lock_aspect_ratio = false
var hide_hud = false
var lock_snip_size = false
var is_hovering_ui = false

var ui_area = CollisionObject2D
var aspect_ratio = Vector2i(16,9)
var default_size = Vector2.ZERO

var save_setting_path = "user://settings.save"

func _ready():
	
	$UI_top_corner/screenshot_assist.hide()
	_on_aspect_ratio_text_changed("16:9")
	DisplayServer.window_set_mouse_passthrough(interactive_polygon)
	
	get_window().set_transparent_background(true)
	get_window().borderless = true
	get_window().always_on_top = true
	
	get_window().size = DisplayServer.screen_get_usable_rect().size
	get_window().position = DisplayServer.screen_get_usable_rect().position
	
	set_process_input(true)
	_load()
	if cut_range_toggle and not from_last_toggle:
		cut = cut_list[0]
		_update_UI()
	
func _screenshot_mode():
	toggle_bk_draw = true

	if is_taking_screenshot == false:
		is_taking_screenshot = true
		queue_redraw()
	else:
		is_taking_screenshot = false
		queue_redraw()

func _input(event):
	
	if get_global_mouse_position().x < 600 and get_global_mouse_position().y < 200:
		is_hovering_ui = true
	else:
		is_hovering_ui = false
		
	if event is InputEventMouseButton and not is_hovering_ui:
		if event.button_index == MOUSE_BUTTON_LEFT:
			if event.pressed:
				is_selecting = true
				start_pos = get_global_mouse_position()
				current_pos = get_global_mouse_position()
				queue_redraw()
			else:
				if is_selecting and default_size_configure:
					is_selecting = false
					queue_redraw()
					
					default_size_configure = false
					is_taking_screenshot = false
					
					
				else:
					hide_hud = true
					queue_redraw()
					print("hide_hud")
					is_selecting = false
					await get_tree().create_timer(0.2).timeout
					
					capture_screenshot()
					
					_update_UI()
					hide_hud = false
					
					queue_redraw()
		elif event.button_index == MOUSE_BUTTON_RIGHT:
			if event.pressed:
				if is_selecting == true:
					is_selecting = false
					queue_redraw()
				
	elif event is InputEventMouseMotion and is_selecting:
		current_pos = get_global_mouse_position()
		queue_redraw()
				
	if event.is_action_pressed("screenshot_mode"):
		_screenshot_mode()
		
	elif event.is_action_pressed("cut_num_up") and int(cut_number)+1 < int(cut_list.size()):
		_save("cut", cut)
		cut_number +=1
		cut = cut_list[cut_number]
		panel =1
		_update_UI()
	elif event.is_action_pressed("cut_num_down") and cut_number >0:
		_save("cut", cut)
		cut_number -=1
		cut = cut_list[cut_number]
		panel =1
		_update_UI()
	elif event.is_action_pressed("panel_num_up"):
		_save("panel", panel)
		panel+=1
		_update_UI()
	elif event.is_action_pressed("panel_num_down") and panel >1:
		_save("panel", panel)
		panel-=1
		_update_UI()
	elif event is InputEventKey and event.pressed:
		if event.keycode == KEY_ESCAPE:
			#get_tree().quit()
			get_tree().change_scene_to_file("res://scenes/ui.tscn")
	

func _draw():
	var size = get_viewport().size
	if is_taking_screenshot and not hide_hud:
		draw_rect(Rect2(0, 0, get_window().size.x, get_window().size.y), Color(0, 0, 0, 0.5))
	else:
		draw_rect(Rect2(0, 0, get_window().size.x, get_window().size.y), Color(0, 0, 0, 0))
	if is_taking_screenshot and toggle_bk_draw:

		_pack_vectors(0,size.x,0,size.y)
		toggle_bk_draw = false
	elif toggle_bk_draw:
		draw_rect(Rect2(0, 0, get_window().size.x, get_window().size.y), Color(0, 0, 0, 0))
		_pack_vectors(0,720,0,600)
		toggle_bk_draw = false
	
	if is_selecting and is_taking_screenshot:
		
		var aspect = float(aspect_ratio.x / aspect_ratio.y)
		
		if screenshot_assist and default_size_on and not default_size_configure and lock_snip_size:
			
			var x = current_pos.x
			var y =  current_pos.y
			var width = default_size.x
			var height = default_size.y
		
			selec_rec = Rect2(x,y,width,height)
		
		elif is_selecting and default_size_configure:
			
			var x = minf(start_pos.x, current_pos.x)
			var y = minf(start_pos.y, current_pos.y)
			var width = absf(current_pos.x - start_pos.x)
			var height = absf(current_pos.y - start_pos.y)
			print("config")
			if lock_aspect_ratio and screenshot_assist:
				selec_rec = Rect2(x,y,width,width / aspect)
				default_size.x = width
				default_size.y = width / aspect
			else:
				selec_rec = Rect2(x,y,width,height)
				default_size.x = width
				default_size.y = height
			
			
		else:
			var x = minf(start_pos.x, current_pos.x)
			var y = minf(start_pos.y, current_pos.y)
			var width = absf(current_pos.x - start_pos.x)
			var height = absf(current_pos.y - start_pos.y)
			
			if lock_aspect_ratio and screenshot_assist:
				selec_rec = Rect2(x,y,width,width / aspect)
			
			else:
				selec_rec = Rect2(x,y,width,height)
		
		if not hide_hud:
			draw_rect(selec_rec, Color.WHITE, false, 2.0)
		
		var handle_size = 8
		var corners = [
			selec_rec.position,
			selec_rec.position + Vector2(selec_rec.size.x, 0),
			selec_rec.position + selec_rec.size,
			selec_rec.position + Vector2(0, selec_rec.size.y)
		]
	
		for corner in corners:
			if not hide_hud:
				draw_rect(Rect2(corner - Vector2(handle_size/2, handle_size/2), Vector2(handle_size, handle_size)), Color.WHITE)
			
func _pack_vectors(x,x1,y,y1):
	interactive_polygon = PackedVector2Array([
		Vector2(x, y),
		Vector2(x1, y),
		Vector2(x1, y1),
		Vector2(x, y1)
		])
	DisplayServer.window_set_mouse_passthrough(interactive_polygon)

func _on_screenshot_assist_toggled(toggled_on: bool) -> void:
	screenshot_assist = toggled_on
	if screenshot_assist:
		$UI_top_corner/screenshot_assist.show()
	else:
		$UI_top_corner/screenshot_assist.hide()

func _on_aspect_ratio_text_changed(new_text: String) -> void:

	var ratio = new_text

	var parts = ratio.split(":")
	if parts.size() == 2:
		aspect_ratio = Vector2(float(parts[0]), float(parts[1]))

func _configure_default_size():
	default_size_configure = true
	queue_redraw()
	pass

func _on_configure_screenshot_pressed() -> void:
	_configure_default_size()
	if default_size_on:
		default_size_on = false
	if not default_size_on:
		default_size_on = true
	if is_taking_screenshot == false:
		_screenshot_mode()

func _on_lock_aspect_ratio_toggled(toggled_on: bool) -> void:
	lock_aspect_ratio = toggled_on
	
func _on_lock_snip_size_toggled(toggled_on: bool) -> void:
	lock_snip_size = toggled_on
	
func capture_screenshot():

	if selec_rec.size.x < 1 or selec_rec.size.y < 1:
		print("Selection too small")
		return

	
	# Take screenshot of the selected area
	panel +=1
	var image = DisplayServer.screen_get_image(0)

	var crop_rect = Rect2i(
		Vector2i(selec_rec.position),
		Vector2i(selec_rec.size)
	)

	var cropped = Image.create(
		crop_rect.size.x,
		crop_rect.size.y,
		false,
		image.get_format()
	)

	cropped.blit_rect(
		image,
		crop_rect,
		Vector2i.ZERO
	)
	var path = ""
	if cut_folder_toggle:
		path = file_path + "/" + "c" +  str(_calculate_cut_range()) + "/%s.png" % _name_capture()
	else:
		path = file_path + "c" + "/%s.png" % _name_capture()
	cropped.save_png(path)
	

	$UI_top_corner/labels/print_menu.text = "Screenshot saved to: %s" % path
	print("Screenshot saved to: %s" % path)


var settings_dic = {}

func _load():
	if FileAccess.file_exists(save_setting_path):
		var file = FileAccess.open(save_setting_path, FileAccess.READ)
		settings_dic = file.get_var()
		print(settings_dic)
		#_update_variables()
		file_path = settings_dic.get("file_path")
		cut_range = settings_dic.get("cut_range")
		episode_number = settings_dic.get("episode_number")
		cut_folder_toggle = settings_dic.get("cut_folder_toggle")
		cut_range_toggle =  settings_dic.get("cut_range_toggle")
		from_last_toggle = settings_dic.get("from_last_toggle")
		
		if cut_range_toggle:
			cut_list = settings_dic.get("cut_list")
			cut_range_list = settings_dic.get("cut_range_list")
		else: 
			cut_list = range(1,5000)
			
		if from_last_toggle and settings_dic.has("cut") and settings_dic.has("panel"):
			cut = int(settings_dic.get("cut"))
			print(cut)
			cut_number = int(cut_list.find(cut))
			panel = settings_dic.get("panel")
			print("loaded last cut")
			
		file.close()
		_update_UI()
	else:
		print("no data saved")

func _save(setting_name, save_file):
	var file = FileAccess.open(save_setting_path, FileAccess.WRITE)
	settings_dic[str(setting_name)] = save_file
	file.store_var(settings_dic)
	print(settings_dic)
	file.close()
	
func _name_capture():
	return str(episode_number).pad_zeros(2) +  "_" + str(cut).pad_zeros(3) + "-" + str(panel)

func _update_UI():
	$UI_top_corner/interactable/EpisodeInput.text = str(episode_number)
	$UI_top_corner/interactable/CutInput.text = str(cut)
	$UI_top_corner/interactable/PanelInput.text = str(panel)

func _calculate_cut_range():
	var count = 0

	for i in cut_range_list:
		print(i)
		if i.size() == 2:
			
			if i[0] <= cut and i[1] >= cut:
				print("in range")
				return  str(i[0]).pad_zeros(3) + "-" + str(i[1]).pad_zeros(3)
			else:
				
				count +=1
		else:
			if i[0] == cut:
				return  str(cut_range_list[count][0]).pad_zeros(3)


func _on_panel_input_text_changed(new_text: String) -> void:
	episode_number = new_text


func _on_cut_input_text_changed(new_text: String) -> void:
	cut = int(new_text)
	_save("cut", cut)
	cut_number = int(cut_list.find(cut))

func _on_episode_input_text_changed(new_text: String) -> void:
	panel = int(new_text)
	_save("panel", panel)



	
