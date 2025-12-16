import { Canvas } from '@react-three/fiber'
import { Vector2 } from 'three'
import { Environment, OrbitControls, PerspectiveCamera } from '@react-three/drei'
import {
  EffectComposer,
  ChromaticAberration,
  Vignette,
  Noise,
} from '@react-three/postprocessing'
import {
  BlendFunction
} from 'postprocessing'


import Scene from './components/Scene'
import OverlayText from './components/OverlayText'
import './App.css'

function App() {

  return (
    <div className="app">
      <OverlayText
        title="3P-Labs"
        content="
At 3P-Labs, we engineer software with empathy. We believe that writing code is a creative pursuit designed to solve human problems. We look beyond the syntax to understand how people actually work, architecting software that unlocks better, faster workflows.
We believe software should feel human, intuitive, and genuinely helpful.
        
        "
      />
      <Canvas className="canvas">
        <Environment preset="studio" />
        <EffectComposer>

          <ChromaticAberration
            blendFunction={BlendFunction.AVERAGE}
            offset={new Vector2(-0.0001, 0.0001)}
            radialModulation={true}
            modulationOffset={1}
          />

          <Vignette eskil={true} offset={1} darkness={1.1} />
          <Noise opacity={0.08} />
        </EffectComposer>
        <PerspectiveCamera makeDefault position={[0, 0, 9]} />
        <ambientLight intensity={0} />

        <Scene />
        <OrbitControls enableZoom={false} enablePan={false} enableRotate={false} />
      </Canvas>
    </div>
  )
}

export default App

