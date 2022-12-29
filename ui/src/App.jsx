import { useEffect, useRef } from "react"
import "./App.scss"

const App = () => {
    const audio = useRef()

    useEffect(() => {
        window.addEventListener("message", (event) => {
            const { data } = event

            if (data.action === "notification") {
                audio.current.play()
            }
        })

        return () => window.removeEventListener("message", () => {})
    }, [])

    return (
        <div className="app">
            <div className="app__header">
                <img src="logo.png" alt="Logo" />
            </div>
            
            <div className="app__content">
                <div className="app__content__image">
                    <img src="icon.png" alt="Smiley" />
                </div>

                <div className="app__content__text">
                    <span>Flitsmeister blijft je op de achtergrond op de hoogte houden</span>
                </div>
            </div>
            
            <audio ref={audio} autoPlay={false}>
                <source src="flitsmeister-sound.mp3" type="audio/mpeg" />
            </audio>
        </div>
    )
}

export default App
