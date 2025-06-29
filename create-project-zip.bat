@echo off
echo 📦 School Attendance System ZIP तयार करत आहे...
echo ================================================

REM Create export directory
set EXPORT_DIR=school-attendance-system-export
if exist "%EXPORT_DIR%" rmdir /s /q "%EXPORT_DIR%"
mkdir "%EXPORT_DIR%"

echo 📁 Export directory तयार केली: %EXPORT_DIR%

REM Copy frontend files
echo 📱 Frontend files copy करत आहे...
mkdir "%EXPORT_DIR%\frontend"

if exist "src" (
    xcopy "src" "%EXPORT_DIR%\frontend\src\" /E /I /Q
    echo ✅ src folder copied
) else (
    echo ⚠️ src folder not found
)

if exist "public" (
    xcopy "public" "%EXPORT_DIR%\frontend\public\" /E /I /Q
    echo ✅ public folder copied
) else (
    echo ⚠️ public folder not found
)

REM Copy individual frontend files
if exist "package.json" copy "package.json" "%EXPORT_DIR%\frontend\" >nul
if exist "index.html" copy "index.html" "%EXPORT_DIR%\frontend\" >nul
if exist "vite.config.ts" copy "vite.config.ts" "%EXPORT_DIR%\frontend\" >nul
if exist "tailwind.config.js" copy "tailwind.config.js" "%EXPORT_DIR%\frontend\" >nul
if exist "tsconfig.json" copy "tsconfig.json" "%EXPORT_DIR%\frontend\" >nul
if exist "tsconfig.app.json" copy "tsconfig.app.json" "%EXPORT_DIR%\frontend\" >nul
if exist "tsconfig.node.json" copy "tsconfig.node.json" "%EXPORT_DIR%\frontend\" >nul
if exist "postcss.config.js" copy "postcss.config.js" "%EXPORT_DIR%\frontend\" >nul
if exist "eslint.config.js" copy "eslint.config.js" "%EXPORT_DIR%\frontend\" >nul

REM Copy backend files
echo 🔧 Backend files copy करत आहे...
if exist "backend" (
    xcopy "backend" "%EXPORT_DIR%\backend\" /E /I /Q
    echo ✅ backend folder copied
) else (
    echo ⚠️ backend folder not found
)

REM Create README file
echo 📚 README file तयार करत आहे...
(
echo # शाळा हजेरी व्यवस्थापन प्रणाली
echo ## School Attendance Management System
echo.
echo ### 🌟 Features:
echo - 📱 Modern React Frontend with Tailwind CSS
echo - 🔧 Node.js Backend with SQLite Database
echo - 👥 Student Management
echo - 📅 Attendance Tracking  
echo - 📢 Notice Management
echo - 🏆 Achievement Tracking
echo - 📊 Reports and Analytics
echo.
echo ### 🚀 Installation:
echo.
echo #### Frontend:
echo ```bash
echo cd frontend
echo npm install
echo npm run dev
echo ```
echo.
echo #### Backend:
echo ```bash
echo cd backend
echo npm install
echo npm start
echo ```
echo.
echo ### 🔐 Demo Credentials:
echo - Principal: 9876543210 / 9876543210
echo - Teacher: 9876543211 / 9876543211
echo.
echo ### 🌐 URLs:
echo - Frontend: http://localhost:5173
echo - Backend: http://localhost:3000
) > "%EXPORT_DIR%\README.md"

REM Create installation batch file
echo 🔧 Installation script तयार करत आहे...
(
echo @echo off
echo echo 🚀 Installing School Attendance Management System...
echo echo.
echo echo 📱 Installing frontend dependencies...
echo cd frontend
echo npm install
echo if errorlevel 1 ^(
echo     echo ❌ Frontend installation failed
echo     pause
echo     exit /b 1
echo ^)
echo echo ✅ Frontend installed successfully
echo.
echo echo 🔧 Installing backend dependencies...
echo cd ..\backend
echo npm install  
echo if errorlevel 1 ^(
echo     echo ❌ Backend installation failed
echo     pause
echo     exit /b 1
echo ^)
echo echo ✅ Backend installed successfully
echo.
echo cd ..
echo echo.
echo echo 🎉 Installation completed!
echo echo.
echo echo 🚀 To start:
echo echo 1. Backend:  cd backend ^&^& npm start
echo echo 2. Frontend: cd frontend ^&^& npm run dev
echo echo.
echo echo 🔐 Demo Login:
echo echo Principal: 9876543210 / 9876543210
echo echo Teacher: 9876543211 / 9876543211
echo echo.
echo pause
) > "%EXPORT_DIR%\install.bat"

REM Create start script
echo 🚀 Start script तयार करत आहे...
(
echo @echo off
echo echo 🚀 Starting School Attendance Management System...
echo echo.
echo echo 🔧 Starting backend...
echo start "Backend Server" cmd /k "cd backend && npm start"
echo timeout /t 3 /nobreak >nul
echo.
echo echo 📱 Starting frontend...
echo start "Frontend Server" cmd /k "cd frontend && npm run dev"
echo.
echo echo 🎉 Both servers are starting...
echo echo 📱 Frontend: http://localhost:5173
echo echo 🔧 Backend: http://localhost:3000
echo echo.
echo echo Press any key to close this window...
echo pause >nul
) > "%EXPORT_DIR%\start.bat"

REM Count files
echo 📊 Files count करत आहे...
for /f %%i in ('dir "%EXPORT_DIR%\frontend" /s /b 2^>nul ^| find /c /v ""') do set FRONTEND_COUNT=%%i
for /f %%i in ('dir "%EXPORT_DIR%\backend" /s /b 2^>nul ^| find /c /v ""') do set BACKEND_COUNT=%%i

echo.
echo ✅ Export completed successfully!
echo ================================================
echo 📁 Export location: %EXPORT_DIR%
echo 📱 Frontend files: %FRONTEND_COUNT%
echo 🔧 Backend files: %BACKEND_COUNT%
echo.
echo 📦 Ready to ZIP and share!
echo.
echo 🚀 To use:
echo 1. ZIP the '%EXPORT_DIR%' folder
echo 2. Share the ZIP file
echo 3. Receiver should extract and run 'install.bat'
echo 4. Then run 'start.bat' to start servers
echo.
echo 💡 Tip: Right-click on '%EXPORT_DIR%' folder and select "Send to → Compressed folder"
echo.
pause