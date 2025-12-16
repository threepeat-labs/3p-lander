uniform float uTime;
uniform vec3 uColor1;
uniform vec3 uColor2;
uniform float uSpeed;
varying vec2 vUv;

// Industrial noise functions
float random(vec2 st) {
  return fract(sin(dot(st.xy, vec2(12.9898, 78.233))) * 43758.5453123);
}

float noise(vec2 st) {
  vec2 i = floor(st);
  vec2 f = fract(st);
  float a = random(i);
  float b = random(i + vec2(1.0, 0.0));
  float c = random(i + vec2(0.0, 1.0));
  float d = random(i + vec2(1.0, 1.0));
  vec2 u = f * f * (3.0 - 2.0 * f);
  return mix(a, b, u.x) + (c - a) * u.y * (1.0 - u.x) + (d - b) * u.x * u.y;
}

// Aggressive glitch distortion - NIN style
vec2 glitchDistort(vec2 uv, float time) {
  // Horizontal digital glitch
  float glitch = step(0.85, random(vec2(time * 0.15, floor(uv.y * 30.0))));
  uv.x += glitch * (random(vec2(time * 2.0, uv.y)) - 0.5) * 0.15;
  
  // Vertical displacement
  float vGlitch = step(0.9, random(vec2(time * 0.1, floor(uv.x * 20.0))));
  uv.y += vGlitch * (random(vec2(time * 1.5)) - 0.5) * 0.08;
  
  return uv;
}

// Circuit board / data stream pattern
float circuitPattern(vec2 uv, float time) {
  vec2 grid = floor(uv * vec2(25.0, 40.0));
  float pattern = step(0.7, random(grid + time * 0.1));
  return pattern * 0.4;
}

// Broken scanline effect
float brokenScanline(vec2 uv, float time) {
  float line = floor(uv.y * 600.0);
  float broken = step(0.95, random(vec2(line, time * 0.2)));
  float scan = sin(uv.y * 1000.0 + time * 8.0) * 0.03;
  return scan * (1.0 - broken * 0.8);
}

void main() {
  vec2 uv = vUv;
  float time = uTime * uSpeed;
  
  // Heavy chromatic aberration (RGB split) - signature NIN effect
  float glitchIntensity = step(0.88, random(vec2(time * 0.25, floor(uv.y * 15.0))));
  float aberration = glitchIntensity * 0.03;
  
  float r = noise(glitchDistort(uv + vec2(aberration, 0.0), time) * 12.0 + time * 0.3);
  float g = noise(glitchDistort(uv, time) * 12.0 + time * 0.3);
  float b = noise(glitchDistort(uv - vec2(aberration, 0.0), time) * 12.0 + time * 0.3);
  
  // Base dark industrial color
  vec3 color = vec3(r * 0.15, g * 0.12, b * 0.15);
  
  // Circuit board pattern
  color += vec3(circuitPattern(uv, time));
  
  // Aggressive grid overlay
  vec2 gridUv = glitchDistort(uv, time);
  float gridX = step(0.97, fract(gridUv.x * 25.0));
  float gridY = step(0.97, fract(gridUv.y * 35.0));
  float grid = max(gridX, gridY) * 0.5;
  color += vec3(grid);
  
  // Heavy static interference
  float staticNoise = noise(uv * 25.0 + time * 2.0);
  float interference = step(0.65, staticNoise) * 0.6;
  color += vec3(interference);
  
  // Broken scanlines
  color += vec3(brokenScanline(uv, time));
  
  // Data corruption waves
  float corruption = sin(uv.y * 8.0 + time * 3.0) * sin(uv.x * 6.0 - time * 2.0);
  corruption *= step(0.5, random(vec2(floor(uv.y * 10.0), time * 0.1)));
  color += vec3(corruption * 0.15);
  
  // Vertical data streams
  float stream = step(0.98, fract(uv.x * 30.0 + time * 0.5));
  stream *= step(0.3, random(vec2(floor(uv.x * 30.0), time * 0.05)));
  color += vec3(stream * 0.3);
  
  // High contrast industrial look
  color = pow(color, vec3(0.6));
  
  // Occasional bright white flashes (like corrupted data)
  float flash = step(0.97, random(vec2(time * 0.08)));
  color += vec3(flash * 0.5);
  
  // Dark vignette edges
  vec2 center = vec2(0.5, 0.5);
  float dist = distance(uv, center);
  float vignette = smoothstep(0.7, 1.4, dist);
  color *= (1.0 - vignette * 0.4);
  
  // Clamp and finalize
  color = clamp(color, 0.0, 1.0);
  
  // Add slight color tint (industrial gray with hints)
  color = mix(color, vec3(color.r * 0.9, color.g * 0.95, color.b * 1.1), 0.1);
  
  gl_FragColor = vec4(color, 1.0);
}
