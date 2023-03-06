extends CanvasLayer
signal start_game

const messageText:String = "Kill 'em all!";

# Called when the node enters the scene tree for the first time.
func _ready():
	$MessageLabel.text = messageText;


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func showMessage(text):
	$MessageLabel.text = text;
	$MessageLabel.show();
	$MessageTimer.start();
	
func showGameOver():
	showMessage("Wasted!");
	
	await $MessageTimer.timeout;
	
	$StartButton.show();
	
func updateScore(score:int):
	$ScoreLabel.text = str(score);


func _on_message_timer_timeout():
	$MessageLabel.hide();

func _on_start_button_pressed():
	$StartButton.hide();
	start_game.emit();
