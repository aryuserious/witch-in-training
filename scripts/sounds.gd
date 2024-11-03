class_name Sounds
extends Node

@export var game_music : AudioStreamPlayer
@export var potion_plop : AudioStreamPlayer
@export var footstep : AudioStreamPlayer
@export var bubbling : AudioStreamPlayer


func _on_game_music_finished():
	game_music.play() # game music loops


func _on_footstep_finished():
	footstep.pitch_scale = randf_range(0.9, 1.5)


func cauldron_bubble(num_of_bubbles : int):
	for i in num_of_bubbles:
		# this is a coroutine. the rest of the code won't run until the signal is emitted
		if i > 0: # if its not the first loop
			await bubbling.finished # bubbling.finished is a signal
		# bubble sound gets lower each time
		bubbling.pitch_scale = randf_range(3.7 - (i/15.0), 4.2 - (i/15.0))
		#bubbling.volume_db = 0 if i > 4 else 0 - i/5
		bubbling.play()
		


func _on_potion_plop_finished():
	#cauldron_bubble(10)
	pass
