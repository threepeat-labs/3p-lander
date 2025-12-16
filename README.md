# 3P Site - React Three Fiber Landing Page

A modern landing page built with React, Vite, and React Three Fiber.

## Features

- ⚡️ Vite for fast development and building
- ⚛️ React 18 with TypeScript
- 🎨 React Three Fiber for 3D graphics
- 📦 @react-three/drei for helpful utilities
- 🎯 Modern, responsive design

## Getting Started

### Prerequisites

- Node.js (v18 or higher recommended)
- npm or yarn

### Installation

1. Install dependencies:
```bash
npm install
```

2. Start the development server:
```bash
npm run dev
```

3. Open your browser and navigate to the URL shown in the terminal (usually `http://localhost:5173`)

### Build for Production

```bash
npm run build
```

The built files will be in the `dist` directory.

### Preview Production Build

```bash
npm run preview
```

## Project Structure

```
3p_site/
├── src/
│   ├── components/
│   │   └── Scene.tsx      # 3D scene component
│   ├── App.tsx             # Main app component
│   ├── App.css             # App styles
│   ├── main.tsx            # Entry point
│   └── index.css           # Global styles
├── index.html              # HTML template
├── package.json            # Dependencies
├── tsconfig.json           # TypeScript config
└── vite.config.ts          # Vite config
```

## Customization

The `Scene.tsx` component contains the 3D objects. You can modify it to create your own 3D scene. The `App.tsx` component contains the overall layout and can be customized to match your design needs.

## Resources

- [React Three Fiber Documentation](https://docs.pmnd.rs/react-three-fiber)
- [Three.js Documentation](https://threejs.org/docs/)
- [@react-three/drei Documentation](https://github.com/pmndrs/drei)

