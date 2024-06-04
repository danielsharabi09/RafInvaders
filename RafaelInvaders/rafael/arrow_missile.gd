extends Node2D

@onready var visible_on_screen_notifier_2d: VisibleOnScreenNotifier2D = $VisibleOnScreenNotifier2D
@onready var scale_component: ScaleComponent = $ScaleComponent as ScaleComponent
@onready var flash_component: FlashComponent = $FlashComponent as FlashComponent
@onready var hitbox_component: HitboxComponent = $HitboxComponent as HitboxComponent
@onready var move_component: MoveComponent = $MoveComponent as MoveComponent
@onready var target_position: Vector2
func _ready() -> void:
	scale_component.tween_scale()
	flash_component.flash()
	visible_on_screen_notifier_2d.screen_exited.connect(queue_free)
	hitbox_component.hit_hurtbox.connect(queue_free.unbind(1))
	move_component.velocity = Vector2(-40,-40)
	
func update_target(tgt_pos : Vector2) -> void:
	var my_pos = global_position
	var speedVel = 150
	var alpha = atan((tgt_pos.y - my_pos.y)/(tgt_pos.x - my_pos.x))
	var sign = 1
	if (tgt_pos.x < my_pos.x):
		sign = -1
	var velX =  sign * speedVel * cos(alpha)
	var velY = sign * speedVel * sin(alpha)
	move_component.velocity = Vector2(velX,velY)
	self.target_position = tgt_pos

func _physics_process(delta):
	var a = self.global_position
	var b = self.target_position
	var t = delta * 1.0
	self.global_position = lerp(a, b, t)
	
