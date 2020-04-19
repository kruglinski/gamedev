extends KinematicBody

export var speed = 5
export var jump_speed = 8
export var friction = 0.95
export var gravity = -9.8

onready var camera: Camera = $tps_target/tps_camera

var vel: Vector3
var acc: Vector3
var dir: Vector3

func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)

func _physics_process(delta):

	if Input.is_key_pressed(KEY_ESCAPE):
		get_tree().quit()

	# 1. 取操作方向
	dir.z = int(Input.is_key_pressed(KEY_S)) - int(Input.is_key_pressed(KEY_W))
	dir.x = int(Input.is_key_pressed(KEY_D)) - int(Input.is_key_pressed(KEY_A))
	
	# 2. 操作方向转换到相机坐标系
	var cam_basis = $tps_target/tps_camera.global_transform.basis
	var basis = cam_basis.rotated(cam_basis.x, -cam_basis.get_euler().x)
	
	dir = basis.xform(dir)
	
	if dir.length_squared() > 1:
		dir /= dir.length()
		
	# 3. 计算并应用加速
	acc = dir * speed
	vel += acc * delta
	
	# 4. 旋转角色
	if acc.length() > 0.1:
		var angle = atan2(dir.x, dir.z)
		rotation.y = lerp_angle(rotation.y, clamp(angle, -3.14, 3.14), delta * 7)

	# 5. 应用重力
	vel.y += delta * gravity
	
	# 6. 应用阻力
	vel *= friction
	vel = move_and_slide(vel, Vector3.UP)
	
	if is_on_floor() and Input.is_key_pressed(KEY_SPACE):
		vel.y = jump_speed
