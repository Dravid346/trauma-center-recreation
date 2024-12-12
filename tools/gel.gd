extends "res://tools/tool.gd"

#TODO: Figure out how to despawn the oldest puddle. or maybe just use tool durability instead

var active: bool = false
var max_fuel: float = 3.2
var fuel: float = 3.2
var min_fuel: float = 0
var fuel_cost: float = 0.04
var max_puddles: int = 100
var spawned_puddles: int = 0
var healing: float = 0.05
@export var puddle_scene: PackedScene

func click():
	active = true
	play_sound()
	$SoundTimer.start()

func release():
	active = false
	fuel = max_fuel
	$SoundTimer.stop()

func _physics_process(_delta: float):
	if active:
		if fuel >= min_fuel and spawned_puddles < max_puddles:
			var puddle = puddle_scene.instantiate()
			puddle.position = position
			puddle.set_juice(fuel)
			fuel -= fuel_cost
			add_child(puddle)
			puddle.connect("evaporate", kill_puddle)
			spawned_puddles += 1
			Signals.vitals_heal.emit(healing)
			
			use_durability(1)
		else:
			release()

func kill_puddle(puddle: Area2D):
	puddle.queue_free()
	spawned_puddles -= 1

func play_sound():
	if $GelSound.playing:
		$GelSound2.play()
	else:
		$GelSound.play()
