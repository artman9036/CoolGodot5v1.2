extends Area2D

signal hit

@export var cgbombscene: PackedScene
var speed = 200
var able = true
var screen_size

func _ready():
	screen_size = get_viewport_rect().size
	position = Vector2(296, 296)
	$CollisionShape2D.disabled = true

func checkmovement(delta):
	var velocity = Vector2.ZERO
	if Input.is_action_pressed("move_down"):
		velocity.y += 1
	if Input.is_action_pressed("move_left"):
		velocity.x -= 1
	if Input.is_action_pressed("move_right"):
		velocity.x += 1
	if Input.is_action_pressed("move_up"):
		velocity.y -= 1
	velocity = velocity.normalized() * speed
	position += velocity * delta
	position = position.clamp(Vector2.ZERO, screen_size)
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	checkmovement(delta)
	
	if Input.is_action_pressed("action"):
		if able and not $CollisionShape2D.disabled:
			var cgbomb = cgbombscene.instantiate()
			cgbomb.position = position
			cgbomb.position.x -= 100
			cgbomb.position.y -= 100
			get_tree().root.add_child(cgbomb)
			able = false
			
	
	


func _on_body_entered(_body):
	print("Collision with enemy")
	hide() # Player disappears after being hit.
	hit.emit()
	# Must be deferred as we can't change physics properties on a physics callback.
	$CollisionShape2D.set_deferred("disabled", true) # Player disappears after being hit.

func _on_button_pressed():
	print("Pressed player script")
	show()
	position = Vector2(296, 296)
	$CollisionShape2D.disabled = false


func _on_timer_timeout():
	able = true
