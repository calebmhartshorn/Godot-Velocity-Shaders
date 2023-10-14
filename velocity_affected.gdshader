shader_type canvas_item;

uniform sampler2D velocity_buffer;
uniform vec2 world_uv;

uniform float amount = 1.0;

void fragment() {
	vec2 wind = texture(velocity_buffer, world_uv).rg - vec2(0.5);
	COLOR = texture(TEXTURE, UV - (vec2(wind * pow(1.0 - UV.y, 2.0)) ) * amount);
}
