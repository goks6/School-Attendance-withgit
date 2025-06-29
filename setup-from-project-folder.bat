@echo off
echo 🚀 School Attendance System Setup (Project Folder)
echo ===================================================

REM Navigate to the project folder
echo 📁 Project folder मध्ये जात आहे...
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

echo.
echo तुम्हाला काय करायचे आहे?
echo.
echo 1. GitHub वर upload करा
echo 2. ZIP file तयार करा (Desktop वर)
echo 3. दोन्ही करा
echo 4. Project structure पाहा
echo 5. Exit
echo.
set /p choice="तुमची निवड (1-5): "

if "%choice%"=="1" goto github_upload
if "%choice%"=="2" goto create_zip
if "%choice%"=="3" goto do_both
if "%choice%"=="4" goto show_structure
if "%choice%"=="5" exit /b 0

echo ❌ अवैध निवड
pause
exit /b 1

:show_structure
echo.
echo 📁 Project Structure:
echo =====================
tree /F /A
echo.
pause
goto :eof

:github_upload
echo.
echo 🌐 GitHub Upload Process...
echo ===========================

REM Check git installation
git --version >nul 2>&1
if errorlevel 1 (
    echo ❌ Git installed नाही
    echo Download करा: https://git-scm.com/download/win
    pause
    exit /b 1
)

REM Remove existing git
if exist ".git" (
    echo 🗑️ Existing git repository काढत आहे...
    rmdir /s /q .git
)

REM Initialize git
echo 🔧 Git repository initialize करत आहे...
git init

REM Configure git user if needed
git config user.name >nul 2>&1
if errorlevel 1 (
    set /p username="तुमचे नाव: "
    set /p email="तुमचा email: "
    git config user.name "%username%"
    git config user.email "%email%"
)

REM Add files
echo 📦 Files add करत आहे...
git add .

REM Commit
echo 💾 Commit करत आहे...
git commit -m "Initial commit: School Attendance Management System from project folder"

REM Set main branch
git branch -M main

echo.
echo 🌐 GitHub Repository तयार करा:
echo 1. https://github.com वर जा
echo 2. "New repository" क्लिक करा
echo 3. Name: school-attendance-system
echo 4. "Create repository" क्लिक करा
echo.

set /p github_username="GitHub Username: "

if "%github_username%"=="" (
    echo ❌ Username आवश्यक आहे
    pause
    exit /b 1
)

REM Add remote and push
git remote add origin https://github.com/%github_username%/school-attendance-system.git
echo 🚀 GitHub वर upload करत आहे...
git push -u origin main

if errorlevel 1 (
    echo ❌ Upload failed
    echo 🔑 Personal Access Token वापरा password ऐवजी
    pause
    exit /b 1
)

echo ✅ GitHub upload successful!
echo 🌐 URL: https://github.com/%github_username%/school-attendance-system
pause
goto :eof

:create_zip
echo.
echo 📦 ZIP File तयार करत आहे...
echo ==============================

REM Create export directory on Desktop
set DESKTOP=%USERPROFILE%\Desktop
set EXPORT_DIR=%DESKTOP%\school-attendance-system-complete
if exist "%EXPORT_DIR%" rmdir /s /q "%EXPORT_DIR%"
mkdir "%EXPORT_DIR%"

echo 📁 Export directory: %EXPORT_DIR%

REM Copy all project files
echo 📱 Frontend files copy करत आहे...
mkdir "%EXPORT_DIR%\frontend"

if exist "src" xcopy "src" "%EXPORT_DIR%\frontend\src\" /E /I /Q >nul
if exist "public" xcopy "public" "%EXPORT_DIR%\frontend\public\" /E /I /Q >nul
if exist "package.json" copy "package.json" "%EXPORT_DIR%\frontend\" >nul
if exist "index.html" copy "index.html" "%EXPORT_DIR%\frontend\" >nul
if exist "vite.config.ts" copy "vite.config.ts" "%EXPORT_DIR%\frontend\" >nul
if exist "tailwind.config.js" copy "tailwind.config.js" "%EXPORT_DIR%\frontend\" >nul
if exist "tsconfig*.json" copy "tsconfig*.json" "%EXPORT_DIR%\frontend\" >nul
if exist "postcss.config.js" copy "postcss.config.js" "%EXPORT_DIR%\frontend\" >nul
if exist "eslint.config.js" copy "eslint.config.js" "%EXPORT_DIR%\frontend\" >nul

echo 🔧 Backend files copy करत आहे...
if exist "backend" xcopy "backend" "%EXPORT_DIR%\backend\" /E /I /Q >nul

REM Create README
echo 📚 Documentation तयार करत आहे...
(
echo # शाळा हजेरी व्यवस्थापन प्रणाली
echo ## School Attendance Management System
echo.
echo ### 🌟 Features:
echo - 📱 Modern React Frontend with Tailwind CSS
echo - 🔧 Node.js Backend with SQLite Database
echo - 👥 Enhanced Student Management
echo - 📅 Advanced Attendance Tracking
echo - 📢 Notice Management System
echo - 🏆 Achievement Tracking
echo - 📊 Comprehensive Reports
echo - 🎨 Colorful UI Design
echo.
echo ### 🚀 Quick Start:
echo.
echo #### Method 1: Use Scripts
echo 1. Run `install.bat` to install dependencies
echo 2. Run `start.bat` to start both servers
echo.
echo #### Method 2: Manual
echo ```bash
echo # Backend
echo cd backend
echo npm install
echo npm start
echo.
echo # Frontend (in new terminal)
echo cd frontend  
echo npm install
echo npm run dev
echo ```
echo.
echo ### 🔐 Demo Credentials:
echo - **Principal**: 9876543210 / 9876543210
echo - **Teacher**: 9876543211 / 9876543211
echo.
echo ### 🌐 URLs:
echo - Frontend: http://localhost:5173
echo - Backend: http://localhost:3000
echo.
echo ### 🛠️ Technology Stack:
echo - Frontend: React 18, TypeScript, Tailwind CSS, Vite
echo - Backend: Node.js, Express.js, SQLite3
echo - Authentication: JWT
echo - UI: Lucide React Icons
echo.
echo ### 📁 Project Structure:
echo ```
echo school-attendance-system/
echo ├── frontend/          # React application
echo ├── backend/           # Node.js API server
echo ├── install.bat       # Install dependencies
echo ├── start.bat         # Start both servers
echo └── README.md         # This file
echo ```
echo.
echo ### 🎯 Key Features:
echo - Student management with blood group, emergency contacts
echo - Real-time attendance tracking with analytics
echo - Notice management with different types and priorities
echo - Achievement tracking system
echo - Comprehensive reporting and statistics
echo - Mobile-responsive design
echo - Marathi language support
echo.
echo ### 🔧 Development:
echo - Add new features in respective frontend/backend folders
echo - Database schema in `backend/config/database-sqlite.js`
echo - API routes in `backend/routes/`
echo - React components in `frontend/src/`
echo.
echo ### 📞 Support:
echo Check code comments for detailed implementation details.
) > "%EXPORT_DIR%\README.md"

REM Create install script
(
echo @echo off
echo echo 🚀 Installing School Attendance Management System...
echo echo ================================================
echo echo.
echo echo 📱 Installing frontend dependencies...
echo cd frontend
echo npm install
echo if errorlevel 1 ^(
echo     echo ❌ Frontend installation failed
echo     echo Make sure Node.js is installed: https://nodejs.org/
echo     pause
echo     exit /b 1
echo ^)
echo echo ✅ Frontend dependencies installed
echo.
echo echo 🔧 Installing backend dependencies...
echo cd ..\backend
echo npm install
echo if errorlevel 1 ^(
echo     echo ❌ Backend installation failed
echo     pause
echo     exit /b 1
echo ^)
echo echo ✅ Backend dependencies installed
echo.
echo cd ..
echo echo.
echo echo 🎉 Installation completed successfully!
echo echo.
echo echo 🚀 Next steps:
echo echo 1. Run 'start.bat' to start both servers
echo echo 2. Or manually start:
echo echo    - Backend: cd backend ^&^& npm start
echo echo    - Frontend: cd frontend ^&^& npm run dev
echo echo.
echo echo 🔐 Demo Login Credentials:
echo echo Principal: 9876543210 / 9876543210
echo echo Teacher: 9876543211 / 9876543211
echo echo.
echo echo 🌐 URLs:
echo echo Frontend: http://localhost:5173
echo echo Backend: http://localhost:3000
echo echo.
echo pause
) > "%EXPORT_DIR%\install.bat"

REM Create start script
(
echo @echo off
echo echo 🚀 Starting School Attendance Management System...
echo echo ================================================
echo echo.
echo REM Check if dependencies are installed
echo if not exist "frontend\node_modules" ^(
echo     if not exist "backend\node_modules" ^(
echo         echo ❌ Dependencies not installed
echo         echo Please run 'install.bat' first
echo         pause
echo         exit /b 1
echo     ^)
echo ^)
echo.
echo echo 🔧 Starting backend server...
echo start "Backend Server" cmd /k "cd backend && npm start"
echo.
echo echo ⏳ Waiting 3 seconds for backend to start...
echo timeout /t 3 /nobreak >nul
echo.
echo echo 📱 Starting frontend development server...
echo start "Frontend Server" cmd /k "cd frontend && npm run dev"
echo.
echo echo.
echo echo 🎉 Both servers are starting!
echo echo ================================================
echo echo 📱 Frontend: http://localhost:5173
echo echo 🔧 Backend: http://localhost:3000
echo echo.
echo echo 🔐 Demo Login:
echo echo Principal: 9876543210 / 9876543210
echo echo Teacher: 9876543211 / 9876543211
echo echo.
echo echo 💡 Tip: Wait for both servers to fully start before accessing
echo echo.
echo echo Press any key to close this window...
echo pause >nul
) > "%EXPORT_DIR%\start.bat"

echo ✅ ZIP folder तयार झाली!
echo 📍 Location: %EXPORT_DIR%
echo.
echo 📦 आता ZIP करा:
echo 1. %EXPORT_DIR% folder वर right-click करा
echo 2. "Send to" → "Compressed (zipped) folder" निवडा
echo 3. ZIP file share करा
echo.
explorer "%DESKTOP%"
pause
goto :eof

:do_both
call :github_upload
echo.
call :create_zip
goto :eof