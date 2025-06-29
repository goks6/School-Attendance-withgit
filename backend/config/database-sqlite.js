const sqlite3 = require('sqlite3').verbose();
const path = require('path');
const fs = require('fs');
const bcrypt = require('bcryptjs');

class Database {
    constructor() {
        // Ensure the backend directory exists and is writable
        const dbDir = path.join(__dirname, '..');
        const dbPath = path.join(dbDir, 'school.db');
        
        // Create directory if it doesn't exist
        if (!fs.existsSync(dbDir)) {
            fs.mkdirSync(dbDir, { recursive: true });
        }
        
        console.log('📍 Database path:', dbPath);
        
        // Initialize database with error handling
        try {
            this.db = new sqlite3.Database(dbPath, (err) => {
                if (err) {
                    console.error('❌ Database connection failed:', err.message);
                    // Fallback to in-memory database
                    console.log('🔄 Falling back to in-memory database...');
                    this.db = new sqlite3.Database(':memory:');
                    this.init();
                } else {
                    console.log('✅ SQLite database connected successfully');
                    this.init();
                }
            });
        } catch (error) {
            console.error('❌ Database initialization error:', error);
            // Use in-memory database as fallback
            this.db = new sqlite3.Database(':memory:');
            this.init();
        }
    }

    init() {
        this.db.serialize(() => {
            // Schools table
            this.db.run(`
                CREATE TABLE IF NOT EXISTS schools (
                    id INTEGER PRIMARY KEY AUTOINCREMENT,
                    name TEXT NOT NULL,
                    udise_number TEXT UNIQUE,
                    address TEXT,
                    pin_code TEXT,
                    phone TEXT,
                    principal_name TEXT,
                    principal_mobile TEXT UNIQUE,
                    principal_email TEXT,
                    created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
                    updated_at DATETIME DEFAULT CURRENT_TIMESTAMP
                )
            `, (err) => {
                if (err) console.error('Error creating schools table:', err);
            });

            // Users table
            this.db.run(`
                CREATE TABLE IF NOT EXISTS users (
                    id INTEGER PRIMARY KEY AUTOINCREMENT,
                    school_id INTEGER,
                    name TEXT NOT NULL,
                    mobile TEXT UNIQUE NOT NULL,
                    email TEXT,
                    password TEXT NOT NULL,
                    role TEXT CHECK(role IN ('principal', 'teacher')),
                    class TEXT,
                    section TEXT,
                    is_active BOOLEAN DEFAULT 1,
                    last_login DATETIME,
                    created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
                    updated_at DATETIME DEFAULT CURRENT_TIMESTAMP,
                    FOREIGN KEY (school_id) REFERENCES schools(id)
                )
            `, (err) => {
                if (err) console.error('Error creating users table:', err);
            });

            // Students table
            this.db.run(`
                CREATE TABLE IF NOT EXISTS students (
                    id INTEGER PRIMARY KEY AUTOINCREMENT,
                    school_id INTEGER,
                    roll_number INTEGER,
                    name TEXT NOT NULL,
                    mother_name TEXT,
                    father_name TEXT,
                    date_of_birth DATE,
                    address TEXT,
                    parent_mobile TEXT,
                    aadhar_number TEXT,
                    student_id TEXT,
                    class TEXT,
                    section TEXT,
                    teacher_id INTEGER,
                    is_active BOOLEAN DEFAULT 1,
                    created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
                    updated_at DATETIME DEFAULT CURRENT_TIMESTAMP,
                    FOREIGN KEY (school_id) REFERENCES schools(id),
                    FOREIGN KEY (teacher_id) REFERENCES users(id)
                )
            `, (err) => {
                if (err) console.error('Error creating students table:', err);
            });

            // Attendance table
            this.db.run(`
                CREATE TABLE IF NOT EXISTS attendance (
                    id INTEGER PRIMARY KEY AUTOINCREMENT,
                    student_id INTEGER,
                    school_id INTEGER,
                    teacher_id INTEGER,
                    date DATE NOT NULL,
                    status TEXT CHECK(status IN ('present', 'absent', 'late')),
                    remarks TEXT,
                    marked_by INTEGER,
                    created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
                    updated_at DATETIME DEFAULT CURRENT_TIMESTAMP,
                    FOREIGN KEY (student_id) REFERENCES students(id),
                    FOREIGN KEY (school_id) REFERENCES schools(id),
                    FOREIGN KEY (teacher_id) REFERENCES users(id),
                    FOREIGN KEY (marked_by) REFERENCES users(id)
                )
            `, (err) => {
                if (err) console.error('Error creating attendance table:', err);
            });

            // Holidays table
            this.db.run(`
                CREATE TABLE IF NOT EXISTS holidays (
                    id INTEGER PRIMARY KEY AUTOINCREMENT,
                    school_id INTEGER,
                    date DATE NOT NULL,
                    reason TEXT,
                    created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
                    FOREIGN KEY (school_id) REFERENCES schools(id)
                )
            `, (err) => {
                if (err) console.error('Error creating holidays table:', err);
            });

            // Messages table (for study messages and notices)
            this.db.run(`
                CREATE TABLE IF NOT EXISTS messages (
                    id INTEGER PRIMARY KEY AUTOINCREMENT,
                    school_id INTEGER,
                    teacher_id INTEGER,
                    type TEXT CHECK(type IN ('study', 'notice')),
                    content TEXT NOT NULL,
                    date DATE NOT NULL,
                    created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
                    FOREIGN KEY (school_id) REFERENCES schools(id),
                    FOREIGN KEY (teacher_id) REFERENCES users(id)
                )
            `, (err) => {
                if (err) console.error('Error creating messages table:', err);
            });

            // Create sample data after all tables are created
            setTimeout(() => {
                this.createSampleData();
            }, 1000);
        });
    }

    async createSampleData() {
        try {
            // Check if sample data exists
            const schoolCount = await this.get("SELECT COUNT(*) as count FROM schools");
            
            if (schoolCount && schoolCount.count === 0) {
                console.log('🏫 Creating sample school data...');
                
                // Create sample school
                const schoolResult = await this.run(`
                    INSERT INTO schools (name, udise_number, address, pin_code, phone, principal_name, principal_mobile) 
                    VALUES (?, ?, ?, ?, ?, ?, ?)
                `, ['डेमो प्राथमिक शाळा', '123456789012', 'मुख्य रस्ता, नागपूर', '440001', '07123456789', 'श्री राम शर्मा', '9876543210']);
                
                // Create principal user
                const hashedPassword = await bcrypt.hash('9876543210', 10);
                await this.run(`
                    INSERT INTO users (school_id, name, mobile, password, role) 
                    VALUES (?, ?, ?, ?, ?)
                `, [1, 'श्री राम शर्मा', '9876543210', hashedPassword, 'principal']);

                // Create sample teacher
                const teacherPassword = await bcrypt.hash('9876543211', 10);
                await this.run(`
                    INSERT INTO users (school_id, name, mobile, password, role, class, section) 
                    VALUES (?, ?, ?, ?, ?, ?, ?)
                `, [1, 'सुनीता देवी', '9876543211', teacherPassword, 'teacher', '5', 'A']);

                // Create sample students
                const students = [
                    [1, 1, 'राहुल शर्मा', 'सुनीता शर्मा', 'राम शर्मा', '2015-05-15', 'नागपूर', '9876543212', '123456789012', 'STU001', '5', 'A', 2],
                    [1, 2, 'प्रिया पाटील', 'अनीता पाटील', 'सुनील पाटील', '2015-03-20', 'नागपूर', '9876543213', '123456789013', 'STU002', '5', 'A', 2],
                    [1, 3, 'अमित कुमार', 'सुनील कुमार', 'राज कुमार', '2015-07-10', 'नागपूर', '9876543214', '123456789014', 'STU003', '5', 'A', 2]
                ];

                for (const student of students) {
                    await this.run(`
                        INSERT INTO students (school_id, roll_number, name, mother_name, father_name, date_of_birth, address, parent_mobile, aadhar_number, student_id, class, section, teacher_id)
                        VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)
                    `, student);
                }

                console.log('✅ Sample data created successfully!');
                console.log('📱 Principal Login: 9876543210 / 9876543210');
                console.log('👨‍🏫 Teacher Login: 9876543211 / 9876543211');
            } else {
                console.log('📊 Database already contains data');
            }
        } catch (error) {
            console.error('Error creating sample data:', error);
        }
    }

    // Query method for SELECT statements
    query(sql, params = []) {
        return new Promise((resolve, reject) => {
            this.db.all(sql, params, (err, rows) => {
                if (err) {
                    console.error('Database query error:', err);
                    reject(err);
                } else {
                    resolve(rows);
                }
            });
        });
    }

    // Get single row
    get(sql, params = []) {
        return new Promise((resolve, reject) => {
            this.db.get(sql, params, (err, row) => {
                if (err) {
                    console.error('Database get error:', err);
                    reject(err);
                } else {
                    resolve(row);
                }
            });
        });
    }

    // Run method for INSERT, UPDATE, DELETE
    run(sql, params = []) {
        return new Promise((resolve, reject) => {
            this.db.run(sql, params, function(err) {
                if (err) {
                    console.error('Database run error:', err);
                    reject(err);
                } else {
                    resolve({
                        id: this.lastID,
                        changes: this.changes
                    });
                }
            });
        });
    }

    // Execute method (alias for run)
    execute(sql, params = []) {
        return this.run(sql, params);
    }

    // Close database connection
    close() {
        return new Promise((resolve, reject) => {
            this.db.close((err) => {
                if (err) {
                    reject(err);
                } else {
                    console.log('💾 Database connection closed');
                    resolve();
                }
            });
        });
    }
}

// Export singleton instance
module.exports = new Database();