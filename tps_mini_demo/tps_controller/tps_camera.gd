extends Camera

export var min_distance = 1
export var max_distance = 2.5
export var angle_v_adjust = 0.0
export var autoturn_ray_aperture = 25
export var autoturn_speed = 20
export var camera_height = 1

var collision_exception = []

var last_target: Vector3

func _ready():
	
	# 将角色本身排除相机光线遮挡判断
	var node = self
	while node:
		if node is RigidBody:
			collision_exception.append(node.get_rid())
			break
		else:
			node = node.get_parent()

	set_physics_process(true)
	
	# 将相机从子节点中脱离出来, 使期不受父节点转换矩阵影响
	set_as_toplevel(true)
	last_target = get_parent().get_global_transform().origin


func _physics_process(dt):
	var target = get_parent().get_global_transform().origin
	var pos = get_global_transform().origin
	
	# 1. 计算位移向量
	var delta = pos - target

	# 2. 修正最近最远位移量
	if delta.length() < min_distance:
		delta = delta.normalized() * min_distance
	elif  delta.length() > max_distance:
		delta = delta.normalized() * max_distance

	# 3. 判断相机遮挡情况
	var ds = PhysicsServer.space_get_direct_state(get_world().get_space())

	var col_left = ds.intersect_ray(target, target + Basis(Vector3.UP, deg2rad(autoturn_ray_aperture)).xform(delta), collision_exception)
	var col = ds.intersect_ray(target, target + delta, collision_exception)
	var col_right = ds.intersect_ray(target, target + Basis(Vector3.UP, deg2rad(-autoturn_ray_aperture)).xform(delta), collision_exception)

	if !col.empty():
		# 最坏的情况下相机被完全遮挡, 只有将相机移近角色
		delta = col.position - target
	elif !col_left.empty() and col_right.empty():
		# 只有左半边被遮挡, 向右移动相机
		delta = Basis(Vector3.UP, deg2rad(-dt * autoturn_speed)).xform(delta)
	elif col_left.empty() and !col_right.empty():
		# 只有右半边被遮挡, 向左移动相机
		delta = Basis(Vector3.UP, deg2rad(dt  *autoturn_speed)).xform(delta)
		
	# 4. 移动相机并观察角色
	if delta == Vector3():
		delta = (pos - target).normalized() * 0.0001

	pos = target + delta
	pos.y = target.y + camera_height
	
	look_at_from_position(pos, target, Vector3.UP)

	# 5. 相机少许上下转动
	var t = get_transform()
	t.basis = Basis(t.basis[0], deg2rad(angle_v_adjust)) * t.basis
	set_transform(t)
