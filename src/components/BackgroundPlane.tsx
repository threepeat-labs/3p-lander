import { useMemo, useRef, useEffect } from 'react'
import { useFrame, useThree } from '@react-three/fiber'
import * as THREE from 'three'
import { shaders, ShaderType } from '../shaders'

interface BackgroundPlaneProps {
  position?: [number, number, number]
  scale?: [number, number, number]
  color1?: string
  color2?: string
  speed?: number
  shaderType?: ShaderType
  fillViewport?: boolean // New prop to enable viewport filling
}

const vertexShader = `
  varying vec2 vUv;
  void main() {
    vUv = uv;
    gl_Position = projectionMatrix * modelViewMatrix * vec4(position, 1.0);
  }
`

export default function BackgroundPlane({
  position = [0, 0, -10],
  scale: providedScale,
  color1 = '#552583',
  color2 = '#FDB927',
  speed = 0.1,
  shaderType = 'fluidGradient',
  fillViewport = true // Default to filling viewport
}: BackgroundPlaneProps) {
  const materialRef = useRef<THREE.ShaderMaterial>(null)
  const meshRef = useRef<THREE.Mesh>(null)
  const { camera, size } = useThree()

  // Calculate viewport size at the plane's distance
  const viewportScale = useMemo((): [number, number, number] => {
    if (!fillViewport || !camera || !(camera instanceof THREE.PerspectiveCamera)) {
      return providedScale || [20, 20, 1]
    }

    const distance = Math.abs(position[2] - camera.position.z)
    const fov = camera.fov * (Math.PI / 180) // Convert to radians
    const height = 2 * Math.tan(fov / 2) * distance
    const width = height * (size.width / size.height)

    // Add padding to ensure it covers the viewport (10% extra)
    return [width * 1.1, height * 1.1, 1]
  }, [camera, size, position, fillViewport, providedScale])

  const finalScale: [number, number, number] = providedScale || viewportScale

  // Create material once and reuse it
  const shaderMaterial = useMemo(() => {
    const fragmentShader = shaders[shaderType]

    return new THREE.ShaderMaterial({
      uniforms: {
        uTime: { value: 0 },
        uColor1: { value: new THREE.Color(color1) },
        uColor2: { value: new THREE.Color(color2) },
        uSpeed: { value: speed },
      },
      vertexShader: vertexShader,
      fragmentShader: fragmentShader,
    })
  }, []) // Empty deps - create once

  // Update shader when shaderType changes (more efficient than recreating material)
  useEffect(() => {
    if (materialRef.current && shaders[shaderType]) {
      // Update fragment shader without recreating the entire material
      materialRef.current.fragmentShader = shaders[shaderType]
      materialRef.current.needsUpdate = true
    }
  }, [shaderType])

  // Update uniforms when they change
  useEffect(() => {
    if (materialRef.current) {
      materialRef.current.uniforms.uColor1.value = new THREE.Color(color1)
      materialRef.current.uniforms.uColor2.value = new THREE.Color(color2)
      materialRef.current.uniforms.uSpeed.value = speed
    }
  }, [color1, color2, speed])

  useFrame((state) => {
    if (materialRef.current) {
      materialRef.current.uniforms.uTime.value = state.clock.elapsedTime
    }

    // Update scale if viewport size changes (responsive)
    if (fillViewport && meshRef.current && camera instanceof THREE.PerspectiveCamera) {
      const distance = Math.abs(position[2] - camera.position.z)
      const fov = camera.fov * (Math.PI / 180)
      const height = 2 * Math.tan(fov / 2) * distance
      const width = height * (size.width / size.height)

      meshRef.current.scale.set(width * 1.1, height * 1.1, 1)
    }
  })

  return (
    <mesh ref={meshRef} position={position} scale={finalScale}>
      <planeGeometry args={[1, 1]} />
      <shaderMaterial ref={materialRef} {...shaderMaterial} />
    </mesh>
  )
}