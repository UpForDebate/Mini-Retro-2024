extends Node3D


@export var did_catch = false


func _ready():
	throw("")


func struggle(randstring: StringName):
	$AnimationPlayer.play("Fisher_Struggle")
	$AnimationPlayer.connect("animation_finished", catch, 4)

func catch(randstring: StringName):
	$AnimationPlayer.play("Fisher_Catch")
	$AnimationPlayer.connect("animation_finished", throw, 4)

func throw(randstring: StringName):
	$AnimationPlayer.play("Fisher_Throw")
	$AnimationPlayer.connect("animation_finished", struggle, 4)
