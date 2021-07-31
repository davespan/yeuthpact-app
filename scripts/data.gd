extends Node

# Saving data this way cannot really prevent players from editing their 
# savegames locally because, since the encryption key is stored inside 
# the game, the player can still decrypt and edit the file themselves. 
# The only way to prevent this from being possible is to store the save 
# data on a remote server, where players can only make authorized changes
# to their save data.

const FILE_PATH = "user://game-data.json"

var player = {
	"mute": false,
	"launched": false,
	"game1": {
		"completed": false
	},
	"game2": {
		"completed": false,
		"high_score": 0
	},
	"game3": {
		"completed": false,
		"high_score": 0
	},
	"game4": {
		"completed": false,
		"high_score": 0
	},
	"game5": {
		"completed": false,
		"high_score": 0
	}
}

func save_data():
	var file = File.new()
	file.open_encrypted_with_pass(FILE_PATH, File.WRITE, OS.get_unique_id())
	file.store_string(to_json(player))
	file.close()
	
func load_data():
	var file = File.new()
	if file.file_exists(FILE_PATH):
		file.open_encrypted_with_pass(FILE_PATH, File.READ, OS.get_unique_id())
		var data = parse_json(file.get_as_text())
		file.close()
		if typeof(data) == TYPE_DICTIONARY:
			player = data
		else:
			printerr("Corrupted data!")
	else:
		printerr("No saved data!")
