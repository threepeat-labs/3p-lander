uniform float uTime;
uniform vec3 uColor1;
uniform vec3 uColor2;
uniform float uSpeed;

varying vec2 vUv;

// Function to calculate influence of a blob
float blob(vec2 uv, vec2 center, float radius) {
    vec2 d = uv - center;
    float dist = length(d);
    
    // Standard metaball function: r / d
    // We modify it slightly for better visuals and to avoid division by zero
    return radius / (dist + 0.001);
}

void main() {
    float time = uTime * uSpeed;
    
    // Normalize UV from 0..1 to -1..1 for easier centering
    vec2 p = vUv * 2.0 - 1.0;
    
    // Define blobs with different trajectories interactively
    float f = 0.0;
    
    // Blob 1
    vec2 pos1 = vec2(
        sin(time * 0.8) * 0.6,
        cos(time * 0.5) * 0.6
    );
    f += blob(p, pos1, 0.35);
    
    // Blob 2
    vec2 pos2 = vec2(
        sin(time * 0.4 + 2.0) * 0.7,
        cos(time * 0.3 + 1.5) * 0.5
    );
    f += blob(p, pos2, 0.3);
    
    // Blob 3
    vec2 pos3 = vec2(
        sin(time * 0.6 + 4.0) * 0.5,
        cos(time * 0.7 + 3.0) * 0.7
    );
    f += blob(p, pos3, 0.0);
     
    // Blob 4
    vec2 pos4 = vec2(
        sin(time * 0.3 + 1.0) * 0.8,
        sin(time * 0.4 + 4.0) * 0.4
    );
    f += blob(p, pos4, 1.25);
    
    // Smoothing the field
    // We want a clear separation but with a smooth edge
    // Threshold is around 1.0 for metaballs sum, but we can tweak
    
    float threshold = 1.2;
    float edge = 1.5;
    
    float mask = smoothstep(threshold, threshold + edge, f);
    
    // Mix colors
    // Background is uColor1, Blobs are uColor2 (or vice versa depending on preference)
    vec3 color = mix(uColor1, uColor2, mask);
    
    // Add a bit of gradient to the background based on position for depth
    float bgGradient = length(p) * 1.5;
    color = mix(color, uColor2 * 0.5, 1.0 - mask); // Darken the outside slightly
    
    // Final mix
    vec3 finalColor = mix(uColor1 - bgGradient * 0.4, uColor2, mask);

    gl_FragColor = vec4(finalColor, 2.0);
}
