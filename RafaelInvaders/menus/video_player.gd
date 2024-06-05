extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func play():
	$VideoStreamPlayer.play()

func _on_video_stream_player_finished():
	get_tree().change_scene_to_file("res://world.tscn") # Replace with function body.
