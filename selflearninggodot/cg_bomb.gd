extends Area2D


# Called when the node enters the scene tree for the first time.
func _ready():
	$Timer.start()

func _on_body_entered(body):
	body.queue_free()

func _on_timer_timeout():
	queue_free()
