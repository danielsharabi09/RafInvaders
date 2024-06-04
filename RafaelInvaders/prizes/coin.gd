extends Node2D


@onready var stats_component: = $StatsComponent as StatsComponent
@onready var move_component: = $MoveComponent as MoveComponent


func _ready() -> void:
	move_component.velocity.x = [-20, 20].pick_random()



func _on_coin_body_entered(body):
	print("Coin collected!")
	const IRON = preload("res://rafael/iron_dome.tscn")
	var iron_dome = IRON.instantiate()
	get_tree().root.add_child(iron_dome)
	iron_dome.position = Vector2(25,200)

	queue_free()
