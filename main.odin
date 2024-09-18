package main

import math "core:math"
import rl "vendor:raylib"

SCREEN_FACTOR :: 80
WIDTH :: 16 * SCREEN_FACTOR
HEIGHT :: 9 * SCREEN_FACTOR

BRANCH_THICKNESS :: 10.0
BRANCH_COUNT :: 7
BRANCH_LEN :: SCREEN_FACTOR * 2
BRANCH_ANGLE :: 2.0 * math.PI / f32(BRANCH_COUNT)
DEPTH :: 4

draw_snowflake :: proc(center: rl.Vector2, depth: int, thickness: f32, branch_len: f32, hue: f32) {
	if depth == 0 {
		return
	}
	for i: f32 = 0.0; i < BRANCH_COUNT; i += 1.0 {
		line := rl.Vector2 {
			center.x + math.cos(BRANCH_ANGLE * i) * branch_len,
			center.y + math.sin(BRANCH_ANGLE * i) * branch_len,
		}
		rl.DrawLineEx(center, line, thickness, rl.ColorFromHSV(hue, 1.0, 1.0))
		draw_snowflake(line, depth - 1, thickness * 0.5, branch_len * 0.5, hue + 70.0)
	}
}

main :: proc() {
	rl.InitWindow(WIDTH, HEIGHT, "Snowflake")

	center := rl.Vector2{WIDTH * 0.5, HEIGHT * 0.5}

	for !rl.WindowShouldClose() {
		rl.BeginDrawing()
		rl.ClearBackground(rl.Color{0x18, 0x18, 0x18, 0xFF})
		draw_snowflake(center, DEPTH, BRANCH_THICKNESS, BRANCH_LEN, 0)
		rl.EndDrawing()
	}
}
