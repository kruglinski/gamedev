extends Area2D

func _ready():
	pass

func _on_spike_down_body_enter( body ):
	print("spike down")
	body.enter_spike(self)

func _on_spike_top_body_enter( body ):
	print("spike top")
	body.enter_spike(self)

func _on_spikes_top_body_enter( body ):
	print("spikes top")
	body.enter_spike(self)

func _on_spikes_down_body_enter( body ):
	print("spikes down")
	body.enter_spike(self)
