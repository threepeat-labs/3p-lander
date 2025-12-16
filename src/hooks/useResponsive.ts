import { useThree } from '@react-three/fiber'

export function useResponsive() {
    const { width } = useThree((state) => state.viewport)

    const isMobile = width < 6
    const isTablet = width >= 6 && width < 10
    const isDesktop = width >= 10

    // Calculate a scale factor that gently shrinks things on mobile
    // Base width of ~15 is effectively "1.0" scale
    const scaleFactor = Math.min(1, width / 15)

    return {
        viewportWidth: width,
        isMobile,
        isTablet,
        isDesktop,
        scaleFactor
    }
}
