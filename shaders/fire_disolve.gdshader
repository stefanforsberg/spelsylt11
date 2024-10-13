shader_type canvas_item;

uniform sampler2D noise_texture;
uniform sampler2D burn_texture;

uniform float integrity: hint_range(0.0, 1.0) = 1.0;
uniform float burn_size: hint_range(1.0, 1.5) = 1.3;

float inverse_lerp(float a, float b, float v) {
	return (v-a)/(b-a);
}

void fragment() {
	
	if (texture(TEXTURE, UV).a > 0.0) {
		
	
		float noise = texture(noise_texture, UV).r * UV.y;
		vec4 base_color = texture(TEXTURE, UV) * step(noise, integrity);
		
		vec2 burn_uv = vec2(inverse_lerp(integrity, integrity*burn_size,noise), 0.0);
		
		vec4 burn_color = texture(burn_texture, burn_uv) * step(noise, integrity*burn_size);
		COLOR = mix(burn_color, base_color, base_color.a);
	}
	// Called for every pixel the material is visible on.
}
