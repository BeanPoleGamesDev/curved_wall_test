tool
extends Line2D

func set_points(new_points: PoolVector2Array)->void:
	points = new_points
	$StaticBody2D/CollisionPolygon2D.polygon = stroke_to_polygon()

func stroke_to_polygon():
	var new_polygon = PoolVector2Array()
	
	for i in range(points.size()):
		new_polygon.append(get_offset_point(i, width / 2))

	new_polygon.invert()

	for i in range(points.size()):
		new_polygon.append(get_offset_point(i, -width / 2))
		
	return new_polygon

func get_offset_point(i: int, offset: int):
	return points[i] + get_offset(
			get_relative_point(i, -1),
			get_relative_point(i, 1),
			offset
		)

func get_relative_point(i, space):
	if not i + space >= points.size() && i + space >= 0:
		return points[i + space]	
	return points[i]


func get_offset(last_point: Vector2, next_point: Vector2, offset: int)->Vector2:
	return last_point.direction_to(next_point).rotated(1.6) * offset
