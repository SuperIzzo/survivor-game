extends Area2D
signal killedEnemy;
@export var speed:float = 10;

var direction:Vector2;

# Called when the node enters the scene tree for the first time.
func _ready():
	$AnimatedSprite2D.play();

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var newPos = self.position;
	newPos = newPos + direction * speed;
	
	self.position = newPos;


func _on_visible_on_screen_notifier_2d_screen_exited():
	queue_free();
	
func OnSpawn():
	direction = get_viewport().get_mouse_position() - self.position;
	direction = direction.normalized();

func onCollision(body):
	body.queue_free();
	killedEnemy.emit();
	self.queue_free();
