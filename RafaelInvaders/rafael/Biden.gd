extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready():
	$AnimatedSprite2D.play("center")
	pass # Replace with function body.

func _on_timer_timeout():
	queue_free()
