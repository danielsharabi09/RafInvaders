extends Node2D

@export var CoinScene: PackedScene
@export var game_stats: GameStats

var margin = 8
var screen_width = ProjectSettings.get_setting("display/window/size/viewport_width")

@onready var spawner_component: = $SpawnerComponent as SpawnerComponent
@onready var coin_spawn_timer: Timer = $CoinSpawnTimer


func _ready() -> void:
	coin_spawn_timer.timeout.connect(handle_spawn.bind(CoinScene, coin_spawn_timer))
	game_stats.score_changed.connect(func(new_score: int):
		if new_score > 10:
			coin_spawn_timer.process_mode = Node.PROCESS_MODE_INHERIT
		if new_score > 50:
			coin_spawn_timer.process_mode = Node.PROCESS_MODE_INHERIT
	)

func handle_spawn(coin_scene: PackedScene, timer: Timer, time_offset: float = 1.0) -> void:
	spawner_component.scene = coin_scene
	spawner_component.spawn(Vector2(randf_range(margin, screen_width-margin), -16))
	var spawn_rate = time_offset / (0.5 + (game_stats.score * 0.01))
	timer.start(3 + randf_range(0.25, 0.5))
	#timer.start(10)
