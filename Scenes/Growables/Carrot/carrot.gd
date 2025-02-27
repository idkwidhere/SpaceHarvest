extends Interactable


func _on_interacted(body: Variant) -> void:
	print("oh no you didn't")
	
	if body is Player:
		print("player idk")
