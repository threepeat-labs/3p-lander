uniform float uTime;
uniform vec3 uColor1;
uniform vec3 uColor2;
uniform float uSpeed;
varying vec2 vUv;

void main() {
  vec2 center = vec2(0.5, 0.5);
  float dist = distance(vUv, center);
  float gradient = sin(dist * 5.0 - uTime * uSpeed) * 0.5 + 0.5;
  vec3 color = mix(uColor1, uColor2, gradient);
  gl_FragColor = vec4(color, 1.0);
}

