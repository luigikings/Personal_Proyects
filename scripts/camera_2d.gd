extends Camera2D

# Tamaño de la pantalla visible (o viewport)
@export var screen_size: Vector2 = Vector2(1920, 1080)  # Ajusta según tu resolución

# Variable para rastrear la altura mínima de la cámara
var camera_min_y = 0

# Referencia al nodo del jugador
@export var player: Node2D

func _ready():
	# Asegúrate de que esta cámara sea la activa
	is_current() == true

func _process(delta):
	# Calcula los límites de la cámara
	var camera_top = position.y - (screen_size.y / 2)
	var camera_bottom = position.y + (screen_size.y / 2)
	
	# Verifica si el nodo `player` es válido
	if player.position.y < camera_top:  # Jugador se sale por arriba
		position.y -= screen_size.y  # Mover la cámara hacia arriba
	elif player.position.y > camera_bottom:  # Jugador se sale por abajo
		position.y += screen_size.y  # Mover la cámara hacia abajo
