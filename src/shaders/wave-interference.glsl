uniform float uTime;
uniform vec3 uColor1;
uniform vec3 uColor2;
uniform float uSpeed;
varying vec2 vUv;

// Physics-based wave interference shader
// Based on wave superposition and interference patterns

float random(vec2 st) {
  return fract(sin(dot(st.xy, vec2(12.9898, 78.233))) * 43758.5453123);
}

// 2D Noise function
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

// Wave function: A * sin(k * r - ω * t + φ)
// Where: A = amplitude, k = wave number, r = position, ω = angular frequency, t = time, φ = phase
float wave(vec2 pos, vec2 center, float frequency, float speed, float phase) {
  float r = distance(pos, center);
  float k = frequency; // Wave number
  float omega = speed; // Angular frequency
  return sin(k * r - omega * uTime * uSpeed + phase);
}

// Multiple wave interference (superposition principle)
float waveInterference(vec2 uv) {
  // Create multiple wave sources
  vec2 source1 = vec2(0.3, 0.3);
  vec2 source2 = vec2(0.7, 0.3);
  vec2 source3 = vec2(0.5, 0.7);
  vec2 source4 = vec2(0.2, 0.8);
  vec2 source5 = vec2(0.8, 0.6);
  
  // Each wave source with different parameters
  float w1 = wave(uv, source1, 15.0, 2.0, 0.0);
  float w2 = wave(uv, source2, 18.0, -2.5, 1.57);
  float w3 = wave(uv, source3, 12.0, 1.8, 3.14);
  float w4 = wave(uv, source4, 20.0, -1.5, 4.71);
  float w5 = wave(uv, source5, 16.0, 2.2, 0.0);
  
  // Superposition: sum of all waves
  float interference = (w1 + w2 + w3 + w4 + w5) / 5.0;
  
  return interference;
}

// Turbulence using Perlin-like noise (simplified Navier-Stokes turbulence)
float turbulence(vec2 uv, float time) {
  float value = 0.0;
  float amplitude = 0.5;
  float frequency = 1.0;
  
  // Octaves for fractal-like turbulence
  for (int i = 0; i < 4; i++) {
    value += amplitude * noise(uv * frequency + time * 0.1);
    frequency *= 2.0;
    amplitude *= 0.5;
  }
  
  return value;
}

// Flow field visualization (like fluid dynamics)
vec2 flowField(vec2 uv, float time) {
  float angle = noise(uv * 3.0 + time * 0.2) * 6.28318; // 2π
  float strength = noise(uv * 2.0 + time * 0.15) * 0.1;
  return vec2(cos(angle), sin(angle)) * strength;
}

// Standing wave pattern (like Chladni figures)
float standingWave(vec2 uv) {
  float nx = 3.0; // Number of nodes in x
  float ny = 4.0; // Number of nodes in y
  float waveX = sin(uv.x * nx * 3.14159 + uTime * uSpeed * 0.5);
  float waveY = sin(uv.y * ny * 3.14159 + uTime * uSpeed * 0.3);
  return waveX * waveY;
}

void main() {
  vec2 uv = vUv;
  float time = uTime * uSpeed;
  
  // Wave interference pattern
  float interference = waveInterference(uv);
  
  // Add turbulence for complexity
  float turb = turbulence(uv * 2.0, time);
  
  // Standing wave pattern
  float standing = standingWave(uv);
  
  // Combine all effects
  float pattern = interference * 0.6 + turb * 0.3 + standing * 0.1;
  
  // Normalize to 0-1 range
  pattern = pattern * 0.5 + 0.5;
  
  // Create color gradient based on interference
  vec3 color1 = uColor1;
  vec3 color2 = uColor2;
  
  // Mix colors based on wave pattern
  vec3 color = mix(color1, color2, pattern);
  
  // Add flow field visualization (subtle)
  vec2 flow = flowField(uv, time);
  color += vec3(flow.x * 0.1, flow.y * 0.1, 0.0);
  
  // Enhance contrast for visibility
  color = pow(color, vec3(0.8));
  
  // Add bright highlights at wave peaks
  float peaks = step(0.7, pattern);
  color += vec3(peaks * 0.2);
  
  // Clamp and finalize
  color = clamp(color, 0.0, 1.0);
  
  gl_FragColor = vec4(color, 1.0);
}

