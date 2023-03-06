extends Node
@export var mob_scene: PackedScene
@export var fireball_scene: PackedScene;

var score;

# Called when the node enters the scene tree for the first time.
func _ready():
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func game_over():
	$ScoreTimer.stop();
	$EnemySpawnTimer.stop();
	$HUD.showGameOver();
	$Player.dead();
	
func new_game():
	get_tree().call_group("mobs", "queue_free");
	score = 0;
	$Player.start($StartPosition.position);
	$RespawnTimer.start();
	$HUD.updateScore(score);
	$HUD.showMessage("Get ready...");

func _on_score_timer_timeout():
	#score +=1;
	$HUD.updateScore(score);


func _on_respawn_timer_timeout():
	$EnemySpawnTimer.start();
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

	add_child(mob);

func onEnemyKilled():
	score += 1;
	
func fireBall():
	var fireball = fireball_scene.instantiate();
	fireball.position = $Player.position;
	add_child(fireball);
	fireball.connect("killedEnemy", onEnemyKilled);
	fireball.OnSpawn();
