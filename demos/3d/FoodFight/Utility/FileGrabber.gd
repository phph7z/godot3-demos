extends Node

func get_files(folder):
	var files = {}
	var file_count = 0
	var dir = Directory.new()
	dir.open(folder)
	dir.list_dir_begin()
	
	while true:
		var file = dir.get_next()
		if not file:
			break
		elif not file.begins_with("."):
			files[file_count] = folder + file
			file_count += 1
			
	return files
