extends Node

const SAVE_PATH = "res://savegame.bin"

func saveGame():
	var file = FileAccess.open(SAVE_PATH, FileAccess.WRITE)
	var data: Dictionary = {
		"playerHP": Game.playerHP,
		"gold": Game.Gold
	}
	
	var jstr = JSON.stringify(data)
	file.store_string(jstr)
	
func  loadGame():
	var file = FileAccess.open(SAVE_PATH, FileAccess.READ)
