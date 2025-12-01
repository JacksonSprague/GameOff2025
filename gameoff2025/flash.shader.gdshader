shader_type canvas_item;

uniform float flash_strength = 0.0;
uniform float brightness_boost = 0.1; // tweak

void fragment() {
    vec4 tex = texture(TEXTURE, UV);
    vec4 base = vec4(tex.rgb * COLOR.rgb, tex.a);

    // apply a tiny brightening
    base.rgb = base.rgb + brightness_boost;

    vec4 flash = mix(base, vec4(1.0,1.0,1.0, base.a), flash_strength);
    COLOR = flash;
}