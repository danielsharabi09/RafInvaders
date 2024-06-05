extends Node2D

@onready var hitbox_component: = $Anchor/HitboxComponent as HitboxComponent
@onready var visible_on_screen_notifier_2d: VisibleOnScreenNotifier2D = $VisibleOnScreenNotifier2D
@onready var scale_component: = $ScaleComponent as ScaleComponent
@onready var move_component: = $MoveComponent as MoveComponent

func _ready() -> void:
	scale_component.tween_scale()
	hitbox_component.hit_hurtbox.connect(queue_free.unbind(1))
	visible_on_screen_notifier_2d.screen_exited.connect(queue_free)
	
func update_target(tgt_pos : Vector2) -> void:
	var my_pos = global_position
	var speedVel = 60
	var alpha = atan((tgt_pos.y - my_pos.y)/(tgt_pos.x - my_pos.x))
	var sign = 1
	if (tgt_pos.x < my_pos.x):
		sign = -1
	var velX =  sign * speedVel * cos(alpha)
	var velY = sign * speedVel * sin(alpha)
	move_component.velocity = Vector2(velX,velY)
