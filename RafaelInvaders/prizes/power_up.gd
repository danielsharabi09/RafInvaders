extends Node2D


@onready var stats_component: = $StatsComponent as StatsComponent
@onready var move_component: = $MoveComponent as MoveComponent


func _ready() -> void:
	move_component.velocity.x = [0, 20].pick_random()



func _on_coin_body_entered(body):
	print("Power up collected!")
	body.power_up()

	queue_free()


func _on_coin_area_entered(area):
	print("Power up collected!")
	if area.get_parent().has_method("power_up"):
		area.get_parent().power_up()
		queue_free()
