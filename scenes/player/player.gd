extends CharacterBody3D

@export_group("Camera")
@export_range(0.0, 1.0) var mouse_sensitivity = 0.25

@export_group("Movement")
@export var move_speed = 8.0
@export var acceleration = 20.0
@export var rotation_speed = 12.0

var _camera_input_direction = Vector2.ZERO
var _last_movement_direction = Vector3.BACK

var bullet = load("res://scenes/bullet/bullet.tscn")
var instance

@onready var _camera_pivot: Node3D = %CameraPivot
@onready var _camera: Camera3D = %Camera3D
@onready var _skin = %Body
@onready var _gun_anim = $CameraPivot/Gun/AnimationPlayer
@onready var _gun_raycast = %GunRayCast
@onready var _cam_raycast = %CamRayCast
@onready var _shoot_timer = $ShootTimer

var is_shooting = false
var init_gun_raycast

func _ready():
	init_gun_raycast = _gun_raycast.target_position

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("left_click"):
		Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
	if event.is_action_pressed("ui_cancel"):
		Input.mouse_mode = Input.MOUSE_MODE_VISIBLE


func _unhandled_input(event: InputEvent) -> void:
	var is_camera_motion = (
		event is InputEventMouseMotion and
		Input.get_mouse_mode() == Input.MOUSE_MODE_CAPTURED
	)
	
	if is_camera_motion:
		_camera_input_direction = event.screen_relative * mouse_sensitivity


func _physics_process(delta: float) -> void:
	_camera_pivot.rotation.x += _camera_input_direction.y * delta
	_camera_pivot.rotation.x = clamp(_camera_pivot.rotation.x, -PI / 3.0, PI / 3.0)
	_camera_pivot.rotation.y -= _camera_input_direction.x * delta

	_camera_input_direction = Vector2.ZERO
	
	_skin.global_rotation.y = _skin.rotation.y + (_camera_pivot.rotation.y - _skin.rotation.y)
	
	var raw_input = Input.get_vector("move_left", "move_right", "move_forward", "move_back")
	var forward = _camera.global_basis.z
	var right = _camera.global_basis.x
	
	var move_direction = forward * raw_input.y + right * raw_input.x
	move_direction.y = 0.0
	move_direction = move_direction.normalized()
	
	velocity = velocity.move_toward(move_direction * move_speed, acceleration * delta)
	move_and_slide()
	
	if Input.is_action_pressed("shoot"):
		if !is_shooting:
			is_shooting = true
			_gun_anim.play("shoot")
			instance = bullet.instantiate()
			instance.global_position = _gun_raycast.global_position
			instance.global_basis = _gun_raycast.global_basis
			_shoot_timer.start()
			add_child(instance)
	
	if _cam_raycast.is_colliding():
		_gun_raycast.target_position = _gun_raycast.to_local(_cam_raycast.get_collision_point())
	else:
		_gun_raycast.target_position = init_gun_raycast


func _on_shoot_timer_timeout() -> void:
	is_shooting = false
	pass # Replace with function body.
