import { ThemeProvider } from '@/context/ThemeContext'
import { Explorer } from '@/pages/Explorer'

function App() {
  return (
    <ThemeProvider>
      <Explorer />
    </ThemeProvider>
  )
}

export default App
