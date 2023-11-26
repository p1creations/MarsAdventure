extends Area2D

@export var amplitude := 4
@export var frequency := 5
@onready var sprite_2d = $Sprite2D

var time_passed = 0
var initial_position := Vector2.ZERO

# Called when the node enters the scene tree for the first time.
func _ready():
	initial_position = position
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	diamond_hover(delta) # Call the diamond_hover function

func diamond_hover(delta):
	time_passed += delta
	
	var new_y = initial_position.y + amplitude * sin(frequency * time_passed)
	position.y = new_y

# diamond collected
func _on_body_entered(body):
	if body.is_in_group("Player"):
		#AudioManager.coin_pickup_sfx.play()
		#GameManager.add_score()
		var tween = create_tween()
		tween.tween_property(self, "scale", Vector2.ZERO, 0.1)
		await tween.finished
		queue_free()
