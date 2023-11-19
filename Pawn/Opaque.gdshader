shader_type canvas_item;

void fragment() {
  COLOR = texture(TEXTURE, UV); //read from texture
      // 将颜色中的黑色部分变为透明
    if (COLOR == vec4(0.0, 0.0, 0.0, 1.0)) {
        discard;
    }
	if (0.0<=COLOR.r&&COLOR.r<=0.1&&0.0<=COLOR.g&&COLOR.g<=0.1&&0.0<=COLOR.b&&COLOR.b<=0.1){
		discard;
	}
}