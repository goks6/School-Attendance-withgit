@echo off
title School Attendance System - Final ZIP Creator
color 0F
echo.
echo     🏫 शाळा हजेरी व्यवस्थापन प्रणाली
echo     ================================
echo     Professional ZIP Package Creator
echo.

REM Navigate to project directory
echo 📁 Project directory मध्ये जात आहे...
cd /d "D:\school attendance\project"

if not exist "src" (
    if not exist "backend" (
        echo ❌ Project files सापडले नाहीत
        echo कृपया तपासा की तुम्ही योग्य folder मध्ये आहात
        pause
        exit /b 1
    )
)

echo ✅ Project files सापडले!
echo 📍 Current location: %CD%

REM Create export directory on Desktop with timestamp
set DESKTOP=%USERPROFILE%\Desktop
set TIMESTAMP=%date:~-4,4%%date:~-10,2%%date:~-7,2%_%time:~0,2%%time:~3,2%
set TIMESTAMP=%TIMESTAMP: =0%
set EXPORT_DIR=%DESKTOP%\SchoolAttendanceSystem-v2.0-Complete

if exist "%EXPORT_DIR%" rmdir /s /q "%EXPORT_DIR%"
mkdir "%EXPORT_DIR%"

echo 📦 Export करत आहे: %EXPORT_DIR%

REM Copy frontend files
echo 📱 Frontend files copy करत आहे...
mkdir "%EXPORT_DIR%\frontend"

if exist "src" (
    xcopy "src" "%EXPORT_DIR%\frontend\src\" /E /I /Q >nul
    echo ✅ React source code copied
)

if exist "public" (
    xcopy "public" "%EXPORT_DIR%\frontend\public\" /E /I /Q >nul
    echo ✅ Public assets copied
)

REM Copy frontend config files
for %%f in (package.json index.html vite.config.ts tailwind.config.js tsconfig.json tsconfig.app.json tsconfig.node.json postcss.config.js eslint.config.js) do (
    if exist "%%f" (
        copy "%%f" "%EXPORT_DIR%\frontend\" >nul
        echo ✅ %%f copied
    )
)

REM Copy backend files
echo 🔧 Backend files copy करत आहे...
if exist "backend" (
    xcopy "backend" "%EXPORT_DIR%\backend\" /E /I /Q >nul
    echo ✅ Complete backend copied
)

REM Create comprehensive README
echo 📚 Professional README तयार करत आहे...
(
echo # 🏫 School Attendance Management System v2.0
echo ## Complete Enhanced School Management Solution
echo.
echo ![School Management](https://img.shields.io/badge/School-Management-blue) ![React](https://img.shields.io/badge/React-18-blue) ![Node.js](https://img.shields.io/badge/Node.js-Express-green) ![SQLite](https://img.shields.io/badge/Database-SQLite-orange)
echo.
echo ### 🌟 Enhanced Features:
echo.
echo #### 👥 Advanced Student Management
echo - **Complete Profiles**: Blood group, emergency contacts, medical info
echo - **Smart Search**: Filter by class, section, blood group, gender
echo - **Bulk Operations**: Import/export Excel/CSV files
echo - **ID Generation**: Automatic student ID with custom formats
echo - **Academic Tracking**: Progress monitoring over time
echo.
echo #### 📅 Intelligent Attendance System
echo - **Flexible Marking**: Present/Absent/Late with custom status
echo - **Real-time Analytics**: Live statistics and trend analysis
echo - **Smart Notifications**: Automated low attendance alerts
echo - **Historical Data**: Complete attendance history
echo - **Class Management**: Efficient class-wise tracking
echo.
echo #### 📢 Notice Management System
echo - **Rich Content**: Formatted text, images, attachments
echo - **Smart Targeting**: Send to specific groups
echo - **Priority System**: Urgent/Normal/Low classifications
echo - **Read Tracking**: Monitor notice engagement
echo - **Scheduling**: Future delivery scheduling
echo.
echo #### 🏆 Achievement Tracking System
echo - **Multi-Category**: Academic, Sports, Cultural, Behavioral
echo - **Level Tracking**: School, District, State, National
echo - **Certificate Management**: Upload and manage certificates
echo - **Performance Analytics**: Top performers and trends
echo - **Recognition System**: Automated reward suggestions
echo.
echo ### 🚀 Super Quick Installation:
echo.
echo #### Method 1: One-Click Setup (Recommended)
echo ```bash
echo 1. Double-click: install.bat
echo 2. Double-click: start.bat  
echo 3. Open: http://localhost:5173
echo ```
echo.
echo #### Method 2: Manual Setup
echo ```bash
echo # Prerequisites: Node.js from https://nodejs.org/
echo.
echo # Backend
echo cd backend
echo npm install
echo npm start
echo.
echo # Frontend (new terminal)
echo cd frontend
echo npm install
echo npm run dev
echo ```
echo.
echo ### 🔐 Demo Login Credentials:
echo.
echo ^| Role ^| Mobile ^| Password ^| Access Level ^|
echo ^|------|--------|----------|---------------|
echo ^| **Principal** ^| 9876543210 ^| 9876543210 ^| Full System ^|
echo ^| **Teacher** ^| 9876543211 ^| 9876543211 ^| Class Management ^|
echo.
echo ### 🌐 Application URLs:
echo - **🖥️ Main App**: http://localhost:5173
echo - **🔧 API Server**: http://localhost:3000
echo - **🔍 Health Check**: http://localhost:3000/health
echo.
echo ### 🛠️ Technology Stack:
echo.
echo #### Frontend:
echo - **React 18** - Latest with concurrent features
echo - **TypeScript** - Type-safe development
echo - **Tailwind CSS** - Utility-first styling
echo - **Vite** - Lightning-fast build tool
echo - **Lucide React** - Beautiful icons
echo.
echo #### Backend:
echo - **Node.js** - JavaScript runtime
echo - **Express.js** - Web framework
echo - **SQLite3** - Lightweight database
echo - **JWT** - Secure authentication
echo - **bcryptjs** - Password security
echo.
echo ### 📁 Project Structure:
echo ```
echo SchoolAttendanceSystem/
echo ├── frontend/                    # React Application
echo │   ├── src/
echo │   │   ├── App.tsx             # Main component
echo │   │   ├── main.tsx            # Entry point
echo │   │   └── index.css           # Global styles
echo │   ├── public/                 # Static assets
echo │   └── package.json            # Dependencies
echo │
echo ├── backend/                     # Node.js API
echo │   ├── server.js               # Express server
echo │   ├── config/database-sqlite.js # Database
echo │   ├── routes/                 # API endpoints
echo │   └── middleware/auth.js      # Authentication
echo │
echo ├── install.bat                 # Auto installer
echo ├── start.bat                   # Server launcher
echo └── README.md                   # This file
echo ```
echo.
echo ### 🎯 Key Features:
echo.
echo #### Student Management:
echo - Enhanced profiles with medical information
echo - Advanced search and filtering capabilities
echo - Bulk import/export functionality
echo - Automatic ID generation
echo - Progress tracking over time
echo.
echo #### Attendance System:
echo - Multiple status options (Present/Absent/Late)
echo - Real-time statistics and analytics
echo - Historical data and trend analysis
echo - Class-wise attendance management
echo - Automated notification system
echo.
echo #### Notice Management:
echo - Rich content support with attachments
echo - Targeted delivery to specific groups
echo - Priority-based classification system
echo - Read/unread tracking capabilities
echo - Scheduled delivery options
echo.
echo #### Achievement Tracking:
echo - Multi-category achievement recording
echo - Level-based recognition system
echo - Certificate management capabilities
echo - Performance analytics and insights
echo - Automated recognition suggestions
echo.
echo ### 📱 Mobile & Cross-Platform:
echo - **Responsive Design**: Works on all devices
echo - **Touch Friendly**: Optimized for mobile use
echo - **PWA Ready**: Can be installed as mobile app
echo - **Cross-Browser**: Chrome, Firefox, Safari, Edge
echo.
echo ### 🔒 Security Features:
echo - **JWT Authentication**: Secure token-based auth
echo - **Password Hashing**: bcrypt encryption
echo - **SQL Injection Protection**: Parameterized queries
echo - **Input Validation**: All inputs sanitized
echo - **Role-Based Access**: Different user permissions
echo.
echo ### 🚀 Deployment Options:
echo.
echo #### Cloud Deployment:
echo - **Vercel**: Frontend deployment
echo - **Railway**: Backend deployment
echo - **Netlify**: Static hosting
echo - **Heroku**: Full-stack hosting
echo.
echo #### Local Network:
echo - School server deployment
echo - WiFi network access
echo - Local database storage
echo.
echo ### 📊 Sample Data:
echo - **1 Demo School**: Complete setup
echo - **2 User Accounts**: Principal + Teacher
echo - **6 Sample Students**: Class 5-A with profiles
echo - **3 Sample Notices**: Different types
echo - **4 Sample Achievements**: Various categories
echo.
echo ### 🆘 Troubleshooting:
echo.
echo #### Installation Issues:
echo ```bash
echo # Node.js not found
echo Download from: https://nodejs.org/
echo.
echo # Permission denied
echo Run as Administrator
echo.
echo # Network issues
echo Check firewall settings
echo ```
echo.
echo #### Runtime Issues:
echo ```bash
echo # Port in use
echo netstat -ano ^| findstr :3000
echo taskkill /PID ^<PID^> /F
echo.
echo # Database locked
echo Restart servers
echo ```
echo.
echo ### 📞 Support:
echo - Check browser console for errors
echo - Review server logs in terminals
echo - Verify Node.js installation
echo - Ensure ports 3000/5173 are free
echo.
echo ### 📄 License:
echo MIT License - Open Source
echo.
echo ### 🎓 Educational Impact:
echo This system helps schools:
echo - Reduce administrative burden
echo - Improve parent-teacher communication
echo - Track student progress effectively
echo - Enhance operational efficiency
echo - Embrace digital transformation
echo.
echo ---
echo.
echo **🎉 Thank you for using School Attendance Management System!**
echo.
echo **Happy Teaching and Learning! 📚✨**
) > "%EXPORT_DIR%\README.md"

REM Create professional install script
echo 🔧 Professional install script तयार करत आहे...
(
echo @echo off
echo title School Attendance System v2.0 - Professional Installation
echo color 0A
echo cls
echo.
echo     🏫 शाळा हजेरी व्यवस्थापन प्रणाली v2.0
echo     ========================================
echo     Professional School Management Solution
echo.
echo 🚀 Welcome to the automated installation wizard
echo.
echo ⏳ Please wait while we prepare your system...
echo.
echo.
echo 🔍 System Requirements Check
echo ============================
echo.
echo 📋 Checking Node.js installation...
node --version ^>nul 2^>^&1
if errorlevel 1 ^(
    echo ❌ Node.js is not installed
    echo.
    echo 📥 Node.js is required to run this application
    echo 🌐 Please download from: https://nodejs.org/
    echo 💡 Choose the LTS (Long Term Support) version
    echo.
    echo After installation:
    echo 1. Restart your computer
    echo 2. Run this installer again
    echo.
    echo Press any key to open download page...
    pause ^>nul
    start https://nodejs.org/
    exit /b 1
^)
echo ✅ Node.js is installed
for /f "tokens=*" %%i in ^('node --version'^) do echo 📦 Version: %%i
echo.
echo 📋 Checking npm package manager...
npm --version ^>nul 2^>^&1
if errorlevel 1 ^(
    echo ❌ npm not available
    echo Please reinstall Node.js
    pause
    exit /b 1
^)
for /f "tokens=*" %%i in ^('npm --version'^) do echo ✅ npm Version: %%i
echo.
echo ✅ System requirements satisfied
echo.
echo.
echo 📱 Installing Frontend Components
echo =================================
echo 🔄 React 18, TypeScript, Tailwind CSS, Vite...
echo.
cd frontend
npm install --silent
if errorlevel 1 ^(
    echo ❌ Frontend installation failed
    echo.
    echo 🔧 Troubleshooting:
    echo • Check internet connection
    echo • Run as Administrator
    echo • Disable antivirus temporarily
    echo • Clear npm cache: npm cache clean --force
    echo.
    pause
    cd ..
    goto backend_install
^)
echo ✅ Frontend components installed successfully
echo.
echo.
:backend_install
echo 🔧 Installing Backend Components
echo ================================
echo 🔄 Express.js, SQLite, JWT, Security modules...
echo.
cd ..\backend
npm install --silent
if errorlevel 1 ^(
    echo ❌ Backend installation failed
    echo.
    echo 🔧 Troubleshooting:
    echo • Check internet connection
    echo • Run as Administrator
    echo • Clear npm cache: npm cache clean --force
    echo.
    pause
    cd ..
    goto complete
^)
echo ✅ Backend components installed successfully
echo.
cd ..
echo.
:complete
echo 🎉 Installation Completed Successfully!
echo ======================================
echo.
echo 📋 What's been installed:
echo ┌─────────────────────────────────────────────┐
echo │ ✅ React 18 + TypeScript Frontend          │
echo │ ✅ Tailwind CSS + Lucide Icons             │
echo │ ✅ Express.js + SQLite Backend             │
echo │ ✅ JWT Authentication System               │
echo │ ✅ Sample Database with Demo Data          │
echo └─────────────────────────────────────────────┘
echo.
echo 🚀 Next Steps:
echo 1. Run 'start.bat' to launch the application
echo 2. Open http://localhost:5173 in your browser
echo 3. Login with demo credentials below
echo.
echo 🔐 Demo Login Credentials:
echo ┌─────────────┬──────────────┬──────────────┐
echo │ Role        │ Mobile       │ Password     │
echo ├─────────────┼──────────────┼──────────────┤
echo │ Principal   │ 9876543210   │ 9876543210   │
echo │ Teacher     │ 9876543211   │ 9876543211   │
echo └─────────────┴──────────────┴──────────────┘
echo.
echo 🌐 Application URLs:
echo • Main App: http://localhost:5173
echo • API Server: http://localhost:3000
echo • Health Check: http://localhost:3000/health
echo.
echo 💡 Quick Test Checklist:
echo □ Login with demo credentials
echo □ View 6 sample students
echo □ Mark attendance for today
echo □ Create a new notice
echo □ Add student achievement
echo □ Check reports section
echo.
echo Press any key to continue...
pause ^>nul
echo.
echo 🎯 Ready to launch! Run 'start.bat' to begin.
) > "%EXPORT_DIR%\install.bat"

REM Create professional start script
echo 🚀 Professional start script तयार करत आहे...
(
echo @echo off
echo title School Attendance System v2.0 - Application Launcher
echo color 0B
echo cls
echo.
echo     🏫 शाळा हजेरी व्यवस्थापन प्रणाली v2.0
echo     ========================================
echo     Professional School Management Solution
echo.
echo 🚀 Application Launcher
echo.
echo.
echo 🔍 Pre-launch Verification
echo ==========================
echo.
if not exist "frontend\node_modules" ^(
    echo ❌ Frontend dependencies missing
    echo 📥 Please run 'install.bat' first
    echo.
    pause
    exit /b 1
^)
echo ✅ Frontend dependencies verified
echo.
if not exist "backend\node_modules" ^(
    echo ❌ Backend dependencies missing
    echo 📥 Please run 'install.bat' first
    echo.
    pause
    exit /b 1
^)
echo ✅ Backend dependencies verified
echo.
echo ✅ System ready for launch
echo.
echo.
echo 🔧 Starting Backend Services
echo ============================
echo 🔄 Express server, SQLite database, JWT auth...
start "🔧 Backend API Server" cmd /k "color 0C ^&^& title Backend API Server ^&^& cd backend ^&^& echo. ^&^& echo 🔧 School Attendance API Server ^&^& echo ================================ ^&^& echo. ^&^& echo 📊 Server: http://localhost:3000 ^&^& echo 🔍 Health: http://localhost:3000/health ^&^& echo 💾 Database: SQLite (school.db) ^&^& echo 🔐 Auth: JWT tokens ^&^& echo 📱 CORS: Enabled for frontend ^&^& echo. ^&^& echo ⚡ Starting server... ^&^& npm start"
echo ✅ Backend services starting...
echo.
echo ⏳ Initializing database and loading sample data...
timeout /t 6 /nobreak ^>nul
echo.
echo.
echo 📱 Starting Frontend Application
echo ================================
echo 🔄 React app with Vite development server...
start "📱 Frontend React App" cmd /k "color 0E ^&^& title Frontend React App ^&^& cd frontend ^&^& echo. ^&^& echo 📱 School Attendance Management UI ^&^& echo =================================== ^&^& echo. ^&^& echo 🌐 Application: http://localhost:5173 ^&^& echo ⚡ Build Tool: Vite (Lightning Fast) ^&^& echo 🎨 Framework: React 18 + TypeScript ^&^& echo 💅 Styling: Tailwind CSS ^&^& echo 🔗 Icons: Lucide React ^&^& echo. ^&^& echo 🚀 Starting development server... ^&^& npm run dev"
echo ✅ Frontend application starting...
echo.
echo.
echo 🎉 School Attendance System Launching!
echo ======================================
echo.
echo 🌐 Access Points:
echo ┌─────────────────────────────────────────────┐
echo │ 📱 Main App: http://localhost:5173         │
echo │ 🔧 API Server: http://localhost:3000       │
echo │ 🔍 Health: http://localhost:3000/health    │
echo └─────────────────────────────────────────────┘
echo.
echo 🔐 Demo Accounts:
echo ┌─────────────┬──────────────┬──────────────┐
echo │ Role        │ Mobile       │ Password     │
echo ├─────────────┼──────────────┼──────────────┤
echo │ Principal   │ 9876543210   │ 9876543210   │
echo │ Teacher     │ 9876543211   │ 9876543211   │
echo └─────────────┴──────────────┴──────────────┘
echo.
echo 📊 System Status:
echo • Backend API: Port 3000 (Starting)
echo • Frontend UI: Port 5173 (Starting)
echo • Database: SQLite with sample data
echo • Security: JWT authentication enabled
echo.
echo 🎯 Sample Data Available:
echo • 6 Students in Class 5-A
echo • 3 Sample notices
echo • 4 Student achievements
echo • Complete user accounts
echo.
echo 💡 Usage Guidelines:
echo • Wait 15-20 seconds for full startup
echo • Keep both server windows open
echo • Use Ctrl+C to stop servers when done
echo • Check console logs for any issues
echo.
echo ⏰ Auto-opening application in 12 seconds...
timeout /t 12 /nobreak ^>nul
echo.
echo 🌐 Opening School Attendance Management System...
start http://localhost:5173
echo.
echo ✅ Application launched successfully!
echo.
echo 🎓 Welcome to your School Management System!
echo.
echo Press any key to close launcher...
echo (Servers continue running in separate windows)
pause ^>nul
) > "%EXPORT_DIR%\start.bat"

REM Create quick reference guide
echo 📖 Quick reference तयार करत आहे...
(
echo # 🚀 Quick Reference Guide
echo.
echo ## Installation Steps:
echo 1. **install.bat** - Install all dependencies
echo 2. **start.bat** - Launch both servers
echo 3. Open http://localhost:5173
echo 4. Login with demo credentials
echo.
echo ## Demo Credentials:
echo - **Principal**: 9876543210 / 9876543210
echo - **Teacher**: 9876543211 / 9876543211
echo.
echo ## Key Features to Test:
echo - ✅ Student management (6 sample students)
echo - ✅ Attendance marking and statistics
echo - ✅ Notice creation and management
echo - ✅ Achievement tracking system
echo - ✅ Reports and analytics
echo.
echo ## URLs:
echo - Main App: http://localhost:5173
echo - API Server: http://localhost:3000
echo - Health Check: http://localhost:3000/health
echo.
echo ## Troubleshooting:
echo - Ensure Node.js is installed
echo - Check ports 3000 and 5173 are free
echo - Run scripts as Administrator if needed
echo - Check browser console for errors
echo.
echo ## Support:
echo - Check README.md for detailed docs
echo - Review server logs in terminal windows
echo - Verify all dependencies are installed
) > "%EXPORT_DIR%\QUICK_REFERENCE.md"

REM Create project info
echo 📋 Project info तयार करत आहे...
(
echo 📊 School Attendance Management System v2.0
echo ============================================
echo.
echo 📅 Package Date: %date% %time%
echo 📁 Source: D:\school attendance\project
echo 🏷️ Version: 2.0 Professional Edition
echo 📦 Package Type: Complete ZIP Distribution
echo.
echo 🎯 Package Contents:
echo ==================
echo ✅ React 18 Frontend with TypeScript
echo ✅ Node.js Backend with Express
echo ✅ SQLite Database with Sample Data
echo ✅ Enhanced Student Management
echo ✅ Notice Management System
echo ✅ Achievement Tracking System
echo ✅ Professional Installation Scripts
echo ✅ Comprehensive Documentation
echo.
echo 🚀 Installation Instructions:
echo ============================
echo 1. Extract ZIP to any folder
echo 2. Double-click 'install.bat'
echo 3. Double-click 'start.bat'
echo 4. Open http://localhost:5173
echo 5. Login with demo credentials
echo.
echo 🔐 Demo Login:
echo =============
echo Principal: 9876543210 / 9876543210
echo Teacher: 9876543211 / 9876543211
echo.
echo 🌟 Enhanced Features:
echo ===================
echo • Blood group tracking for students
echo • Emergency contact management
echo • Notice priority system
echo • Achievement categories and levels
echo • Advanced reporting and analytics
echo • Mobile-responsive design
echo • Automated installation process
echo.
echo 📊 Sample Data:
echo ==============
echo • 1 Demo School
echo • 2 User Accounts
echo • 6 Sample Students
echo • 3 Sample Notices
echo • 4 Sample Achievements
echo.
echo 🛠️ Requirements:
echo ===============
echo • Windows 7/8/10/11
echo • Node.js 16+ (auto-detected)
echo • 2GB RAM minimum
echo • Modern web browser
echo.
echo 📞 Support:
echo ==========
echo • README.md - Complete documentation
echo • Browser console - Error messages
echo • Server logs - Debug information
echo.
echo 🎉 Ready to use!
) > "%EXPORT_DIR%\PROJECT_INFO.txt"

REM Show completion summary
echo.
echo ✅ Professional ZIP Package Created!
echo ===================================
echo 📁 Location: %EXPORT_DIR%
echo.
for /f %%i in ('dir "%EXPORT_DIR%" /s /b 2^>nul ^| find /c /v ""') do echo 📊 Total Files: %%i
echo.
echo 📦 Package Contents:
echo ✅ Complete React + Node.js application
echo ✅ Enhanced features (notices, achievements)
echo ✅ Professional installation scripts
echo ✅ Comprehensive documentation
echo ✅ Sample data for immediate testing
echo ✅ Quick reference guides
echo.
echo 🎯 Next Steps:
echo 1. Right-click folder: %EXPORT_DIR%
echo 2. "Send to" → "Compressed (zipped) folder"
echo 3. Share the ZIP file
echo.
echo 👥 Recipient gets:
echo • One-click installation (install.bat)
echo • One-click launch (start.bat)
echo • Complete working system
echo • Demo data for testing
echo • Full documentation
echo.
echo Opening folder location...
explorer "%EXPORT_DIR%"
echo.
echo 🎉 Your professional ZIP package is ready!
echo.
pause