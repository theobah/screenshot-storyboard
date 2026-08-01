extends CanvasLayer

var save_setting_path = "user://settings.save"

var file_path = ""
var cut_range = ""
var episode_number = ""

var cut_folder_toggle : bool = 0
var cut_range_toggle : bool = 0
var from_last_toggle : bool = 0
var cut_range_list = []

var authenticated = false
var settings_dic: Dictionary = {}
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	
	if FileAccess.file_exists(save_setting_path):
		_load()
	else:
		_save("all", "all")
	
	get_window().set_transparent_background(false)
	get_window().borderless = false
	get_window().always_on_top = true
	DisplayServer.window_set_mouse_passthrough([])
	var default_size = Vector2i(
	ProjectSettings.get_setting("display/window/size/viewport_width"),
	ProjectSettings.get_setting("display/window/size/viewport_height")
)
	get_window().size = default_size
	print(default_size)
	var window = get_window()
	var screen = DisplayServer.screen_get_usable_rect()
	get_window().position = screen.position + (screen.size - window.size) / 2
	
	set_process_input(true)
	
	

func _on_file_path_text_changed() -> void:
	file_path = $interactable/Text/FilePath.get_text()
	_save("file_path", file_path)

func _on_cut_range_text_changed() -> void:
	cut_range = $interactable/Text/CutRange.get_text()
	cut_range.replace(" ", "")
	_save("cut_range", cut_range)
	


func _on_episode_number_text_changed() -> void:
	episode_number = int($interactable/Text/EpisodeNumber.get_text())
	_save("episode_number", episode_number)
	
func _on_cut_folder_toggle_toggled(toggled_on: bool) -> void:
	cut_folder_toggle = toggled_on
	_save("cut_folder_toggle", cut_folder_toggle)




func _on_cut_range_toggle_toggled(toggled_on: bool) -> void:
	cut_range_toggle = toggled_on
	if cut_range_toggle == false:
		$interactable/Text/CutRange.editable = false
	else:
		$interactable/Text/CutRange.editable = true
	_save("cut_range_toggle", cut_range_toggle)

func _on_from_last_toggle_toggled(toggled_on: bool) -> void:
	from_last_toggle = toggled_on
	_save("from_last_toggle", from_last_toggle)

func _on_clear_settings_pressed() -> void:
	file_path = ""
	cut_range = ""
	episode_number = ""
	cut_folder_toggle = false
	cut_range_toggle = false
	from_last_toggle = false
	_save("all", "all")
	_load()
	print("loaded from file")
	
func _save(setting_name, save_file):
	var file = FileAccess.open(save_setting_path, FileAccess.WRITE)

	

	if setting_name == "all":
		
		settings_dic["file_path"] = file_path
		settings_dic["episode_number"] = episode_number
		cut_range.replace(" ", "")
		settings_dic["cut_range"] = cut_range
		
		settings_dic["cut_folder_toggle"] = cut_folder_toggle
		settings_dic["cut_range_toggle"] = cut_range_toggle
		settings_dic["from_last_toggle"] = from_last_toggle
		
	
	else:
		settings_dic[str(setting_name)] = save_file
	
		
	file.store_var(settings_dic)
	file.close()

func _load():
	if FileAccess.file_exists(save_setting_path):
		var file = FileAccess.open(save_setting_path, FileAccess.READ)
		settings_dic = file.get_var()
		print("loaded" + str(settings_dic))
		#_update_variables()
		$interactable/Text/FilePath.text = settings_dic.get("file_path")
		$interactable/Text/CutRange.text = settings_dic.get("cut_range")
		$interactable/Text/EpisodeNumber.text = str(settings_dic.get("episode_number"))
		$interactable/Checkbox/CutFolderToggle.button_pressed = settings_dic.get("cut_folder_toggle")
		$interactable/Checkbox/CutRangeToggle.button_pressed =  settings_dic.get("cut_range_toggle")
		$interactable/Checkbox/FromLastToggle.button_pressed = settings_dic.get("from_last_toggle")
		file_path = settings_dic.get("file_path")
		cut_range = settings_dic.get("cut_range")
		episode_number = settings_dic.get("episode_number")
		cut_folder_toggle = settings_dic.get("cut_folder_toggle")
		cut_range_toggle = settings_dic.get("cut_range_toggle")
		from_last_toggle = settings_dic.get("from_last_toggle")
		file.close()
	else:
		print("no data saved")
		
func _on_start_pressed() -> void:
	
	#DirAccess.make_dir_recursive_absolute(file_path)
	_process_cuts()
	
	
	authenticated = true
	if authenticated == true:
		get_tree().change_scene_to_file("res://scenes/Screenshot.tscn")
		
		
		
var cut_list = []
func _process_cuts():
	
	
	
	var cut_range = cut_range.split(",")
	cut_list = []
	for part in cut_range:
		var dir = DirAccess.open(file_path)
		part.strip_edges()
		if "-" in part:
			var range= part.split("-")
			if cut_folder_toggle:
				cut_range_list.append([int(range[0]),int(range[1])])
				_save("cut_range_list", cut_range_list)
				dir.make_dir("c" + str(int(range[0])).pad_zeros(3) + "-" +str(int(range[1])).pad_zeros(3))
				print("made directories")
				
			for i in range(int(range[0]), int(range[1]) +1  ):
				if i not in cut_list:
					cut_list.append(i)
				
		else:
			dir.make_dir("c" + str(int(part)).pad_zeros(3))
			if int(part) not in cut_list:
				cut_range_list.append([int(part)])
				cut_list.append(int(part))
	cut_list.sort()
	_save("cut_list", cut_list)
	print("saved cuts as", cut_list)
