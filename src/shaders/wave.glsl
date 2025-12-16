uniform float uTime;
uniform vec3 uColor1;
uniform vec3 uColor2;
uniform float uSpeed;
varying vec2 vUv;

void main() {
  float wave = sin(vUv.y * 10.0 + uTime * uSpeed * 2.0) * 0.1;
  float gradient = vUv.x + wave;
  vec3 color = mix(uColor1, uColor2, gradient);
  gl_FragColor = vec4(color, 1.0);
}

