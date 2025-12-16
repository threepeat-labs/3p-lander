import React from 'react'

interface OverlayTextProps {
    title: string
    content: string
}

export default function OverlayText({ title, content }: OverlayTextProps) {
    return (
        <div className="overlay-container">
            <div className="glass-panel">
                <h2 className="d-none overlay-title">{title}</h2>
                <p className="overlay-content">{content}</p>
            </div>
        </div>
    )
}
