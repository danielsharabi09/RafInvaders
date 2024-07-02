extends Node2D

@onready var center_muzzle: Marker2D = $CenterMuzzle
@onready var spawner_component: SpawnerComponent = $SpawnerComponent as SpawnerComponent
@onready var fire_rate_timer: Timer = $FireRateTimer
@onready var scale_component: ScaleComponent = $ScaleComponent as ScaleComponent
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
			const missile = preload("res://rafael/arrow_missile.tscn")
			var new_missile = missile.instantiate()
			add_child(new_missile)
			new_missile.update_target(enemy.global_position)	
	scale_component.tween_scale()

func _process(delta: float) -> void:
	#animate_the_ship()
	pass

func _on_timer_timeout():
	queue_free()

