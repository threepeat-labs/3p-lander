import { Text3D, Center } from '@react-three/drei'
import { useResponsive } from '../hooks/useResponsive'

export default function HeroText() {
    const { scaleFactor, isMobile } = useResponsive()

    const yPosition = isMobile ? 2.5 : 0

    return (
        <group layers={0}>
            <Center position={[0, yPosition, 1]} cacheKey={scaleFactor}>
                <Text3D
                    font="/fonts/BBH_Bartle_Regular.json"
                    size={0.8 * scaleFactor}
                    height={0.3 * scaleFactor}
                    curveSegments={16}
                    bevelEnabled
                    bevelThickness={0.01 * scaleFactor}
                    bevelSize={0.01 * scaleFactor}
                    bevelSegments={16}
                    letterSpacing={0.04}
                    castShadow
                >
                    3p-labs
                    <meshPhysicalMaterial
                        color="white"
                        roughness={10}      // Smooth front
                        metalness={0.2}      // Slight metallic for edge definition
                        clearcoat={1}      // Clear coat layer
                        clearcoatRoughness={0}
                        envMapIntensity={0.8}
                    />
                </Text3D>
            </Center>
        </group>
    )
}
