import noiseShader from './noise.glsl?raw'
import radialShader from './radial.glsl?raw'
import waveShader from './wave.glsl?raw'
import nailsShader from './nails.glsl?raw'
import waveInterferenceShader from './wave-interference.glsl?raw'
import lavaLampShader from './lava-lamp.glsl?raw'
import fluidGradientShader from './fluid-gradient.glsl?raw'

export const shaders = {
  noise: noiseShader,
  radial: radialShader,
  wave: waveShader,
  nails: nailsShader,
  waveInterference: waveInterferenceShader,
  lavaLamp: lavaLampShader,
  fluidGradient: fluidGradientShader,
} as const

export type ShaderType = keyof typeof shaders

