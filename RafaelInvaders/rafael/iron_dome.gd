extends Node2D

@onready var center_muzzle: Marker2D = $CenterMuzzle
@onready var spawner_component: SpawnerComponent = $SpawnerComponent as SpawnerComponent
@onready var fire_rate_timer: Timer = $FireRateTimer
@onready var scale_component: ScaleComponent = $ScaleComponent as ScaleComponent
@onready var animated_sprite_2d: AnimatedSprite2D = $Anchor/AnimatedSprite2D
@onready var move_component: MoveComponent = $MoveComponent as MoveComponent
@onready var flame_animated_sprite: AnimatedSprite2D = %FlameAnimatedSprite
@onready var variable_pitch_audio_stream_player: = $VariablePitchAudioStreamPlayer as VariablePitchAudioStreamPlayer
@onready var area2d: Area2D = $HitboxComponent as Area2D

func _ready() -> void:
	fire_rate_timer.timeout.connect(fire_lasers)

func fire_lasers() -> void:
	variable_pitch_audio_stream_player.play_with_variance()
	#spawner_component.spawn(center_muzzle.global_position)
	var enemies_in_range = area2d.get_overlapping_areas()
	print("number of enemies: " + str(enemies_in_range.size()))
	for enemy in enemies_in_range:
			const missile = preload("res://rafael/iron_missile.tscn")
			var new_missile = missile.instantiate()
			add_child(new_missile)
			new_missile.update_target(enemy.global_position)	
	scale_component.tween_scale()

func _process(delta: float) -> void:
	#animate_the_ship()
	pass

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



func _on_timer_timeout():
	queue_free()

