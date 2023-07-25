extends RigidBody3D

signal died

@export var jump_power = 800.0
@export var move_speed = 1.0

var is_jumping = false
var is_on_floor = true
var dir: Vector3

func _process(delta: float) -> void:
	is_on_floor = len(get_colliding_bodies()) > 0
	var input_vector = Input.get_vector("left", "right", "forward", "back")
	dir = Vector3(input_vector.x, 0, 0) # TODO: you need to move only left or right, make code simpler
	
	if Input.is_action_just_pressed("jump") and is_on_floor:
		is_jumping = true
	shoot_raycast()

func _physics_process(delta: float) -> void:
	if not is_on_floor:
		gravity_scale = 1
		move_and_collide(dir * move_speed * delta)
		
	if is_jumping:
		jump((Vector3.UP * jump_power + Vector3.FORWARD * jump_power * 0.8) * delta)
		
	if not is_on_floor and Input.is_action_just_pressed("jump"):
		gravity_scale = 500
		
func jump(direction):
	is_jumping = false
	apply_impulse(direction) 

func shoot_raycast():
	var space_state = get_world_3d().direct_space_state
	var ray_length = 40.0

	var origin = position
	var end = origin + Vector3.DOWN * ray_length
	var query = PhysicsRayQueryParameters3D.create(origin, end)
	query.exclude = [self, $"../Boundries"]
	query.collide_with_areas = true
	
	var result = space_state.intersect_ray(query)
	var hit_pos = result.get("position", origin)
	if not result:
		hit_pos.y = 0
	$LandingBall.global_position = hit_pos
	
## implement proper dying
func die():
	died.emit()

