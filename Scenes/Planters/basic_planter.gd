extends Interactable

var plant = preload("res://Scenes/Growables/Carrot/carrot_p1.tscn")

@onready var plant_start: Marker3D = $PlantStart
@onready var growth_timer: Timer = $GrowthTimer

# growing stuff
var is_full = false
var is_harvestable = false
var current_plant 

func _ready() -> void:
	
	pass

func _process(delta: float) -> void:
	pass

func _on_interacted(body: Variant) -> void:
	print("Interacted with " + body.name)
	
	if body is Player and !is_full:
		plant_seed()
		is_full = true
	
	if body is Player and is_harvestable:
		is_full = false
		is_harvestable = false
		prompt_message = "Interact"
		
		# remove the finished plant
		for i in plant_start.get_children():
			i.queue_free()
			print(i)

func plant_seed():
	
	var instance = plant.instantiate()
	instance.position = plant_start.position
	plant_start.add_child(instance)

	SignalBus.growth_done.connect(plant_harvest)
	

func plant_harvest():
	is_harvestable = true
	prompt_message = "Harvest"
	
