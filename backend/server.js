const express = require('express');
const cors = require('cors');
const dotenv = require('dotenv');

// Load environment variables
dotenv.config();

const app = express();
const PORT = process.env.PORT || 3000;

// Middleware
app.use(cors());
app.use(express.json({ limit: '10mb' }));
app.use(express.urlencoded({ extended: true, limit: '10mb' }));

// SQLite Database Connection
const db = require('./config/database-sqlite');

// Add database to request object
app.use((req, res, next) => {
    req.db = db;
    next();
});

// Health check endpoint
app.get('/health', (req, res) => {
    res.json({ 
        status: 'OK', 
        message: 'School Management System API is running',
        database: 'SQLite',
        timestamp: new Date().toISOString()
    });
});

// Routes
const authRoutes = require('./routes/auth');
const schoolRoutes = require('./routes/school');
const studentRoutes = require('./routes/student');
const attendanceRoutes = require('./routes/attendance');

// Use routes
app.use('/api/auth', authRoutes);
app.use('/api/school', schoolRoutes);
app.use('/api/student', studentRoutes);
app.use('/api/attendance', attendanceRoutes);

// Error handling middleware
app.use((err, req, res, next) => {
    console.error('Error:', err);
    res.status(500).json({ 
        success: false, 
        message: 'Internal server error',
        error: process.env.NODE_ENV === 'development' ? err.message : undefined
    });
});

// 404 handler
app.use('*', (req, res) => {
    res.status(404).json({ 
        success: false, 
        message: 'API endpoint not found' 
    });
});

// Start server
app.listen(PORT, () => {
    console.log('🚀 School Management System API Server Started!');
    console.log(`📍 Server: http://localhost:${PORT}`);
    console.log(`🔍 Health Check: http://localhost:${PORT}/health`);
    console.log(`💾 Database: SQLite (school.db)`);
    console.log(`⏰ Started at: ${new Date().toLocaleString()}`);
    console.log('✅ Ready to handle requests!');
});

// Graceful shutdown
process.on('SIGINT', async () => {
    console.log('\n🛑 Shutting down server...');
    try {
        await db.close();
        console.log('💾 Database connection closed');
        process.exit(0);
    } catch (err) {
        console.error('Error during shutdown:', err);
        process.exit(1);
    }
});

module.exports = app;