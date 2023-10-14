shader_type canvas_item;

uniform sampler2D buffer: filter_linear_mipmap;

uniform float wind_amount;
uniform float wind_frequency;
uniform float wind_amplitude;

void fragment() {
	vec2 pixel_size = SCREEN_PIXEL_SIZE;
	COLOR =  texture(buffer, UV);

	COLOR += texture(buffer, UV + (pixel_size * vec2(0, 1)));
	COLOR += texture(buffer, UV + (pixel_size * vec2(0, -1)));
	COLOR += texture(buffer, UV + (pixel_size * vec2(1, 0)));
	COLOR += texture(buffer, UV + (pixel_size * vec2(-1, 0)));
	COLOR += texture(buffer, UV + (pixel_size * vec2(0.75, 0.75)));
	COLOR += texture(buffer, UV + (pixel_size * vec2(-0.75, 0.75)));
	COLOR += texture(buffer, UV + (pixel_size * vec2(0.75, -0.75)));
	COLOR += texture(buffer, UV + (pixel_size * vec2(-0.75, -0.75)));
	COLOR.rgb /= 9.0;
	
	float target = 0.5 + wind_amount;
	target += sin(TIME * wind_frequency) * wind_amplitude;
	target += sin(TIME * wind_frequency * 3.3) * wind_amplitude * 0.37;
	
	COLOR.g = ((COLOR.g - 0.5) * 0.9) + 0.5;
	COLOR.g += (target - COLOR.r) * 0.05;
	COLOR.r += COLOR.g - 0.5;
	COLOR.b = 1.0;
	COLOR.a = 1.0;
	float threshold = 0.01;
	if (abs(COLOR.r - target) < threshold && abs(COLOR.g - 0.5) < threshold) {
		COLOR.r = target;
		COLOR.g = 0.5;
	}
}
