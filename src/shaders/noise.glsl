uniform float uTime;
uniform vec3 uColor1;
uniform vec3 uColor2;
uniform float uSpeed;
varying vec2 vUv;

float noise(vec2 p) {
  return fract(sin(dot(p, vec2(12.9898, 78.233))) * 43758.5453);
}

void main() {
  vec2 p = vUv * 10.0 + uTime * uSpeed;
  float n = noise(p);
  vec3 color = mix(uColor1, uColor2, n);
  gl_FragColor = vec4(color, 1.0);
}

