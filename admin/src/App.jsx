import React, { useEffect, useState } from 'react'
import axios from 'axios'

export default function App(){
  const [campuses, setCampuses] = useState([])
  useEffect(() => {
    // placeholder: load campuses from backend when available
  }, [])
  return (
    <div style={{padding:20}}>
      <h1>Campus AR - Admin</h1>
      <p>This is a starter admin UI. Use it to upload floor plans and place nodes/beacons.</p>
      <section>
        <h2>Upload floor plan</h2>
        <input type="file" />
        <button>Upload (not implemented)</button>
      </section>
    </div>
  )
}
