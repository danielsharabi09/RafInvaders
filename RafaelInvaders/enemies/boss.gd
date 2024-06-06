class_name BossEnemy
extends Enemy

@onready var states: Node = $States

@onready var move_down_state: = %MoveDownState as TimedStateComponent
@onready var move_side_state: = %MoveSideState as TimedStateComponent
@onready var pause_state: = %PauseState as TimedStateComponent
@onready var fire_state: = %FireState as StateComponent
@onready var move_side_component: = %MoveSideComponent as MoveComponent
@onready var projectile_spawner_component: = %ProjectileSpawnerComponent as SpawnerComponent

#@onready var stats_component: StatsComponent = $StatsComponent as StatsComponent

func _ready() -> void:
	super()
	self.stats_component.health = 20
	for state in states.get_children():
		state = state as StateComponent
		state.disable()
	
	move_side_component.velocity.x = [-50, 50].pick_random()
	
	move_down_state.state_finished.connect(move_side_state.enable)
	move_side_state.state_finished.connect(func():
		fire_state.enable()
		scale_component.tween_scale()
		
		
		var node = get_tree().root.get_node("/root/World/Ship")
		if !node:
			return
		const projectile = preload("res://projectiles/boss_projectile.tscn")
		var projectile1 = projectile.instantiate()
		var projectile2 = projectile.instantiate()
		var projectile3 = projectile.instantiate()
		var projectile4 = projectile.instantiate()
		var projectile5 = projectile.instantiate()
		add_child(projectile1)
		add_child(projectile2)
		add_child(projectile3)
		add_child(projectile4)
		add_child(projectile5)

			
		projectile1.update_target(node.global_position)
		projectile2.update_target(node.global_position + Vector2(-20,0))
		projectile3.update_target(node.global_position + Vector2(20,0))
		projectile4.update_target(node.global_position + Vector2(40,0))
		projectile5.update_target(node.global_position + Vector2(-40,0))
		
		
		
		#projectile_spawner_component.spawn(global_position)
		fire_state.disable()
		fire_state.state_finished.emit()
	)
	fire_state.state_finished.connect(pause_state.enable)
	pause_state.state_finished.connect(move_down_state.enable)
	
	move_down_state.enable()
