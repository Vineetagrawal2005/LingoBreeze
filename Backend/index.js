const express = require('express')
const admin = require('firebase-admin')
const cors = require('cors')
const serviceAccount = require('./serviceAccountKey.json')

admin.initializeApp({
  credential: admin.credential.cert(serviceAccount)
})

const db = admin.firestore()
const app = express()

app.use(cors())
app.use(express.json())

app.get('/', (req, res) => {
  res.json({ status: 'ok', message: 'LingoBreeze API running!' })
})

app.get('/words', async (req, res) => {
  try {
    const snapshot = await db.collection('words').get()
    const words = []
    snapshot.forEach(doc => {
      words.push({ id: doc.id, ...doc.data() })
    })
    res.status(200).json(words)
  } catch (error) {
    console.error('Error:', error.message)
    res.status(500).json({ error: 'Failed to fetch words' })
  }
})

app.listen(3000, () => {
  console.log('LingoBreeze API running on http://localhost:3000')
})