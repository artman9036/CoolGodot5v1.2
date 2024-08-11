extends RigidBody2D

@export var enemyscene: PackedScene
# Called when the node enters the scene tree for the first time.
var attack = false
var attacks = 0

func tunnel():
	var offset = 0
	
	for i in range(0, 170, 20):
		offset = i
		var enemy = enemyscene.instantiate()
		var enemy2 = enemyscene.instantiate()
		enemy.position = Vector2(200 + offset, 180)
		enemy2.position = Vector2(440 + offset, 180)
		enemy.linear_velocity = Vector2(0, 400)
		enemy2.linear_velocity = Vector2(0, 400)
	
		add_child(enemy)
		add_child(enemy2)
		await get_tree().create_timer(0.1).timeout
	for i in range(160, -170, -20):
		offset = i
		var enemy = enemyscene.instantiate()
		var enemy2 = enemyscene.instantiate()
		enemy.position = Vector2(200 + offset, 180)
		enemy2.position = Vector2(440 + offset, 180)
		enemy.linear_velocity = Vector2(0, 400)
		enemy2.linear_velocity = Vector2(0, 400)
	
		add_child(enemy)
		add_child(enemy2)
		await get_tree().create_timer(0.1).timeout
	for i in range(-160, 10, 20):
		offset = i
		var enemy = enemyscene.instantiate()
		var enemy2 = enemyscene.instantiate()
		enemy.position = Vector2(200 + offset, 180)
		enemy2.position = Vector2(440 + offset, 180)
		enemy.linear_velocity = Vector2(0, 400)
		enemy2.linear_velocity = Vector2(0, 400)
	
		add_child(enemy)
		add_child(enemy2)
		await get_tree().create_timer(0.1).timeout
	await get_tree().create_timer(2).timeout
	attack = false

func spray():
	for i in range(75):
		var enemy = enemyscene.instantiate()
		
		enemy.position = Vector2(randi_range(0, 640), 180)
		
		enemy.linear_velocity = Vector2(0, 400)
		
		add_child(enemy)
		await get_tree().create_timer(0.2).timeout
	await get_tree().create_timer(1).timeout
	attack = false
		

func big_guy():
	var enemy = enemyscene.instantiate()
	
	enemy.position = Vector2(320, 180)
	enemy.linear_velocity = Vector2(0, 400)
	
	add_child(enemy)
	await get_tree().create_timer(2).timeout
	attack = false

func _ready():
	position = Vector2(0, -200)
	attack = false
	attacks = 0
	while position.y != 0:
		position.y += 1
		await get_tree().create_timer(0.01).timeout
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	if position.y == 0:
		var number = randi_range(0, 2)
		if not attack:
			if attacks > -1:
				while position.y != -200:
					position.y -= 10
					await get_tree().create_timer(0.01).timeout
				queue_free()
			if number == 0:
				tunnel()
			elif number == 1:
				spray()
			elif number == 2:
				big_guy()
			attack = true
			attacks += 1


func _on_visible_on_screen_notifier_2d_screen_exited():
	queue_free()
