import { Text3D } from '@react-three/drei'
import { useResponsive } from '../hooks/useResponsive'
import FloatingShapes from './FloatingShapes'
import HeroText from './HeroText'
import BackgroundPlane from './BackgroundPlane'


function Scene() {
  const { scaleFactor } = useResponsive()


  return (
    <>
      <BackgroundPlane
        position={[0, 0, -10]}
        fillViewport={true}
        color2="#FDB927"
        color1="#552583"
        speed={0.25}
        shaderType="fluidGradient"
      />
      <FloatingShapes />
      <HeroText />

      {/* 3D Text Examples with Depth */}
      <Text3D
        font="/fonts/BBH_Bartle_Regular.json"
        size={0.1 * scaleFactor}
        height={0.2 * scaleFactor}
        curveSegments={8}
        bevelEnabled
        bevelThickness={0.015 * scaleFactor}
        bevelSize={0.015 * scaleFactor}
        position={[-3 * scaleFactor, -2 * scaleFactor, 0]}
      >
        <meshPhysicalMaterial
          color="cyan"
          transmission={1}
          opacity={1}
          roughness={0.2}
          thickness={1}
        />
      </Text3D>

      <Text3D
        font="/fonts/BBH_Bartle_Regular.json"
        size={0.25 * scaleFactor}
        height={0.15 * scaleFactor}
        curveSegments={8}
        bevelEnabled
        bevelThickness={0.01 * scaleFactor}
        bevelSize={0.01 * scaleFactor}
        position={[3 * scaleFactor, -2 * scaleFactor, 0]}
      >

        <meshStandardMaterial color="black" />
      </Text3D>
    </>
  )
}

export default Scene
