extends Node2D


@onready var stats_component: = $StatsComponent as StatsComponent
@onready var move_component: = $MoveComponent as MoveComponent


func _ready() -> void:
	move_component.velocity.x = [-20, 20].pick_random()



func _on_coin_body_entered(body):
	print("Coin collected!")
	const iron = preload("res://rafael/iron_dome.tscn")
	const david = preload("res://rafael/david_sling.tscn")
	const arrow = preload("res://rafael/arrow.tscn")
	const biden = preload("res://rafael/Biden.tscn")
	
	var pos = randi_range(10,100)
	var num = randi_range(1,4)
	if num == 1:
		var iron_dome = iron.instantiate()
		get_tree().root.add_child(iron_dome)
		iron_dome.position = Vector2(pos,200)
	elif num == 2:
		var david_sling = david.instantiate()
		get_tree().root.add_child(david_sling)
		david_sling.position = Vector2(pos,200)
	elif num == 3:
		var arrow_1 = arrow.instantiate()
		get_tree().root.add_child(arrow_1)
		arrow_1.position = Vector2(pos,200)
	elif num == 4:
		var biden_1 = biden.instantiate()
		get_tree().root.add_child(biden_1)
		biden_1.position = Vector2(pos,200)

	queue_free()
