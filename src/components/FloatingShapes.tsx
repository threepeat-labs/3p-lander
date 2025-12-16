import { useRef } from 'react'
import { useFrame } from '@react-three/fiber'
import { Mesh } from 'three'
import { useResponsive } from '../hooks/useResponsive'


export default function FloatingShapes() {
    const octahedronRef = useRef<Mesh>(null)
    const sphereRef = useRef<Mesh>(null)
    const torusRef = useRef<Mesh>(null)

    const { viewportWidth, scaleFactor, isMobile } = useResponsive()

    // Calculate responsive positions
    const sideOffset = Math.max(2, viewportWidth / 2) // Ensure they don't get too close in very narrow views, but generally follow width

    const yPosition = isMobile ? 5 : 0


    useFrame((_state, delta) => {
        if (octahedronRef.current) {
            octahedronRef.current.rotation.x += delta * 0.5
            octahedronRef.current.rotation.y += delta * 0.3
        }
        if (sphereRef.current) {
            sphereRef.current.rotation.x += delta * 0.4
            sphereRef.current.rotation.y += delta * 0.2
        }
        if (torusRef.current) {
            torusRef.current.rotation.x += delta * 0.6
            torusRef.current.rotation.y += delta * 0.4
        }
    })

    return (
        <group layers={10}>

            <mesh ref={octahedronRef} position={[0, yPosition, -7]} scale={scaleFactor}>
                <octahedronGeometry args={[2, 0]} />
                <meshPhysicalMaterial
                    metalness={10}
                    roughness={0}
                    wireframe={false}
                    color="black" />
            </mesh>
            <mesh ref={sphereRef} position={[-sideOffset, yPosition, -7]} scale={scaleFactor}>
                <sphereGeometry args={[2, 32, 32]} />
                <meshPhysicalMaterial
                    color="black"
                    opacity={0}
                    roughness={1}
                    metalness={10}
                    wireframe={true}
                />
            </mesh>
            <mesh ref={torusRef} position={[sideOffset, yPosition, -7]} scale={scaleFactor}>
                <torusGeometry args={[2, 0.3, 16, 100]} />
                <meshPhysicalMaterial
                    color="black"
                    roughness={0.1}
                    wireframe={false}
                />
            </mesh>
        </group>
    )
}
