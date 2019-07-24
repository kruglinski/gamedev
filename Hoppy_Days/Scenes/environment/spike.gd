extends Area2D

func _ready():
	pass

func _on_spike_down_body_enter( body ):
	body.enter_spike(self, false)

func _on_spikes_down_body_enter( body ):
	body.enter_spike(self, false)

func _on_spike_top_body_enter( body ):
	body.enter_spike(self, true)

func _on_spikes_top_body_enter( body ):
	body.enter_spike(self, true)
