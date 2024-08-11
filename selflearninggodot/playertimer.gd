extends Node

@export var enemyscene: PackedScene
@export var tommyscene: PackedScene
@onready var player = $Player

var tomspawn =false

func _ready():
	tomspawn = false
	player.hide()

var score = 0

signal start

func _process(_delta):
	if int(score) % 5 == 0 and int(score) != 0 and tomspawn == false:
		tomspawn = true
		$Timer.stop()
		var tommy = tommyscene.instantiate()
		add_child(tommy)
		await tommy.tree_exited
		score = str(int(score) + 1)
		print("yuh huh")
		$Timer.start()
		tomspawn = false

func _on_button_pressed():
	player.show()
	$Timer.start()
	$Button.hide()
	$Label.text = "Score: 0"
	tomspawn = false

func _on_timer_timeout():
	
	var enemy = enemyscene.instantiate()
	var mob_spawn_location = $Path2D/SpawnPath
	mob_spawn_location.progress_ratio = randf()
	var direction = mob_spawn_location.rotation + PI / 2

	# Set the mob's position to a random location.
	enemy.position = mob_spawn_location.position

	# Add some randomness to the direction.
	direction += randf_range(-PI / 4, PI / 4)
	enemy.rotation = direction

	# Choose the velocity for the mob.
	var velocity = Vector2(randf_range(150.0, 250.0), 0.0)
	enemy.linear_velocity = velocity.rotated(direction)

	# Spawn the mob by adding it to the Main scene.
	add_child(enemy)
	score = str(int(score) + 1)
	var scoretext = "Score: " + score
	$Label.text = scoretext
	$Timer.wait_time = 1/sqrt(float(score))

func _on_player_hit():
	score = 0
	$Button.show()
	$Timer.stop()
	if $Tommy:
		$Tommy.queue_free()
		$Timer.stop()
	$Timer.stop()
