# 🧪 Local Testing Guide - School Attendance System

## 🚀 Quick Start Testing

### Option 1: Automated Testing
```bash
# Run the test script
test-project-locally.bat
```

### Option 2: Manual Testing

#### Backend Testing:
```bash
cd backend
npm install
npm start
```
- Server: http://localhost:3000
- Health: http://localhost:3000/health

#### Frontend Testing:
```bash
npm install  
npm run dev
```
- App: http://localhost:5173

## 🔐 Demo Credentials

| Role | Mobile | Password |
|------|--------|----------|
| **Principal** | 9876543210 | 9876543210 |
| **Teacher** | 9876543211 | 9876543211 |

## 🧪 Testing Checklist

### ✅ Authentication Test:
1. Open http://localhost:5173
2. Login with demo credentials
3. Verify dashboard loads

### ✅ Student Management Test:
1. Go to Students section
2. View student list (6 sample students)
3. Try adding new student
4. Test search and filters

### ✅ Attendance Test:
1. Go to Attendance section
2. Mark attendance for students
3. Save attendance
4. Check statistics update

### ✅ Notice System Test:
1. Go to Notices section
2. Create new notice
3. Set priority and type
4. Verify notice appears in list

### ✅ Achievement Test:
1. Go to Achievements section
2. Add achievement for student
3. Select category and level
4. Check achievement in reports

### ✅ Reports Test:
1. Go to Reports section
2. View attendance statistics
3. Check monthly reports
4. Test export functionality

## 🔧 API Testing

### Health Check:
```bash
curl http://localhost:3000/health
```

### Login Test:
```bash
curl -X POST http://localhost:3000/api/auth/login \
  -H "Content-Type: application/json" \
  -d '{"mobile":"9876543210","password":"9876543210","role":"principal"}'
```

### Students List:
```bash
curl http://localhost:3000/api/students/list \
  -H "Authorization: Bearer YOUR_TOKEN"
```

## 🐛 Troubleshooting

### Common Issues:

#### Port Already in Use:
```bash
# Kill processes on ports
netstat -ano | findstr :3000
netstat -ano | findstr :5173
taskkill /PID <PID_NUMBER> /F
```

#### Dependencies Issues:
```bash
# Clean install
rm -rf node_modules package-lock.json
npm install

# Backend
cd backend
rm -rf node_modules package-lock.json  
npm install
```

#### Database Issues:
```bash
# Reset database
cd backend
del school.db
npm start  # Will recreate with sample data
```

## 📊 Expected Results

### Sample Data Included:
- **1 School**: डेमो प्राथमिक शाळा
- **2 Users**: 1 Principal + 1 Teacher
- **6 Students**: Class 5-A with complete profiles
- **3 Notices**: Sample notices with different types
- **4 Achievements**: Sample achievements for students

### Features to Test:
- ✅ User authentication (JWT)
- ✅ Student CRUD operations
- ✅ Attendance marking and statistics
- ✅ Notice management with priorities
- ✅ Achievement tracking system
- ✅ Responsive design (mobile/desktop)
- ✅ Real-time data updates
- ✅ Export functionality

## 🎯 Performance Expectations

### Load Times:
- Backend startup: ~3-5 seconds
- Frontend startup: ~5-10 seconds
- Page navigation: <1 second
- API responses: <500ms

### Browser Compatibility:
- ✅ Chrome (recommended)
- ✅ Firefox
- ✅ Edge
- ✅ Safari

## 📱 Mobile Testing

### Responsive Breakpoints:
- Mobile: 320px - 768px
- Tablet: 768px - 1024px  
- Desktop: 1024px+

### Touch Testing:
- Tap targets ≥44px
- Swipe gestures
- Pinch to zoom
- Orientation changes

## 🔍 Debug Mode

### Enable Debug Logs:
```bash
# Backend
set DEBUG=school:*
npm start

# Frontend  
set VITE_DEBUG=true
npm run dev
```

### Browser DevTools:
- Console: Check for errors
- Network: Monitor API calls
- Application: Check localStorage
- Performance: Monitor load times

## ✅ Success Criteria

Your test is successful if:
1. ✅ Both servers start without errors
2. ✅ Login works with demo credentials  
3. ✅ All main sections load properly
4. ✅ CRUD operations work for students
5. ✅ Attendance can be marked and saved
6. ✅ Notices can be created and viewed
7. ✅ Achievements can be added
8. ✅ Reports display correct data
9. ✅ Mobile responsive design works
10. ✅ No console errors in browser

## 🆘 Get Help

If you encounter issues:
1. Check console logs in both terminals
2. Verify Node.js version (≥16.0.0)
3. Ensure ports 3000 and 5173 are free
4. Check internet connection for npm installs
5. Try running as administrator if permission issues

Happy Testing! 🎉