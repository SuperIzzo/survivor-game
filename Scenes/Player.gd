extends Area2D
signal hit
signal spawnFireball;

@export var speed:int = 400;
var screen_size:Vector2;
var canFire:bool = false;

# Called when the node enters the scene tree for the first time.
func _ready():
	screen_size = get_viewport_rect().size;
	hide();
	canFire = false;


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	processEnemySpawn(delta);
	processFireballSpawn(delta);
	
func processFireballSpawn(delta:float):
	if (canFire && $FireballCooldown.is_stopped() && Input.is_action_pressed("fire")):
		$FireballCooldown.start();
		spawnFireball.emit();
		

func processEnemySpawn(delta:float):
	var velocity:Vector2 = Vector2.ZERO;
	var temp:float = Input.is_action_pressed("move_right");
	velocity.x += temp;
	temp = Input.is_action_pressed("move_left");
	velocity.x -= temp;
	temp = Input.is_action_pressed("move_down");
	velocity.y += temp;
	temp = Input.is_action_pressed("move_up");
	velocity.y -= temp;
	
	if (velocity.length_squared() > 0):
		velocity = velocity.normalized() * speed;
		$AnimatedSprite2D.play();
	else:
		$AnimatedSprite2D.stop();
	
	var halfSize = $CollisionShape2D.shape.get_rect().size * 0.5;
	
	position += velocity * delta;
	position.x = clamp(position.x, halfSize.x, screen_size.x - halfSize.x);
	position.y = clamp(position.y, halfSize.y, screen_size.y - halfSize.y);

	
func start(pos:Vector2):
	position = pos
	show();
	$CollisionShape2D.disabled = false;
	$FireballCooldown.start();
	canFire = true;
	
func dead():
	canFire = false;

func _on_body_entered(body):
	hide();
	hit.emit();
	
	$CollisionShape2D.set_deferred("disabled", true);
