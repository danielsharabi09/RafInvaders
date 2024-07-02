extends Node2D

@onready var left_muzzle: Marker2D = $LeftMuzzle
@onready var right_muzzle: Marker2D = $RightMuzzle
@onready var left_muzzle2: Marker2D = $LeftMuzzle2
@onready var right_muzzle2: Marker2D = $RightMuzzle2
@onready var spawner_component: SpawnerComponent = $SpawnerComponent as SpawnerComponent
@onready var fire_rate_timer: Timer = $FireRateTimer
@onready var scale_component: ScaleComponent = $ScaleComponent as ScaleComponent
@onready var animated_sprite_2d: AnimatedSprite2D = $Anchor/AnimatedSprite2D
@onready var move_component: MoveComponent = $MoveComponent as MoveComponent
@onready var flame_animated_sprite: AnimatedSprite2D = %FlameAnimatedSprite
@onready var variable_pitch_audio_stream_player: = $VariablePitchAudioStreamPlayer as VariablePitchAudioStreamPlayer
@onready var power_up_timer = $PowerUpTimer
var isPower = false

func _ready() -> void:
	#fire_rate_timer.timeout.connect(fire_lasers)
	pass
	
func _input(event: InputEvent) -> void:
	if Input.is_action_pressed("Space"):
		if isPower:
			power_lasers()
		else: 
			fire_lasers()


func fire_lasers() -> void:
	variable_pitch_audio_stream_player.play_with_variance()
	spawner_component.spawn(left_muzzle.global_position)
	spawner_component.spawn(right_muzzle.global_position)
	scale_component.tween_scale()
	
func power_lasers() -> void:
	const projectile = preload("res://projectiles/power_laser.tscn")
	var projectile1 = projectile.instantiate()
	var projectile2 = projectile.instantiate()
	var projectile3 = projectile.instantiate()
	var projectile4 = projectile.instantiate()
	var projectile5 = projectile.instantiate()

	get_tree().root.add_child(projectile1)
	projectile1.global_position = global_position	

	get_tree().root.add_child(projectile2)
	projectile2.global_position = left_muzzle2.global_position	
	get_tree().root.add_child(projectile3)
	projectile3.global_position = right_muzzle.global_position	
	get_tree().root.add_child(projectile4)
	projectile4.global_position = right_muzzle2.global_position	
	get_tree().root.add_child(projectile5)
	projectile5.global_position = left_muzzle.global_position
	#variable_pitch_audio_stream_player.play_with_variance()
	#spawner_component.spawn(left_muzzle.global_position)
	#spawner_component.spawn(left_muzzle2.global_position)
	#spawner_component.spawn(right_muzzle.global_position)
	#spawner_component.spawn(right_muzzle2.global_position)

	var pos = position * -1


	projectile1.update_target(Vector2(0,-140))
	projectile2.update_target(Vector2(-20,-140))
	projectile3.update_target(Vector2(20,-140))
	projectile4.update_target(Vector2(40,-140))
	projectile5.update_target(Vector2(-40,-140))




func _process(delta: float) -> void:
	animate_the_ship()

func animate_the_ship() -> void:
	if move_component.velocity.x < 0:
		animated_sprite_2d.play("bank_left")
		flame_animated_sprite.play("bank_left")
	elif move_component.velocity.x > 0:
		animated_sprite_2d.play("bank_right")
		flame_animated_sprite.play("bank_right")
	else:
		animated_sprite_2d.play("center")
		flame_animated_sprite.play("center")

func power_up() -> void:
	isPower = true
	power_up_timer.start(15)
	


func _on_power_up_timer_timeout():
	isPower = false
