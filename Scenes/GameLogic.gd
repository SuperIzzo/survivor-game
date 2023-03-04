extends Node
@export var mob_scene: PackedScene
var score;

# Called when the node enters the scene tree for the first time.
func _ready():
	new_game();


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func game_over():
	$ScoreTimer.stop();
	$RespawnTimer.stop();
	
func new_game():
	score = 0;
	$Player.start($StartPosition.position);
	$RespawnTimer.start();


func _on_score_timer_timeout():
	score +=1;


func _on_respawn_timer_timeout():
	$SpawnTimer.start();
	$ScoreTimer.start();


func _on_spawn_timer_timeout():
	var mob = mob_scene.instantiate();
	
	var mobSpawnTransform = $Path2D/MobSpawnLocation;
	mobSpawnTransform.progress_ratio = randi();
	
	var direction = mobSpawnTransform.rotation + PI * 0.5;
	mob.position = mobSpawnTransform.position;
	
	direction += randf_range(-PI * 0.25, PI * 0.25);
	mob.rotation = direction;
	
	var velocity:Vector2 = Vector2(randf_range(150.0, 250.0), 0.0);
	mob.linear_velocity = velocity.rotated(direction);

	print("Spawned at: " + str(mob.position));
	add_child(mob);
