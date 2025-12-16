uniform float uTime;
uniform vec3 uColor1;
uniform vec3 uColor2;
uniform float uSpeed;

varying vec2 vUv;

void main() {
    float time = uTime * uSpeed;
    vec2 p = vUv;

    // Domain distortion / warping
    // We add sine waves to the coordinates to create "ripples" or flow
    
    // Wave layer 1
    float x = p.x;
    float y = p.y;
    
    float distortionX = sin(y * 6.0 + time * 0.7) * 0.2;
    float distortionY = cos(x * 4.0 + time * 0.3) * 0.2;
    
    x += distortionX;
    y += distortionY;
    
    // Wave layer 2 (finer detail)
    float distortionX2 = sin(y * 1.0 - time * 0.2) * 0.3;
    float distortionY2 = cos(x * 1.0 + time * 0.04) * 0.5;
    
    x += distortionX2;
    y += distortionY2;
    
    // Calculate a simple gradient based on the distorted coordinates
    // We'll use a diagonal gradient
    float t = (x + y) * 2.55;

    // Create a smooth mix, perhaps with a slight "noise" feel by layering another sin
    // This makes it feel less like a linear gradient and more like a cloud or liquid
    float fluid = sin(t * 1.2 + time * 1.2) * 0.45 + 0.5;
    
    // Mix the colors
    vec3 color = mix(uColor1, uColor2, fluid);
    
    // Add a subtle vignette or secondary flow to make it less flat
    float centerDist = length(vec2(x, y) - 1.5);
    color += sin(centerDist * 0.5 - time) * 0.005;

    gl_FragColor = vec4(color, 1.0);
}
