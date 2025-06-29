const jwt = require('jsonwebtoken');
const db = require('../config/database-sqlite');

const authMiddleware = async (req, res, next) => {
    try {
        // Get token from header
        const token = req.header('Authorization')?.replace('Bearer ', '');
        
        if (!token) {
            return res.status(401).json({
                success: false,
                message: 'प्रमाणीकरण आवश्यक आहे. कृपया लॉगिन करा.'
            });
        }

        // Verify token
        const decoded = jwt.verify(token, process.env.JWT_SECRET || 'school_management_secret_key');
        
        // Check if user still exists and is active
        const user = await db.get(
            'SELECT id, school_id, role, is_active FROM users WHERE id = ? AND is_active = 1',
            [decoded.userId]
        );

        if (!user) {
            return res.status(401).json({
                success: false,
                message: 'अवैध प्रमाणीकरण. कृपया पुन्हा लॉगिन करा.'
            });
        }

        // Attach user info to request
        req.user = {
            userId: decoded.userId,
            schoolId: decoded.schoolId,
            role: decoded.role
        };

        next();

    } catch (error) {
        if (error.name === 'JsonWebTokenError') {
            return res.status(401).json({
                success: false,
                message: 'अवैध टोकन. कृपया पुन्हा लॉगिन करा.'
            });
        }
        
        if (error.name === 'TokenExpiredError') {
            return res.status(401).json({
                success: false,
                message: 'टोकन कालबाह्य झाला आहे. कृपया पुन्हा लॉगिन करा.'
            });
        }

        console.error('Auth middleware error:', error);
        return res.status(500).json({
            success: false,
            message: 'प्रमाणीकरण त्रुटी'
        });
    }
};

module.exports = authMiddleware;