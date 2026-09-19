extends LineEdit


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

##good
func _on_text_submitted(new_text: String) -> void:
	assert((int(new_text) <= 999999 && int(new_text) >= 1e5), "
ERR:
Invalid Student ID")
	
	print(int(new_text))
