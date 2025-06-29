@echo off
echo 🚀 Git Setup आणि GitHub Upload Script
echo ==========================================

REM Check if git is installed
git --version >nul 2>&1
if errorlevel 1 (
    echo ❌ Git installed नाही आहे
    echo कृपया Git download करा: https://git-scm.com/download/win
    pause
    exit /b 1
)

echo ✅ Git installed आहे

REM Navigate to project directory
echo 📁 Current directory: %CD%

REM Check if we're in the right directory
if not exist "src" (
    if not exist "backend" (
        echo ❌ हे school attendance project directory नाही
        echo कृपया योग्य folder मध्ये जा
        pause
        exit /b 1
    )
)

echo ✅ Project directory confirmed

REM Remove existing git if any
if exist ".git" (
    echo 🗑️ Existing git repository काढत आहे...
    rmdir /s /q .git
)

REM Initialize new git repository
echo 🔧 नवीन Git repository initialize करत आहे...
git init

REM Check if there are files to add
echo 📝 Files तपासत आहे...
dir /b > temp_files.txt
set /p first_file=<temp_files.txt
del temp_files.txt

if "%first_file%"=="" (
    echo ❌ कोणतेही files नाहीत
    pause
    exit /b 1
)

REM Add all files
echo 📦 सर्व files add करत आहे...
git add .

REM Check if anything was added
git status --porcelain > temp_status.txt
set /p status_check=<temp_status.txt
del temp_status.txt

if "%status_check%"=="" (
    echo ❌ कोणतेही files add झाले नाहीत
    pause
    exit /b 1
)

REM Configure git user if not set
git config user.name >nul 2>&1
if errorlevel 1 (
    echo 👤 Git user configuration...
    set /p username="तुमचे नाव टाका: "
    set /p email="तुमचा email टाका: "
    git config user.name "%username%"
    git config user.email "%email%"
)

REM Create initial commit
echo 💾 Initial commit करत आहे...
git commit -m "Initial commit: School Attendance Management System"

if errorlevel 1 (
    echo ❌ Commit failed
    pause
    exit /b 1
)

echo ✅ Local git repository तयार झाली!

REM Set main branch
git branch -M main

echo ""
echo 🌐 आता GitHub वर repository तयार करा:
echo ""
echo 1. https://github.com वर जा
echo 2. "New repository" क्लिक करा  
echo 3. Repository name: school-attendance-system
echo 4. "Create repository" क्लिक करा
echo 5. तुमचे GitHub username टाका खाली:
echo ""

set /p github_username="GitHub Username: "

if "%github_username%"=="" (
    echo ❌ GitHub username आवश्यक आहे
    pause
    exit /b 1
)

REM Add remote origin
echo 🔗 GitHub repository जोडत आहे...
git remote add origin https://github.com/%github_username%/school-attendance-system.git

REM Push to GitHub
echo 🚀 GitHub वर upload करत आहे...
echo तुमचा GitHub password/token विचारला जाईल...

git push -u origin main

if errorlevel 1 (
    echo ""
    echo ❌ GitHub upload failed
    echo ""
    echo 🔧 Possible solutions:
    echo 1. GitHub repository अस्तित्वात आहे का तपासा
    echo 2. Username योग्य आहे का तपासा  
    echo 3. GitHub login credentials तपासा
    echo 4. Personal Access Token वापरा password ऐवजी
    echo ""
    echo 🔑 Personal Access Token तयार करण्यासाठी:
    echo 1. GitHub.com → Settings → Developer settings
    echo 2. Personal access tokens → Generate new token
    echo 3. Select 'repo' permissions
    echo 4. Copy token आणि password म्हणून वापरा
    echo ""
    pause
    exit /b 1
)

echo ""
echo 🎉 SUCCESS! तुमचा प्रोजेक्ट GitHub वर upload झाला!
echo ""
echo 🌐 Repository URL: https://github.com/%github_username%/school-attendance-system
echo ""
echo 📋 पुढील steps:
echo 1. Repository URL वर जा
echo 2. Code download करण्यासाठी "Code" → "Download ZIP" क्लिक करा
echo 3. किंवा git clone करा: git clone https://github.com/%github_username%/school-attendance-system.git
echo ""
pause