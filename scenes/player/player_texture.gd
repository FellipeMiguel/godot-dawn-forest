extends Sprite
class_name Playertexture

export(NodePath) onready var animation = get_node(animation) as AnimationPlayer
export(NodePath) onready var player = get_node(player) as KinematicBody2D

func animate(direction: Vector2) -> void:
	verify_position(direction)
	
	if direction.y != 0:
		vertical_behavior(direction)
	elif player.landing == true:
		animation.play("landing")
		player.set_physics_process(false)
	else:
		horizontal_behavior(direction)
	
	
func verify_position(direction: Vector2) -> void:
	if direction.x > 0:
		flip_h = false
	elif direction.x < 0:
		flip_h = true

func vertical_behavior(direction: Vector2) -> void:
	if direction.y > 0:
		animation.play("fall")
		player.landing = true
	elif direction.y < 0:
		animation.play("jump")

func horizontal_behavior(direction: Vector2) -> void:
	if direction.x != 0:
		animation.play("run")
	else:
		animation.play("idle")


func on_animation_finished(anim_name: String):
	match anim_name:
		"landing":
			player.landing = false
			player.set_physics_process(true)
