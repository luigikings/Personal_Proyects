@tool
extends CanvasLayer

@onready var ending_labels = {
	Global.Endings.WIN: %WinEnding,
	Global.Endings.LOSE: %LoseEnding,
}


func _process(_delta):
	%TimeLeft.text = "%.1f" % Global.timer.time_left

func controls():
	var player_node = get_parent().get_node("Player")  # Ajusta la ruta según la estructura de tu escena
	if player_node:
		var player_inputs = player_node._PLAYER_ACTIONS
		print("Controles del jugador:", player_inputs[0])
	else:
		print("No se encontró el nodo Player.")
	#Esconder los Jump
	%"Jump-D".hide()
	%"Left-D".hide()
	%"Right-D".hide()
	%"JumpA".hide()
	%"JumpB".hide()
	%"JumpC".hide()
	%"JumpD".hide()
	%"JumpE".hide()
	%"JumpF".hide()
	%"JumpG".hide()
	%"JumpH".hide()
	%"JumpI".hide()
	%"JumpJ".hide()
	%"JumpK".hide()
	%"JumpL".hide()
	%"JumpM".hide()
	%"JumpN".hide()
	%"JumpO".hide()
	%"JumpP".hide()
	%"JumpQ".hide()
	%"JumpR".hide()
	%"JumpS".hide()
	%"JumpT".hide()
	%"JumpU".hide()
	%"JumpV".hide()
	%"JumpW".hide()
	%"JumpX".hide()
	%"JumpY".hide()
	%"JumpZ".hide()
	#Esconder los Left
	%"LeftA".hide()
	%"LeftB".hide()
	%"LeftC".hide()
	%"LeftD".hide()
	%"LeftE".hide()
	%"LeftF".hide()
	%"LeftG".hide()
	%"LeftH".hide()
	%"LeftI".hide()
	%"LeftJ".hide()
	%"LeftK".hide()
	%"LeftL".hide()
	%"LeftM".hide()
	%"LeftN".hide()
	%"LeftO".hide()
	%"LeftP".hide()
	%"LeftQ".hide()
	%"LeftR".hide()
	%"LeftS".hide()
	%"LeftT".hide()
	%"LeftU".hide()
	%"LeftV".hide()
	%"LeftW".hide()
	%"LeftX".hide()
	%"LeftY".hide()
	%"LeftZ".hide()
	#Esconder los Left
	%"RightA".hide()
	%"RightB".hide()
	%"RightC".hide()
	%"RightD".hide()
	%"RightE".hide()
	%"RightF".hide()
	%"RightG".hide()
	%"RightH".hide()
	%"RightI".hide()
	%"RightJ".hide()
	%"RightK".hide()
	%"RightL".hide()
	%"RightM".hide()
	%"RightN".hide()
	%"RightO".hide()
	%"RightP".hide()
	%"RightQ".hide()
	%"RightR".hide()
	%"RightS".hide()
	%"RightT".hide()
	%"RightU".hide()
	%"RightV".hide()
	%"RightW".hide()
	%"RightX".hide()
	%"RightY".hide()
	%"RightZ".hide()

	match player_node._PLAYER_ACTIONS[0].jump:
		"A":
			%"JumpA".visible=true
		"B":
			%"JumpB".visible=true
		"C":
			%"JumpC".visible=true
		"D":
			%"JumpD".visible=true
		"E":
			%"JumpE".visible=true
		"F":
			%"JumpF".visible=true
		"G":
			%"JumpG".visible=true
		"H":
			%"JumpH".visible=true
		"I":
			%"JumpI".visible=true
		"J":
			%"JumpJ".visible=true
		"K":
			%"JumpK".visible=true
		"L":
			%"JumpL".visible=true
		"M":
			%"JumpM".visible=true
		"N":
			%"JumpN".visible=true
		"O":
			%"JumpO".visible=true
		"P":
			%"JumpP".visible=true
		"Q":
			%"JumpQ".visible=true
		"R":
			%"JumpR".visible=true
		"S":
			%"JumpS".visible=true
		"T":
			%"JumpT".visible=true
		"U":
			%"JumpU".visible=true
		"V":
			%"JumpV".visible=true
		"W":
			%"JumpW".visible=true
		"X":
			%"JumpX".visible=true
		"Y":
			%"JumpY".visible=true
		"Z":
			%"JumpZ".visible=true
		_:
			print("Error")
		
	match player_node._PLAYER_ACTIONS[0].left:
		"A":
			%"LeftA".visible=true
		"B":
			%"LeftB".visible=true
		"C":
			%"LeftC".visible=true
		"D":
			%"LeftD".visible=true
		"E":
			%"LeftE".visible=true
		"F":
			%"LeftF".visible=true
		"G":
			%"LeftG".visible=true
		"H":
			%"LeftH".visible=true
		"I":
			%"LeftI".visible=true
		"J":
			%"LeftJ".visible=true
		"K":
			%"LeftK".visible=true
		"L":
			%"LeftL".visible=true
		"M":
			%"LeftM".visible=true
		"N":
			%"LeftN".visible=true
		"O":
			%"LeftO".visible=true
		"P":
			%"LeftP".visible=true
		"Q":
			%"LeftQ".visible=true
		"R":
			%"LeftR".visible=true
		"S":
			%"LeftS".visible=true
		"T":
			%"LeftT".visible=true
		"U":
			%"LeftU".visible=true
		"V":
			%"LeftV".visible=true
		"W":
			%"LeftW".visible=true
		"X":
			%"LeftX".visible=true
		"Y":
			%"LeftY".visible=true
		"Z":
			%"LeftZ".visible=true
		_:
			print("Error")
		
	match player_node._PLAYER_ACTIONS[0].right:
		"A":
			%"RightA".visible=true
		"B":
			%"RightB".visible=true
		"C":
			%"RightC".visible=true
		"D":
			%"RightD".visible=true
		"E":
			%"RightE".visible=true
		"F":
			%"RightF".visible=true
		"G":
			%"RightG".visible=true
		"H":
			%"RightH".visible=true
		"I":
			%"RightI".visible=true
		"J":
			%"RightJ".visible=true
		"K":
			%"RightK".visible=true
		"L":
			%"RightL".visible=true
		"M":
			%"RightM".visible=true
		"N":
			%"RightN".visible=true
		"O":
			%"RightO".visible=true
		"P":
			%"RightP".visible=true
		"Q":
			%"RightQ".visible=true
		"R":
			%"RightR".visible=true
		"S":
			%"RightS".visible=true
		"T":
			%"RightT".visible=true
		"U":
			%"RightU".visible=true
		"V":
			%"RightV".visible=true
		"W":
			%"RightW".visible=true
		"X":
			%"RightX".visible=true
		"Y":
			%"RightY".visible=true
		"Z":
			%"RightZ".visible=true
		_:
			print("Error")
		

func _ready():
	set_process(false)
	set_physics_process(false)

	Global.lives_changed.connect(_on_lives_changed)

	if Engine.is_editor_hint():
		return

	Global.coin_collected.connect(_on_coin_collected)
	Global.game_ended.connect(_on_game_ended)
	Global.timer_added.connect(_on_timer_added)
	
func _unhandled_input(event):
	if (
		(
			event is InputEventKey
			or event is InputEventJoypadButton
			or event is InputEventJoypadMotion
			or event is InputEventScreenTouch
		)
		and %Start.is_visible_in_tree()
	):
		%Start.hide()
		


func _on_coin_collected():
	set_collected_coins(Global.coins)


func set_collected_coins(coins: int):
	%CollectedCoins.text = "Coins: " + str(coins)


func _on_timer_added():
	%TimeLeft.visible = true
	set_process(true)


func _on_lives_changed():
	set_lives(Global.lives)


func set_lives(lives: int):
	%Lives.offset_right = %Lives.offset_left + lives * %Lives.texture.get_width()


func _on_game_ended(ending: Global.Endings):
	ending_labels[ending].visible = true
