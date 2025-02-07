@tool
class_name Player
extends CharacterBody2D
## A player's character, which can walk, jump, and stomp on enemies.

var  _PLAYER_ACTIONS = {
	Global.Player.ONE:
	{
		"jump": "ui_accept",
		"left": "ui_left",
		"right": "ui_right",
	}
}
## Which player controls this character?
@export var player: Global.Player = Global.Player.ONE

## Use this to change the sprite frames of your character.
@export var sprite_frames: SpriteFrames = _initial_sprite_frames:
	set = _set_sprite_frames

## How fast does your character move?
@export_range(0, 1000, 10, "suffix:px/s") var speed: float = 500.0:
	set = _set_speed

## How fast does your character accelerate?
@export_range(0, 5000, 1000, "suffix:px/s²") var acceleration: float = 5000.0

## How high does your character jump? Note that the gravity will
## be influenced by the [member GameLogic.gravity].
@export_range(-1000, 1000, 10, "suffix:px/s") var jump_velocity = -880.0

## How much should the character's jump be reduced if you let go of the jump
## key before the top of the jump? [code]0[/code] means “not at all”;
## [code]100[/code] means “upwards movement completely stops”.
@export_range(0, 100, 5, "suffix:%") var jump_cut_factor: float = 20

## How long after the character walks off a ledge can they still jump?
## This is often set to a small positive number to allow the player a little
## margin for error before they start falling.
@export_range(0, 0.5, 1 / 60.0, "suffix:s") var coyote_time: float = 5.0 / 60.0

## If the character is about to land on the floor, how early can the player
## the jump key to jump as soon as the character lands? This is often set to
## a small positive number to allow the player a little margin for error.
@export_range(0, 0.5, 1 / 60.0, "suffix:s") var jump_buffer: float = 5.0 / 60.0

## Can your character jump a second time while still in the air?
@export var double_jump: bool = false

# If positive, the player is either on the ground, or left the ground less than this long ago
var coyote_timer: float = 0

# If positive, the player pressed jump this long ago
var jump_buffer_timer: float = 0

# If true, the player is already jumping and can perform a double-jump
var double_jump_armed: bool = false

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var original_position: Vector2

@onready var _sprite: AnimatedSprite2D = %AnimatedSprite2D
@onready var _initial_sprite_frames: SpriteFrames = %AnimatedSprite2D.sprite_frames
@onready var _double_jump_particles: CPUParticles2D = %DoubleJumpParticles
@onready var timer = $Timer

func change_jump():
	#creamos una lista con todas las letras, tiene que ser en mayusculas por tema de que el mapeado es en mayusculas
	var letras = ["Q","W","E","R",
	"T","Y","U","I","O","P","A","S",
	"D","F","G","H","J","K","L","Z",
	"X","C","V","B","N","M"]
	
	#despues generamos un numero al azar desde el 0 hasta el tamanio de la lista -1 para evitar salirnos
	var letra1 = round(randf_range(0,letras.size()-1))
	var letra2 = round(randf_range(0,letras.size()-1))
	while letra1 == letra2:
		letra2 = round(randf_range(0,letras.size()-1))
	var letra3 = round(randf_range(0,letras.size()-1))
	while letra3 == letra1 || letra3 ==letra2:
		letra3 = round(randf_range(0,letras.size()-1))
	
	#cambiamos la player action de saltar a la letra que hayamos elegido segun el numero de la pos de la lista
	_PLAYER_ACTIONS[Global.Player.ONE]["jump"] = letras[letra1]
	_PLAYER_ACTIONS[Global.Player.ONE]["left"] = letras[letra2]
	_PLAYER_ACTIONS[Global.Player.ONE]["right"] = letras[letra3]
	var hud_node = get_parent().get_node("HUD")
	if hud_node:
		hud_node.controls()
	else:
		print("No se encontró el nodo HUD.")
	#imprimimos la letra para saber a cual cambio
	print("Saltar:			",letras[letra1])
	print("Izquiera:		",letras[letra2])
	print("Derecha:		",letras[letra3])

func _set_sprite_frames(new_sprite_frames):
	sprite_frames = new_sprite_frames
	if sprite_frames and is_node_ready():
		_sprite.sprite_frames = sprite_frames


func _set_speed(new_speed):
	speed = 750
	if not is_node_ready():
		await ready
	if speed == 0:
		_sprite.speed_scale = 0
	else:
		_sprite.speed_scale = speed / 500


# Called when the node enters the scene tree for the first time.
func _ready():
	randomize()  # Asegúrate de generar un nuevo estado aleatorio
	timer.wait_time = randf_range(3, 10)# Conecta la señal
	timer.timeout.connect(_on_Timer_timeout)
	# Inicia el timer
	timer.start()
	
	if Engine.is_editor_hint():
		set_process(false)
		set_physics_process(false)
	else:
		Global.gravity_changed.connect(_on_gravity_changed)
		Global.lives_changed.connect(_on_lives_changed)

	original_position = position
	_set_speed(speed)
	_set_sprite_frames(sprite_frames)


func _on_gravity_changed(new_gravity):
	gravity = 4000


func _jump():
	velocity.y = -1500
	coyote_timer = 0
	jump_buffer_timer = 0
	if double_jump_armed:
		double_jump_armed = false
		_double_jump_particles.emitting = true
	elif double_jump:
		double_jump_armed = true


func stomp():
	double_jump_armed = false
	_jump()


func _player_just_pressed(action):
	if player == Global.Player.BOTH:
		return (
			Input.is_action_just_pressed(_PLAYER_ACTIONS[Global.Player.ONE][action])
		)
	return Input.is_action_just_pressed(_PLAYER_ACTIONS[player][action])


func _player_just_released(action):
	if player == Global.Player.BOTH:
		return (
			Input.is_action_just_released(_PLAYER_ACTIONS[Global.Player.ONE][action])
		)
	return Input.is_action_just_released(_PLAYER_ACTIONS[player][action])


func _get_player_axis(action_a, action_b):
	if player == Global.Player.BOTH:
		return clamp(
			(
				Input.get_axis(
					_PLAYER_ACTIONS[Global.Player.ONE][action_a],
					_PLAYER_ACTIONS[Global.Player.ONE][action_b]
				)
			),
			-1,
			1
		)
	return Input.get_axis(_PLAYER_ACTIONS[player][action_a], _PLAYER_ACTIONS[player][action_b])


func _physics_process(delta):
	
	# Don't move if there are no lives left.
	if Global.lives <= 0:
		return

	# Handle jump
	if is_on_floor():
		coyote_timer = (coyote_time + delta)
		double_jump_armed = false

	if _player_just_pressed("jump"):
		jump_buffer_timer = (jump_buffer + delta)

	if jump_buffer_timer > 0 and (double_jump_armed or coyote_timer > 0):
		_jump()

	# Reduce velocity if the player lets go of the jump key before the apex.
	# This allows controlling the height of the jump.
	if _player_just_released("jump") and velocity.y < 0:
		velocity.y *= (1 - (jump_cut_factor / 100.00))

	# Add the gravity.
	if coyote_timer <= 0:
		velocity.y += gravity * delta

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction = _get_player_axis("left", "right")
	if direction:
		velocity.x = move_toward(
			velocity.x,
			sign(direction) * speed,
			abs(direction) * acceleration * delta,
		)
	else:
		velocity.x = move_toward(velocity.x, 0, acceleration * delta)

	if velocity == Vector2.ZERO:
		_sprite.play("idle")
	else:
		if not is_on_floor():
			if velocity.y > 0:
				_sprite.play("jump_down")
			else:
				_sprite.play("jump_up")
		else:
			_sprite.play("walk")
		_sprite.flip_h = velocity.x < 0

	move_and_slide()

	coyote_timer -= delta
	jump_buffer_timer -= delta


func reset():
	position = original_position
	velocity = Vector2.ZERO
	coyote_timer = 0
	jump_buffer_timer = 0


func _on_lives_changed():
	if Global.lives > 0:
		reset()

func _on_Timer_timeout():
	# Aquí cambiarás la tecla de salto
	print("El Timer terminó, cambiando la tecla de salto...")
	change_jump()
