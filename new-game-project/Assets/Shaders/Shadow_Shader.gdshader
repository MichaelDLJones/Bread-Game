shader_type canvas_item;

void vertex() {
	// Called for every vertex the material is visible on.
}

void fragment() {
	// Called for every pixel the material is visible on.
	vec4 tex = texture(TEXTURE, UV);
	//vec4 tex_a = vec4(tex.r, tex.g, tex.b, tex.a * 0.8);
	COLOR = vec4(0.0,0.0,0.0,((1.0 - tex.r) * 0.7));
}

//void light() {
	// Called for every pixel for every light affecting the CanvasItem.
	// Uncomment to replace the default light processing function with this one.
//}
