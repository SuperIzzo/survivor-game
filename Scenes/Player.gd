extends Area2D

@export var speed:int = 400;
var screen_size:Vector2;

# Called when the node enters the scene tree for the first time.
func _ready():
	screen_size = get_viewport_rect().size;


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
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
		

	position += velocity * delta;
	position.x = clamp(position.x, 0, screen_size.x);
	position.y = clamp(position.y, 0, screen_size.y);
