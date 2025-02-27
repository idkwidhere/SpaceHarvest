extends Growable

@export var grow_time = 20
@export var stages = 3


@onready var model: Node3D = $Model
@onready var growth_timer: Timer = $GrowthTimer


#stages of growth
var stage = 0


func _on_growth_timer_timeout() -> void:
	if stage < stages:
		model.scale += Vector3(.01, 0.01, 0.01)
		stage += 1
		print("growth tick")
	else:
		growth_timer.stop()
		print("done growing")
		SignalBus.growth_done.emit()
