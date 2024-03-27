extends Label

func increment():
	PlayerData.increment_score()
	text = str(PlayerData.score)
	
