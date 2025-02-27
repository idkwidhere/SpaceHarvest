extends Control


func _ready() -> void:
	SignalBus.emit_signal("send_ship_inventory")
