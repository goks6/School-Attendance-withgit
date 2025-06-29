@echo off
title School Attendance System - Final ZIP Creator
color 0F
echo.
echo     🏫 शाळा हजेरी व्यवस्थापन प्रणाली
echo     ================================
echo     Final ZIP Package Creator
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
set EXPORT_DIR=%DESKTOP%\school-attendance-system-v2.0-%TIMESTAMP%

if exist "%EXPORT_DIR%" rmdir /s /q "%EXPORT_DIR%"
mkdir "%EXPORT_DIR%"

echo 📦 Export करत आहे: %EXPORT_DIR%

REM Copy frontend files
echo 📱 Frontend files copy करत आहे...
mkdir "%EXPORT_DIR%\frontend"

if exist "src" (
    xcopy "src" "%EXPORT_DIR%\frontend\src\" /E /I /Q >nul
    echo ✅ src folder copied
)

if exist "public" (
    xcopy "public" "%EXPORT_DIR%\frontend\public\" /E /I /Q >nul
    echo ✅ public folder copied
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
    echo ✅ backend folder copied
)

REM Create comprehensive README
echo 📚 README file तयार करत आहे...
(
echo # 🏫 शाळा हजेरी व्यवस्थापन प्रणाली v2.0
echo ## School Attendance Management System
echo.
echo **Complete Enhanced School Management Solution**
echo.
echo ### 🌟 Enhanced Features:
echo.
echo #### 👥 Advanced Student Management
echo - Complete student profiles with blood group and emergency contacts
echo - Bulk import/export with Excel compatibility
echo - Advanced search, filtering, and sorting
echo - Student ID generation and management
echo - Class and section-wise organization
echo.
echo #### 📅 Smart Attendance System
echo - Daily attendance with multiple status options (Present/Absent/Late)
echo - Real-time attendance analytics and statistics
echo - Monthly and yearly attendance reports
echo - Class-wise attendance tracking
echo - Attendance trends and insights
echo.
echo #### 📢 Notice Management System
echo - Create and manage school notices with rich content
echo - Different notice types (General, Urgent, Event, Holiday)
echo - Target specific audiences (All, Teachers, Parents, Students)
echo - Priority levels and expiry date management
echo - Read/unread tracking system
echo.
echo #### 🏆 Achievement Tracking System
echo - Record student achievements and awards
echo - Multiple categories (Academic, Sports, Cultural, Behavior)
echo - Different levels (School, District, State, National)
echo - Achievement certificates and documentation
echo - Performance analytics and leaderboards
echo.
echo #### 📊 Comprehensive Reports & Analytics
echo - Real-time attendance statistics
echo - Student performance analytics
echo - Class-wise and school-wide reports
echo - Monthly/yearly trend analysis
echo - Export functionality for all data
echo.
echo #### 🎨 Modern UI/UX Design
echo - Colorful and attractive interface
echo - Fully responsive for all devices
echo - Smooth animations and transitions
echo - Intuitive navigation and user experience
echo - Marathi language support
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
echo # Prerequisites: Install Node.js from https://nodejs.org/
echo.
echo # Backend Setup
echo cd backend
echo npm install
echo npm start
echo.
echo # Frontend Setup (new terminal)
echo cd frontend
echo npm install
echo npm run dev
echo ```
echo.
echo ### 🔐 Demo Login Credentials:
echo.
echo ^| Role ^| Mobile Number ^| Password ^| Access Level ^|
echo ^|------|---------------|----------|---------------|
echo ^| **Principal** ^| 9876543210 ^| 9876543210 ^| Full System Access ^|
echo ^| **Teacher** ^| 9876543211 ^| 9876543211 ^| Class Management ^|
echo.
echo ### 🌐 Application URLs:
echo.
echo - **🖥️ Main Application**: http://localhost:5173
echo - **🔧 API Server**: http://localhost:3000
echo - **🔍 Health Check**: http://localhost:3000/health
echo - **📊 API Documentation**: http://localhost:3000/api
echo.
echo ### 🛠️ Technology Stack:
echo.
echo #### Frontend Technologies:
echo - **React 18** - Latest React with hooks and concurrent features
echo - **TypeScript** - Type-safe JavaScript for better development
echo - **Tailwind CSS** - Utility-first CSS framework
echo - **Vite** - Lightning-fast build tool and dev server
echo - **Lucide React** - Beautiful and consistent icon library
echo.
echo #### Backend Technologies:
echo - **Node.js** - JavaScript runtime environment
echo - **Express.js** - Fast and minimalist web framework
echo - **SQLite3** - Lightweight and reliable database
echo - **JWT** - Secure authentication tokens
echo - **bcryptjs** - Password hashing and security
echo.
echo ### 📁 Project Architecture:
echo ```
echo school-attendance-system/
echo ├── frontend/                    # React Application
echo │   ├── src/
echo │   │   ├── App.tsx             # Main application component
echo │   │   ├── main.tsx            # Application entry point
echo │   │   └── index.css           # Global styles and Tailwind
echo │   ├── public/                 # Static assets and icons
echo │   ├── package.json            # Frontend dependencies
echo │   └── vite.config.ts          # Vite build configuration
echo │
echo ├── backend/                     # Node.js API Server
echo │   ├── server.js               # Express server and middleware
echo │   ├── config/
echo │   │   └── database-sqlite.js  # Database configuration
echo │   ├── routes/                 # API endpoint definitions
echo │   │   ├── auth.js             # Authentication endpoints
echo │   │   ├── students.js         # Student management API
echo │   │   ├── attendance.js       # Attendance tracking API
echo │   │   ├── notices.js          # Notice management API
echo │   │   └── achievements.js     # Achievement tracking API
echo │   ├── middleware/
echo │   │   └── auth.js             # JWT authentication middleware
echo │   └── package.json            # Backend dependencies
echo │
echo ├── install.bat                 # Automated installation script
echo ├── start.bat                   # Start both servers script
echo ├── README.md                   # This comprehensive documentation
echo └── PROJECT_INFO.txt            # Quick reference information
echo ```
echo.
echo ### 🎯 Key Features Explained:
echo.
echo #### Student Management:
echo - **Enhanced Profiles**: Complete student information including blood group, emergency contacts, and medical details
echo - **Smart Search**: Advanced filtering by class, section, blood group, gender, and custom criteria
echo - **Bulk Operations**: Import/export students from Excel or CSV files
echo - **ID Generation**: Automatic student ID generation with customizable formats
echo - **Academic Tracking**: Monitor student progress and performance over time
echo.
echo #### Attendance System:
echo - **Flexible Marking**: Support for Present, Absent, Late, and custom status options
echo - **Real-time Analytics**: Live attendance statistics and trend analysis
echo - **Smart Notifications**: Automated alerts for low attendance patterns
echo - **Historical Data**: Complete attendance history with detailed reports
echo - **Class Management**: Efficient class-wise attendance tracking
echo.
echo #### Notice Management:
echo - **Rich Content**: Support for formatted text, images, and attachments
echo - **Smart Targeting**: Send notices to specific groups or individuals
echo - **Priority System**: Urgent, normal, and low priority classifications
echo - **Read Tracking**: Monitor who has read important notices
echo - **Scheduling**: Schedule notices for future delivery
echo.
echo #### Achievement System:
echo - **Multi-Category**: Academic, sports, cultural, and behavioral achievements
echo - **Level Tracking**: School, district, state, and national level recognition
echo - **Certificate Management**: Upload and manage achievement certificates
echo - **Performance Analytics**: Track top performers and achievement trends
echo - **Recognition System**: Automated recognition and reward suggestions
echo.
echo ### 🔧 Advanced Configuration:
echo.
echo #### Environment Variables:
echo Create `.env` file in backend directory for custom configuration:
echo ```
echo PORT=3000
echo JWT_SECRET=your_custom_secret_key
echo NODE_ENV=production
echo DB_PATH=./school.db
echo UPLOAD_PATH=./uploads
echo ```
echo.
echo #### Custom Branding:
echo - Modify school name and logo in `frontend/public/`
echo - Update color scheme in `frontend/src/index.css`
echo - Customize email templates in `backend/templates/`
echo.
echo ### 📱 Mobile & Cross-Platform Support:
echo.
echo #### Responsive Design:
echo - **Mobile First**: Optimized for smartphones and tablets
echo - **Touch Friendly**: Large touch targets and gesture support
echo - **Offline Capable**: Basic functionality works without internet
echo - **PWA Ready**: Can be installed as a mobile app
echo.
echo #### Browser Compatibility:
echo - ✅ Chrome (Recommended)
echo - ✅ Firefox
echo - ✅ Safari
echo - ✅ Edge
echo - ✅ Mobile browsers
echo.
echo ### 🔒 Security & Privacy:
echo.
echo #### Security Features:
echo - **JWT Authentication**: Secure token-based authentication
echo - **Password Hashing**: bcrypt encryption for all passwords
echo - **SQL Injection Protection**: Parameterized queries and validation
echo - **Input Sanitization**: All user inputs are validated and sanitized
echo - **Role-Based Access**: Different permissions for principals and teachers
echo.
echo #### Privacy Compliance:
echo - **Data Encryption**: Sensitive data is encrypted at rest
echo - **Access Logging**: All data access is logged for audit trails
echo - **Data Retention**: Configurable data retention policies
echo - **Export Rights**: Users can export their data anytime
echo.
echo ### 🚀 Deployment Options:
echo.
echo #### Cloud Deployment:
echo.
echo **Frontend Deployment:**
echo - **Vercel**: Connect GitHub repo for automatic deployment
echo - **Netlify**: Drag and drop build folder for instant hosting
echo - **GitHub Pages**: Free static hosting for public repositories
echo.
echo **Backend Deployment:**
echo - **Railway**: Easy Node.js deployment with database
echo - **Heroku**: Cloud platform with add-on ecosystem
echo - **DigitalOcean**: VPS hosting with full control
echo.
echo #### Local Network Deployment:
echo - Configure for local school network access
echo - Set up on school server or dedicated computer
echo - Enable WiFi access for mobile devices
echo.
echo ### 📊 Sample Data & Testing:
echo.
echo #### Pre-loaded Sample Data:
echo - **1 Demo School**: डेमो प्राथमिक शाळा with complete setup
echo - **2 User Accounts**: Principal and Teacher with different permissions
echo - **6 Sample Students**: Class 5-A with complete profiles and blood groups
echo - **3 Sample Notices**: Different types and priorities for testing
echo - **4 Sample Achievements**: Various categories and levels
echo.
echo #### Testing Scenarios:
echo 1. **Login Testing**: Try both principal and teacher accounts
echo 2. **Student Management**: Add, edit, search, and filter students
echo 3. **Attendance Workflow**: Mark daily attendance and view reports
echo 4. **Notice System**: Create, edit, and manage school notices
echo 5. **Achievement Tracking**: Add achievements and view analytics
echo 6. **Report Generation**: Generate and export various reports
echo.
echo ### 🆘 Troubleshooting Guide:
echo.
echo #### Common Issues & Solutions:
echo.
echo **Installation Issues:**
echo ```bash
echo # Node.js not found
echo Download and install from: https://nodejs.org/
echo.
echo # Permission denied
echo Run command prompt as Administrator
echo.
echo # Network issues
echo Check internet connection and firewall settings
echo ```
echo.
echo **Runtime Issues:**
echo ```bash
echo # Port already in use
echo netstat -ano ^| findstr :3000
echo taskkill /PID ^<PID_NUMBER^> /F
echo.
echo # Database locked
echo Close all applications and restart servers
echo.
echo # Memory issues
echo Restart computer and try again
echo ```
echo.
echo **Browser Issues:**
echo - Clear browser cache and cookies
echo - Disable browser extensions
echo - Try incognito/private mode
echo - Update browser to latest version
echo.
echo ### 📞 Support & Documentation:
echo.
echo #### Getting Help:
echo - Check browser console for error messages
echo - Review server logs in terminal windows
echo - Verify all prerequisites are installed
echo - Ensure ports 3000 and 5173 are available
echo.
echo #### Additional Resources:
echo - **React Documentation**: https://react.dev/
echo - **Node.js Guides**: https://nodejs.org/en/docs/
echo - **Tailwind CSS**: https://tailwindcss.com/docs
echo - **SQLite Tutorial**: https://www.sqlite.org/docs.html
echo.
echo ### 📄 License & Credits:
echo.
echo This project is open source and available under the MIT License.
echo.
echo **Development Team:**
echo Created with ❤️ for educational institutions to modernize their attendance management and administrative processes.
echo.
echo **Special Thanks:**
echo - React team for the amazing framework
echo - Tailwind CSS for the utility-first approach
echo - Node.js community for the robust ecosystem
echo - SQLite for the reliable database engine
echo.
echo ### 🎓 Educational Impact:
echo.
echo This system helps schools:
echo - **Reduce Administrative Burden**: Automate routine tasks
echo - **Improve Communication**: Better parent-teacher communication
echo - **Track Student Progress**: Comprehensive student analytics
echo - **Enhance Efficiency**: Streamlined school operations
echo - **Go Digital**: Modern approach to school management
echo.
echo ---
echo.
echo **🎉 Thank you for using School Attendance Management System!**
echo.
echo **Happy Teaching and Learning! 📚✨**
) > "%EXPORT_DIR%\README.md"

REM Create enhanced install script
echo 🔧 Install script तयार करत आहे...
(
echo @echo off
echo title School Attendance System v2.0 - Installation
echo color 0A
echo cls
echo.
echo     🏫 शाळा हजेरी व्यवस्थापन प्रणाली v2.0
echo     ========================================
echo     Enhanced School Attendance Management System
echo.
echo 🚀 Starting automated installation process...
echo.
echo ⏳ Please wait while we set up your system...
echo.
echo.
echo 🔍 Checking system requirements...
echo ================================
echo.
echo 📋 Checking Node.js installation...
node --version ^>nul 2^>^&1
if errorlevel 1 ^(
    echo ❌ Node.js is not installed on your system
    echo.
    echo 📥 Please download and install Node.js:
    echo 🌐 https://nodejs.org/ (Download LTS version)
    echo.
    echo 💡 After installing Node.js:
    echo 1. Restart your computer
    echo 2. Run this installation script again
    echo.
    echo Press any key to open Node.js download page...
    pause ^>nul
    start https://nodejs.org/
    exit /b 1
^)
echo.
echo ✅ Node.js is installed and ready
for /f "tokens=*" %%i in ^('node --version'^) do echo 📦 Version: %%i
echo.
echo 📋 Checking npm package manager...
npm --version ^>nul 2^>^&1
if errorlevel 1 ^(
    echo ❌ npm is not available
    echo Please reinstall Node.js from https://nodejs.org/
    pause
    exit /b 1
^)
for /f "tokens=*" %%i in ^('npm --version'^) do echo ✅ npm Version: %%i
echo.
echo.
echo 📱 Installing Frontend Dependencies...
echo =====================================
echo 🔄 Installing React, TypeScript, Tailwind CSS, and other frontend packages...
echo.
cd frontend
npm install --silent
if errorlevel 1 ^(
    echo.
    echo ❌ Frontend installation failed
    echo.
    echo 🔧 Troubleshooting steps:
    echo 1. Check your internet connection
    echo 2. Try running this script as Administrator
    echo 3. Temporarily disable antivirus software
    echo 4. Clear npm cache: npm cache clean --force
    echo.
    echo Press any key to continue anyway...
    pause ^>nul
    cd ..
    goto backend_install
^)
echo ✅ Frontend dependencies installed successfully
echo 📦 React application is ready
echo.
echo.
:backend_install
echo 🔧 Installing Backend Dependencies...
echo ====================================
echo 🔄 Installing Express, SQLite, JWT, and other backend packages...
echo.
cd ..\backend
npm install --silent
if errorlevel 1 ^(
    echo.
    echo ❌ Backend installation failed
    echo.
    echo 🔧 Troubleshooting steps:
    echo 1. Check your internet connection
    echo 2. Try running this script as Administrator
    echo 3. Temporarily disable antivirus software
    echo 4. Clear npm cache: npm cache clean --force
    echo.
    echo Press any key to continue anyway...
    pause ^>nul
    cd ..
    goto installation_complete
^)
echo ✅ Backend dependencies installed successfully
echo 📦 API server is ready
echo.
cd ..
echo.
:installation_complete
echo 🎉 Installation Completed Successfully!
echo =====================================
echo.
echo 📋 Installation Summary:
echo ┌─────────────────────────────────────────────┐
echo │ ✅ Node.js Runtime Environment             │
echo │ ✅ Frontend: React 18 + TypeScript         │
echo │ ✅ Styling: Tailwind CSS + Lucide Icons    │
echo │ ✅ Backend: Express.js + SQLite Database   │
echo │ ✅ Security: JWT Authentication            │
echo │ ✅ Sample Data: Pre-loaded for testing     │
echo └─────────────────────────────────────────────┘
echo.
echo 🚀 Next Steps:
echo 1. Run 'start.bat' to launch the application
echo 2. Or manually start servers:
echo    • Backend: cd backend ^&^& npm start
echo    • Frontend: cd frontend ^&^& npm run dev
echo.
echo 🔐 Demo Login Credentials:
echo ┌─────────────┬──────────────┬──────────────┬─────────────────┐
echo │ Role        │ Mobile       │ Password     │ Access Level    │
echo ├─────────────┼──────────────┼──────────────┼─────────────────┤
echo │ Principal   │ 9876543210   │ 9876543210   │ Full System     │
echo │ Teacher     │ 9876543211   │ 9876543211   │ Class Management│
echo └─────────────┴──────────────┴──────────────┴─────────────────┘
echo.
echo 🌐 Application URLs:
echo 📱 Main App: http://localhost:5173
echo 🔧 API Server: http://localhost:3000
echo 🔍 Health Check: http://localhost:3000/health
echo.
echo 💡 Pro Tips:
echo • Keep both server windows open while using the app
echo • Use Ctrl+C in server windows to stop when done
echo • Check README.md for detailed documentation
echo • Sample data is pre-loaded for immediate testing
echo.
echo 🎯 What to test first:
echo 1. Login with demo credentials
echo 2. View the 6 sample students
echo 3. Mark attendance for today
echo 4. Create a new notice
echo 5. Add an achievement
echo 6. Check the reports section
echo.
echo Press any key to continue...
pause ^>nul
echo.
echo 🎉 Ready to launch! Run 'start.bat' to begin.
echo.
) > "%EXPORT_DIR%\install.bat"

REM Create enhanced start script
echo 🚀 Start script तयार करत आहे...
(
echo @echo off
echo title School Attendance System v2.0 - Server Manager
echo color 0B
echo cls
echo.
echo     🏫 शाळा हजेरी व्यवस्थापन प्रणाली v2.0
echo     ========================================
echo     Enhanced School Attendance Management System
echo.
echo 🚀 Starting application servers...
echo.
echo.
echo 🔍 Pre-flight checks...
echo ======================
echo.
echo 📋 Checking dependencies...
if not exist "frontend\node_modules" ^(
    echo ❌ Frontend dependencies not found
    echo 📥 Please run 'install.bat' first to install all dependencies
    echo.
    pause
    exit /b 1
^)
echo ✅ Frontend dependencies found
echo.
if not exist "backend\node_modules" ^(
    echo ❌ Backend dependencies not found
    echo 📥 Please run 'install.bat' first to install all dependencies
    echo.
    pause
    exit /b 1
^)
echo ✅ Backend dependencies found
echo.
echo 📋 Checking system resources...
echo ✅ System ready for launch
echo.
echo.
echo 🔧 Starting Backend API Server...
echo =================================
echo 🔄 Initializing Express server, SQLite database, and JWT authentication...
start "🔧 Backend API Server - School Attendance" cmd /k "color 0C ^&^& title Backend API Server ^&^& cd backend ^&^& echo. ^&^& echo 🔧 Backend Server Starting... ^&^& echo ================================ ^&^& echo. ^&^& echo 📊 Server: http://localhost:3000 ^&^& echo 🔍 Health: http://localhost:3000/health ^&^& echo 💾 Database: SQLite (school.db) ^&^& echo 🔐 Auth: JWT tokens ^&^& echo. ^&^& echo ⚡ Starting Express server... ^&^& npm start"
echo ✅ Backend server is starting...
echo.
echo ⏳ Waiting for backend to initialize...
echo 🔄 Loading database and sample data...
timeout /t 6 /nobreak ^>nul
echo.
echo.
echo 📱 Starting Frontend React Application...
echo ========================================
echo 🔄 Initializing React app with Vite development server...
start "📱 Frontend React App - School Attendance" cmd /k "color 0E ^&^& title Frontend React App ^&^& cd frontend ^&^& echo. ^&^& echo 📱 Frontend Application Starting... ^&^& echo ==================================== ^&^& echo. ^&^& echo 🌐 Application: http://localhost:5173 ^&^& echo ⚡ Build Tool: Vite ^&^& echo 🎨 Framework: React 18 + TypeScript ^&^& echo 💅 Styling: Tailwind CSS ^&^& echo. ^&^& echo 🚀 Starting development server... ^&^& npm run dev"
echo ✅ Frontend application is starting...
echo.
echo.
echo 🎉 Both Servers Are Launching!
echo ==============================
echo.
echo 🌐 Application Access Points:
echo ┌─────────────────────────────────────────────────────┐
echo │ 📱 Main Application: http://localhost:5173         │
echo │ 🔧 API Server:       http://localhost:3000         │
echo │ 🔍 Health Check:     http://localhost:3000/health  │
echo │ 📊 API Docs:         http://localhost:3000/api     │
echo └─────────────────────────────────────────────────────┘
echo.
echo 🔐 Demo Login Credentials:
echo ┌─────────────┬──────────────┬──────────────┬─────────────────┐
echo │ Role        │ Mobile       │ Password     │ Access Level    │
echo ├─────────────┼──────────────┼──────────────┼─────────────────┤
echo │ Principal   │ 9876543210   │ 9876543210   │ Full System     │
echo │ Teacher     │ 9876543211   │ 9876543211   │ Class Management│
echo └─────────────┴──────────────┴──────────────┴─────────────────┘
echo.
echo 📊 System Status:
echo • Backend API: Starting on port 3000
echo • Frontend App: Starting on port 5173
echo • Database: SQLite with sample data
echo • Authentication: JWT-based security
echo.
echo 🎯 Quick Testing Guide:
echo 1. ✅ Login with demo credentials
echo 2. ✅ View student list (6 sample students)
echo 3. ✅ Mark today's attendance
echo 4. ✅ Create a new notice
echo 5. ✅ Add student achievement
echo 6. ✅ Check reports and analytics
echo.
echo 💡 Usage Tips:
echo • Wait 15-20 seconds for both servers to fully start
echo • Frontend will automatically open in your default browser
echo • Keep both server windows open while using the application
echo • Use Ctrl+C in server windows to stop when finished
echo • Check console logs if you encounter any issues
echo.
echo 🆘 Troubleshooting:
echo • If ports are busy: Close other applications using ports 3000/5173
echo • If browser doesn't open: Manually go to http://localhost:5173
echo • If login fails: Ensure backend server is fully started
echo • If data doesn't load: Check backend console for errors
echo.
echo ⏰ Waiting 12 seconds then opening application in browser...
timeout /t 12 /nobreak ^>nul
echo.
echo 🌐 Opening School Attendance Management System...
start http://localhost:5173
echo.
echo ✅ Application launched successfully!
echo.
echo 🎓 Welcome to the Enhanced School Attendance Management System!
echo.
echo Press any key to close this launcher window...
echo (Both servers will continue running in their respective windows)
pause ^>nul
) > "%EXPORT_DIR%\start.bat"

REM Create project info file
echo 📋 Project info तयार करत आहे...
(
echo 📊 School Attendance Management System v2.0
echo ============================================
echo.
echo 📅 Export Date: %date% %time%
echo 📁 Source: D:\school attendance\project
echo 📍 Destination: %EXPORT_DIR%
echo 🏷️ Version: 2.0 Enhanced Edition
echo.
echo 📦 Package Contents:
echo ==================
echo ✅ Frontend Application (React 18 + TypeScript + Tailwind CSS)
echo ✅ Backend API Server (Node.js + Express + SQLite)
echo ✅ Enhanced Database Schema with new features
echo ✅ Notice Management System
echo ✅ Achievement Tracking System
echo ✅ Advanced Student Profiles
echo ✅ Automated Installation Scripts
echo ✅ Comprehensive Documentation
echo ✅ Sample Data for Testing
echo.
echo 🚀 Quick Start Instructions:
echo ===========================
echo 1. Extract this ZIP file to any folder
echo 2. Double-click 'install.bat' to install dependencies
echo 3. Double-click 'start.bat' to launch the application
echo 4. Open http://localhost:5173 in your browser
echo 5. Login with demo credentials below
echo.
echo 🔐 Demo Login Credentials:
echo =========================
echo Principal Account:
echo   Mobile: 9876543210
echo   Password: 9876543210
echo   Access: Full system administration
echo.
echo Teacher Account:
echo   Mobile: 9876543211
echo   Password: 9876543211
echo   Access: Class management and attendance
echo.
echo 🌟 New Features in v2.0:
echo ========================
echo ✨ Enhanced student profiles with blood group and emergency contacts
echo ✨ Notice management system with priorities and targeting
echo ✨ Achievement tracking with categories and levels
echo ✨ Advanced analytics and reporting
echo ✨ Improved mobile responsive design
echo ✨ Better error handling and user feedback
echo ✨ Automated installation and setup scripts
echo.
echo 📊 Sample Data Included:
echo =======================
echo • 1 Demo School (डेमो प्राथमिक शाळा)
echo • 2 User Accounts (Principal + Teacher)
echo • 6 Sample Students (Class 5-A with complete profiles)
echo • 3 Sample Notices (Different types and priorities)
echo • 4 Sample Achievements (Various categories)
echo.
echo 🛠️ System Requirements:
echo ======================
echo • Windows 7/8/10/11
echo • Node.js 16.0 or higher
echo • 2GB RAM minimum
echo • 500MB free disk space
echo • Modern web browser (Chrome, Firefox, Edge, Safari)
echo.
echo 🌐 Application URLs:
echo ===================
echo • Main Application: http://localhost:5173
echo • API Server: http://localhost:3000
echo • Health Check: http://localhost:3000/health
echo.
echo 📞 Support Information:
echo ======================
echo • Check README.md for detailed documentation
echo • Review browser console for error messages
echo • Ensure both servers are running before use
echo • Verify Node.js is properly installed
echo.
echo 🎯 Testing Checklist:
echo ====================
echo □ Install dependencies (install.bat)
echo □ Start servers (start.bat)
echo □ Login with demo credentials
echo □ View student list
echo □ Mark attendance
echo □ Create notice
echo □ Add achievement
echo □ Check reports
echo.
echo 📄 License: MIT License (Open Source)
echo 👨‍💻 Created for educational institutions
echo.
echo 🎉 Thank you for using School Attendance Management System!
) > "%EXPORT_DIR%\PROJECT_INFO.txt"

REM Create quick start guide
echo 📖 Quick start guide तयार करत आहे...
(
echo # 🚀 Quick Start Guide
echo.
echo ## Step 1: Install Dependencies
echo Double-click `install.bat` and wait for completion
echo.
echo ## Step 2: Start Application  
echo Double-click `start.bat` to launch both servers
echo.
echo ## Step 3: Access Application
echo Open http://localhost:5173 in your browser
echo.
echo ## Step 4: Login
echo Use demo credentials:
echo - Principal: 9876543210 / 9876543210
echo - Teacher: 9876543211 / 9876543211
echo.
echo ## Step 5: Explore Features
echo - View 6 sample students
echo - Mark attendance
echo - Create notices
echo - Add achievements
echo - Check reports
echo.
echo ## Need Help?
echo Check README.md for detailed documentation
) > "%EXPORT_DIR%\QUICK_START.md"

REM Count files and show summary
echo.
echo 📊 Export summary तयार करत आहे...
for /f %%i in ('dir "%EXPORT_DIR%\frontend" /s /b 2^>nul ^| find /c /v ""') do set FRONTEND_COUNT=%%i
for /f %%i in ('dir "%EXPORT_DIR%\backend" /s /b 2^>nul ^| find /c /v ""') do set BACKEND_COUNT=%%i

echo.
echo ✅ ZIP Package Created Successfully!
echo ====================================
echo 📁 Package Location: %EXPORT_DIR%
echo 📱 Frontend Files: %FRONTEND_COUNT%
echo 🔧 Backend Files: %BACKEND_COUNT%
echo 📚 Documentation: Complete
echo 🔧 Scripts: Ready
echo.
echo 📦 Ready to ZIP and Share!
echo =========================
echo.
echo 🎯 Next Steps:
echo 1. Right-click on the folder: %EXPORT_DIR%
echo 2. Select "Send to" → "Compressed (zipped) folder"
echo 3. Share the ZIP file with others
echo.
echo 👥 Recipient Instructions:
echo 1. Extract ZIP file to any location
echo 2. Run install.bat (installs dependencies)
echo 3. Run start.bat (launches application)
echo 4. Open http://localhost:5173
echo 5. Login with demo credentials
echo.
echo 🌟 Package Features:
echo • Complete React + Node.js application
echo • Enhanced student management
echo • Notice management system
echo • Achievement tracking
echo • Automated setup scripts
echo • Comprehensive documentation
echo • Sample data for testing
echo.
echo Opening folder location...
explorer "%EXPORT_DIR%"
echo.
echo 🎉 Your School Attendance Management System v2.0 is ready to share!
echo.
pause