shader_type canvas_item;

uniform sampler2D x_texture;
uniform sampler2D y_texture;

void fragment() {
	COLOR.r = texture(x_texture, UV).r;
	COLOR.g = texture(y_texture, UV).r;
	COLOR.b = 1.0;
	COLOR.a = 1.0;
}
