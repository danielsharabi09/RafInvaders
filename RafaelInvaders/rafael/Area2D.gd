extends Area2D


func _ready():
	# Connect on area entered to our hurtbox entered function
	area_entered.connect(_on_hurtbox_entered)

func _on_hurtbox_entered(hurtbox: HurtboxComponent):
	# Make sure the area we are overlapping is a hurtbox
	print("Area entered")
