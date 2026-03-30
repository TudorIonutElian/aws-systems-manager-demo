export default function App() {
  return (
    <div style={styles.container}>
      <div style={styles.orb1} />
      <div style={styles.orb2} />
      <div style={styles.orb3} />
      <h1 style={styles.text}>Demo</h1>
    </div>
  )
}

const styles = {
  container: {
    position: 'relative',
    display: 'flex',
    justifyContent: 'center',
    alignItems: 'center',
    height: '100vh',
    background: 'linear-gradient(135deg, #0f0c29, #302b63, #24243e)',
    overflow: 'hidden',
  },
  orb1: {
    position: 'absolute',
    width: '500px',
    height: '500px',
    borderRadius: '50%',
    background: 'radial-gradient(circle, rgba(99,102,241,0.35) 0%, transparent 70%)',
    top: '-100px',
    left: '-100px',
    animation: 'drift 10s ease-in-out infinite alternate',
  },
  orb2: {
    position: 'absolute',
    width: '400px',
    height: '400px',
    borderRadius: '50%',
    background: 'radial-gradient(circle, rgba(236,72,153,0.3) 0%, transparent 70%)',
    bottom: '-80px',
    right: '-80px',
    animation: 'drift 13s ease-in-out infinite alternate-reverse',
  },
  orb3: {
    position: 'absolute',
    width: '300px',
    height: '300px',
    borderRadius: '50%',
    background: 'radial-gradient(circle, rgba(34,211,238,0.25) 0%, transparent 70%)',
    top: '50%',
    left: '55%',
    animation: 'drift 8s ease-in-out infinite alternate',
  },
  text: {
    position: 'relative',
    fontSize: 'clamp(5rem, 15vw, 12rem)',
    fontWeight: '800',
    fontFamily: "'Segoe UI', system-ui, sans-serif",
    letterSpacing: '-0.02em',
    background: 'linear-gradient(135deg, #fff 30%, rgba(255,255,255,0.55))',
    WebkitBackgroundClip: 'text',
    WebkitTextFillColor: 'transparent',
    backgroundClip: 'text',
    filter: 'drop-shadow(0 0 40px rgba(99,102,241,0.6))',
    userSelect: 'none',
  },
}

const styleTag = document.createElement('style')
styleTag.textContent = `
  @keyframes drift {
    from { transform: translate(0, 0) scale(1); }
    to   { transform: translate(40px, 30px) scale(1.1); }
  }
`
document.head.appendChild(styleTag)
