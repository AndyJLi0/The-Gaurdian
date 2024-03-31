extends Node2D

@onready var asp = $AudioStreamPlayer
var volume = -10
# Called when the node enters the scene tree for the first time.
func _ready():
	AudioServer.set_bus_volume_db(0,volume)
	asp.play()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_audio_stream_player_finished():
	asp.play()
