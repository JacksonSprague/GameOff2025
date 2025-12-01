shader_type canvas_item;

uniform float flash_strength =0.0;

void fragment() {
    vec4 tex = texture(TEXTURE, UV);
    COLOR = mix(tex, vec4(1.0), flash_strength) * tex.a;
}