extends Label

@onready var player = $"../../Player/Player"
func _process(delta):
	text = "HP: " + str(player.health)
