import React, { useState, useEffect } from 'react';
import { Users, Calendar, BookOpen, Settings, LogOut, Menu, X, School, UserCheck, UserX, TrendingUp, Bell, Home, FileText, Clock } from 'lucide-react';

interface User {
  id: number;
  name: string;
  role: 'principal' | 'teacher';
  school: string;
  class?: string;
  section?: string;
}

interface Student {
  id: number;
  rollNumber: number;
  name: string;
  motherName: string;
  fatherName?: string;
  class: string;
  section: string;
  parentMobile: string;
  birthDate?: string;
  address?: string;
  isActive: boolean;
}

interface AttendanceRecord {
  studentId: number;
  status: 'present' | 'absent' | 'late';
  date: string;
  remarks?: string;
}

interface StudyMessage {
  id: number;
  message: string;
  date: string;
  time: string;
}

const App: React.FC = () => {
  const [currentUser, setCurrentUser] = useState<User | null>(null);
  const [activeSection, setActiveSection] = useState('dashboard');
  const [sidebarOpen, setSidebarOpen] = useState(false);
  const [students, setStudents] = useState<Student[]>([]);
  const [attendance, setAttendance] = useState<AttendanceRecord[]>([]);
  const [studyMessages, setStudyMessages] = useState<StudyMessage[]>([]);
  const [selectedDate, setSelectedDate] = useState(new Date().toISOString().split('T')[0]);
  const [studyMessageText, setStudyMessageText] = useState('');
  const [showAddStudentModal, setShowAddStudentModal] = useState(false);
  const [newStudent, setNewStudent] = useState({
    rollNumber: '',
    name: '',
    motherName: '',
    fatherName: '',
    parentMobile: '',
    birthDate: '',
    address: ''
  });

  // Sample data initialization
  useEffect(() => {
    // Sample user
    setCurrentUser({
      id: 1,
      name: 'सुनीता देवी',
      role: 'teacher',
      school: 'डेमो प्राथमिक शाळा',
      class: '5',
      section: 'A'
    });

    // Sample students
    setStudents([
      { id: 1, rollNumber: 1, name: 'राहुल शर्मा', motherName: 'सुनीता शर्मा', fatherName: 'राम शर्मा', class: '5', section: 'A', parentMobile: '9876543212', birthDate: '2015-05-15', address: 'नागपूर', isActive: true },
      { id: 2, rollNumber: 2, name: 'प्रिया पाटील', motherName: 'अनीता पाटील', fatherName: 'सुनील पाटील', class: '5', section: 'A', parentMobile: '9876543213', birthDate: '2015-03-20', address: 'नागपूर', isActive: true },
      { id: 3, rollNumber: 3, name: 'अमित कुमार', motherName: 'सुनील कुमार', fatherName: 'राज कुमार', class: '5', section: 'A', parentMobile: '9876543214', birthDate: '2015-07-10', address: 'नागपूर', isActive: true },
      { id: 4, rollNumber: 4, name: 'अनिता राव', motherName: 'सुमित्रा राव', fatherName: 'विनोद राव', class: '5', section: 'A', parentMobile: '9876543215', birthDate: '2015-01-25', address: 'नागपूर', isActive: true },
      { id: 5, rollNumber: 5, name: 'विकास जोशी', motherName: 'मीरा जोशी', fatherName: 'अशोक जोशी', class: '5', section: 'A', parentMobile: '9876543216', birthDate: '2015-09-12', address: 'नागपूर', isActive: true }
    ]);

    // Sample study messages
    setStudyMessages([
      { id: 1, message: 'गणित: पान क्र. 45-46 वाचा आणि उदाहरणे सोडवा', date: new Date(Date.now() - 86400000).toISOString().split('T')[0], time: '16:30' },
      { id: 2, message: 'मराठी: कविता पाठ करा आणि अर्थ लिहा', date: new Date(Date.now() - 172800000).toISOString().split('T')[0], time: '16:15' }
    ]);
  }, []);

  const menuItems = [
    { id: 'dashboard', label: 'डॅशबोर्ड', icon: Home },
    { id: 'students', label: 'विद्यार्थी', icon: Users },
    { id: 'attendance', label: 'हजेरी', icon: Calendar },
    { id: 'study', label: 'अभ्यास', icon: BookOpen },
    { id: 'reports', label: 'अहवाल', icon: FileText },
    { id: 'settings', label: 'सेटिंग्ज', icon: Settings }
  ];

  const markAttendance = (studentId: number, status: 'present' | 'absent' | 'late') => {
    setAttendance(prev => {
      const existing = prev.find(a => a.studentId === studentId && a.date === selectedDate);
      if (existing) {
        return prev.map(a => 
          a.studentId === studentId && a.date === selectedDate 
            ? { ...a, status }
            : a
        );
      } else {
        return [...prev, { studentId, status, date: selectedDate }];
      }
    });
  };

  const getAttendanceStatus = (studentId: number) => {
    return attendance.find(a => a.studentId === studentId && a.date === selectedDate)?.status;
  };

  const getAttendanceStats = () => {
    const todayAttendance = attendance.filter(a => a.date === selectedDate);
    const present = todayAttendance.filter(a => a.status === 'present').length;
    const absent = todayAttendance.filter(a => a.status === 'absent').length;
    const late = todayAttendance.filter(a => a.status === 'late').length;
    return { present, absent, late, total: students.length };
  };

  const saveAttendance = () => {
    const markedStudents = attendance.filter(a => a.date === selectedDate);
    if (markedStudents.length === students.length) {
      alert(`हजेरी यशस्वीरित्या जतन केली! ${markedStudents.filter(a => a.status === 'present').length} उपस्थित, ${markedStudents.filter(a => a.status === 'absent').length} अनुपस्थित`);
    } else {
      alert('कृपया सर्व विद्यार्थ्यांची हजेरी नोंदवा');
    }
  };

  const sendStudyMessage = () => {
    if (studyMessageText.trim()) {
      const newMessage: StudyMessage = {
        id: Date.now(),
        message: studyMessageText,
        date: new Date().toISOString().split('T')[0],
        time: new Date().toLocaleTimeString('hi-IN', { hour: '2-digit', minute: '2-digit' })
      };
      setStudyMessages(prev => [newMessage, ...prev]);
      setStudyMessageText('');
      alert(`अभ्यास संदेश ${students.length} पालकांना पाठवला गेला!`);
    }
  };

  const addStudent = () => {
    if (newStudent.name && newStudent.motherName && newStudent.parentMobile && newStudent.rollNumber) {
      const student: Student = {
        id: Date.now(),
        rollNumber: parseInt(newStudent.rollNumber),
        name: newStudent.name,
        motherName: newStudent.motherName,
        fatherName: newStudent.fatherName,
        class: currentUser?.class || '5',
        section: currentUser?.section || 'A',
        parentMobile: newStudent.parentMobile,
        birthDate: newStudent.birthDate,
        address: newStudent.address,
        isActive: true
      };
      setStudents(prev => [...prev, student]);
      setNewStudent({
        rollNumber: '',
        name: '',
        motherName: '',
        fatherName: '',
        parentMobile: '',
        birthDate: '',
        address: ''
      });
      setShowAddStudentModal(false);
      alert('विद्यार्थी यशस्वीरित्या जोडला गेला!');
    } else {
      alert('कृपया सर्व आवश्यक माहिती भरा');
    }
  };

  const stats = getAttendanceStats();

  const renderDashboard = () => (
    <div className="space-y-8">
      {/* Welcome Section */}
      <div className="bg-gradient-to-r from-blue-600 to-purple-600 rounded-2xl p-8 text-white">
        <div className="flex items-center justify-between">
          <div>
            <h2 className="text-3xl font-bold mb-2">नमस्कार, {currentUser?.name}!</h2>
            <p className="text-blue-100 text-lg">{currentUser?.school}</p>
            <p className="text-blue-200">इयत्ता {currentUser?.class}-{currentUser?.section}</p>
          </div>
          <div className="text-right">
            <p className="text-blue-100">आजची तारीख</p>
            <p className="text-2xl font-bold">
              {new Date().toLocaleDateString('hi-IN', { 
                day: 'numeric', 
                month: 'long',
                year: 'numeric'
              })}
            </p>
          </div>
        </div>
      </div>

      {/* Stats Cards */}
      <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-4 gap-6">
        <div className="bg-white rounded-xl shadow-lg p-6 border-l-4 border-blue-500 hover:shadow-xl transition-shadow">
          <div className="flex items-center justify-between">
            <div>
              <p className="text-sm font-medium text-gray-600">एकूण विद्यार्थी</p>
              <p className="text-3xl font-bold text-gray-900">{students.length}</p>
            </div>
            <Users className="h-12 w-12 text-blue-500" />
          </div>
        </div>
        
        <div className="bg-white rounded-xl shadow-lg p-6 border-l-4 border-green-500 hover:shadow-xl transition-shadow">
          <div className="flex items-center justify-between">
            <div>
              <p className="text-sm font-medium text-gray-600">आज उपस्थित</p>
              <p className="text-3xl font-bold text-gray-900">{stats.present}</p>
            </div>
            <UserCheck className="h-12 w-12 text-green-500" />
          </div>
        </div>
        
        <div className="bg-white rounded-xl shadow-lg p-6 border-l-4 border-red-500 hover:shadow-xl transition-shadow">
          <div className="flex items-center justify-between">
            <div>
              <p className="text-sm font-medium text-gray-600">आज अनुपस्थित</p>
              <p className="text-3xl font-bold text-gray-900">{stats.absent}</p>
            </div>
            <UserX className="h-12 w-12 text-red-500" />
          </div>
        </div>
        
        <div className="bg-white rounded-xl shadow-lg p-6 border-l-4 border-yellow-500 hover:shadow-xl transition-shadow">
          <div className="flex items-center justify-between">
            <div>
              <p className="text-sm font-medium text-gray-600">उपस्थिती %</p>
              <p className="text-3xl font-bold text-gray-900">
                {stats.total > 0 ? Math.round((stats.present / stats.total) * 100) : 0}%
              </p>
            </div>
            <TrendingUp className="h-12 w-12 text-yellow-500" />
          </div>
        </div>
      </div>

      {/* Quick Actions */}
      <div className="bg-white rounded-xl shadow-lg p-8">
        <h3 className="text-xl font-bold text-gray-900 mb-6 flex items-center">
          <Bell className="h-6 w-6 mr-2 text-blue-600" />
          आजची कामे
        </h3>
        <div className="grid grid-cols-1 md:grid-cols-3 gap-6">
          <button 
            onClick={() => setActiveSection('attendance')}
            className="group p-6 bg-gradient-to-br from-blue-50 to-blue-100 rounded-xl border border-blue-200 hover:from-blue-100 hover:to-blue-200 transition-all duration-300 transform hover:scale-105"
          >
            <Calendar className="h-10 w-10 text-blue-600 mx-auto mb-3 group-hover:scale-110 transition-transform" />
            <p className="font-semibold text-blue-900">हजेरी घ्या</p>
            <p className="text-sm text-blue-700 mt-1">आजची उपस्थिती नोंदवा</p>
          </button>
          
          <button 
            onClick={() => setActiveSection('study')}
            className="group p-6 bg-gradient-to-br from-green-50 to-green-100 rounded-xl border border-green-200 hover:from-green-100 hover:to-green-200 transition-all duration-300 transform hover:scale-105"
          >
            <BookOpen className="h-10 w-10 text-green-600 mx-auto mb-3 group-hover:scale-110 transition-transform" />
            <p className="font-semibold text-green-900">अभ्यास पाठवा</p>
            <p className="text-sm text-green-700 mt-1">गृहपाठ आणि अभ्यास</p>
          </button>
          
          <button 
            onClick={() => setActiveSection('students')}
            className="group p-6 bg-gradient-to-br from-purple-50 to-purple-100 rounded-xl border border-purple-200 hover:from-purple-100 hover:to-purple-200 transition-all duration-300 transform hover:scale-105"
          >
            <Users className="h-10 w-10 text-purple-600 mx-auto mb-3 group-hover:scale-110 transition-transform" />
            <p className="font-semibold text-purple-900">विद्यार्थी पाहा</p>
            <p className="text-sm text-purple-700 mt-1">विद्यार्थी व्यवस्थापन</p>
          </button>
        </div>
      </div>

      {/* Recent Activity */}
      <div className="bg-white rounded-xl shadow-lg p-6">
        <h3 className="text-lg font-semibold text-gray-900 mb-4 flex items-center">
          <Clock className="h-5 w-5 mr-2 text-gray-600" />
          अलीकडील क्रियाकलाप
        </h3>
        <div className="space-y-3">
          {studyMessages.slice(0, 3).map((msg, index) => (
            <div key={msg.id} className="flex items-start space-x-3 p-3 bg-gray-50 rounded-lg">
              <BookOpen className="h-5 w-5 text-blue-600 mt-1" />
              <div className="flex-1">
                <p className="text-sm text-gray-900">{msg.message}</p>
                <p className="text-xs text-gray-500 mt-1">
                  {new Date(msg.date).toLocaleDateString('hi-IN')} - {msg.time}
                </p>
              </div>
            </div>
          ))}
          {studyMessages.length === 0 && (
            <p className="text-gray-500 text-center py-4">अद्याप कोणतीही क्रियाकलाप नाही</p>
          )}
        </div>
      </div>
    </div>
  );

  const renderStudents = () => (
    <div className="space-y-6">
      <div className="bg-white rounded-xl shadow-lg p-6">
        <div className="flex justify-between items-center mb-6">
          <h3 className="text-xl font-bold text-gray-900">विद्यार्थी यादी</h3>
          <button 
            onClick={() => setShowAddStudentModal(true)}
            className="bg-blue-600 text-white px-6 py-3 rounded-lg hover:bg-blue-700 transition-colors font-medium flex items-center space-x-2"
          >
            <Users className="h-5 w-5" />
            <span>नवीन विद्यार्थी जोडा</span>
          </button>
        </div>
        
        <div className="overflow-x-auto">
          <table className="min-w-full divide-y divide-gray-200">
            <thead className="bg-gray-50">
              <tr>
                <th className="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">हजेरी क्र.</th>
                <th className="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">नाव</th>
                <th className="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">आईचे नाव</th>
                <th className="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">वडिलांचे नाव</th>
                <th className="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">मोबाईल</th>
                <th className="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">जन्मतारीख</th>
              </tr>
            </thead>
            <tbody className="bg-white divide-y divide-gray-200">
              {students.map((student) => (
                <tr key={student.id} className="hover:bg-gray-50 transition-colors">
                  <td className="px-6 py-4 whitespace-nowrap">
                    <div className="w-8 h-8 bg-blue-600 text-white rounded-full flex items-center justify-center font-semibold text-sm">
                      {student.rollNumber}
                    </div>
                  </td>
                  <td className="px-6 py-4 whitespace-nowrap text-sm font-medium text-gray-900">
                    {student.name}
                  </td>
                  <td className="px-6 py-4 whitespace-nowrap text-sm text-gray-900">
                    {student.motherName}
                  </td>
                  <td className="px-6 py-4 whitespace-nowrap text-sm text-gray-900">
                    {student.fatherName || '-'}
                  </td>
                  <td className="px-6 py-4 whitespace-nowrap text-sm text-gray-900">
                    {student.parentMobile}
                  </td>
                  <td className="px-6 py-4 whitespace-nowrap text-sm text-gray-900">
                    {student.birthDate ? new Date(student.birthDate).toLocaleDateString('hi-IN') : '-'}
                  </td>
                </tr>
              ))}
            </tbody>
          </table>
        </div>
      </div>
    </div>
  );

  const renderAttendance = () => (
    <div className="space-y-6">
      <div className="bg-white rounded-xl shadow-lg p-6">
        <div className="flex justify-between items-center mb-6">
          <h3 className="text-xl font-bold text-gray-900">आजची हजेरी</h3>
          <div className="flex items-center space-x-4">
            <label className="text-sm font-medium text-gray-700">तारीख:</label>
            <input
              type="date"
              value={selectedDate}
              onChange={(e) => setSelectedDate(e.target.value)}
              className="border border-gray-300 rounded-lg px-3 py-2 focus:ring-2 focus:ring-blue-500 focus:border-transparent"
            />
          </div>
        </div>
        
        <div className="space-y-4">
          {students.map((student) => {
            const status = getAttendanceStatus(student.id);
            return (
              <div key={student.id} className="flex items-center justify-between p-4 bg-gray-50 rounded-lg hover:bg-gray-100 transition-colors">
                <div className="flex items-center space-x-4">
                  <div className="w-12 h-12 bg-blue-600 text-white rounded-full flex items-center justify-center font-bold">
                    {student.rollNumber}
                  </div>
                  <div>
                    <p className="font-semibold text-gray-900">{student.name}</p>
                    <p className="text-sm text-gray-600">{student.motherName}</p>
                    <p className="text-xs text-gray-500">{student.parentMobile}</p>
                  </div>
                </div>
                
                <div className="flex space-x-2">
                  <button
                    onClick={() => markAttendance(student.id, 'present')}
                    className={`px-4 py-2 rounded-lg font-medium transition-all duration-200 ${
                      status === 'present'
                        ? 'bg-green-600 text-white shadow-lg transform scale-105'
                        : 'bg-gray-200 text-gray-700 hover:bg-green-100 hover:text-green-700'
                    }`}
                  >
                    उपस्थित
                  </button>
                  <button
                    onClick={() => markAttendance(student.id, 'absent')}
                    className={`px-4 py-2 rounded-lg font-medium transition-all duration-200 ${
                      status === 'absent'
                        ? 'bg-red-600 text-white shadow-lg transform scale-105'
                        : 'bg-gray-200 text-gray-700 hover:bg-red-100 hover:text-red-700'
                    }`}
                  >
                    अनुपस्थित
                  </button>
                  <button
                    onClick={() => markAttendance(student.id, 'late')}
                    className={`px-4 py-2 rounded-lg font-medium transition-all duration-200 ${
                      status === 'late'
                        ? 'bg-yellow-600 text-white shadow-lg transform scale-105'
                        : 'bg-gray-200 text-gray-700 hover:bg-yellow-100 hover:text-yellow-700'
                    }`}
                  >
                    उशीर
                  </button>
                </div>
              </div>
            );
          })}
        </div>
        
        <div className="mt-8 text-center">
          <button 
            onClick={saveAttendance}
            className="bg-blue-600 text-white px-8 py-3 rounded-lg hover:bg-blue-700 transition-colors font-medium text-lg shadow-lg hover:shadow-xl transform hover:scale-105"
          >
            हजेरी जतन करा
          </button>
        </div>
      </div>
    </div>
  );

  const renderStudy = () => (
    <div className="space-y-6">
      <div className="bg-white rounded-xl shadow-lg p-6">
        <h3 className="text-xl font-bold text-gray-900 mb-6">आजचा अभ्यास पाठवा</h3>
        
        <div className="space-y-4">
          <div>
            <label className="block text-sm font-medium text-gray-700 mb-2">
              अभ्यास संदेश
            </label>
            <textarea
              rows={5}
              value={studyMessageText}
              onChange={(e) => setStudyMessageText(e.target.value)}
              className="w-full border border-gray-300 rounded-lg px-4 py-3 focus:ring-2 focus:ring-blue-500 focus:border-transparent resize-none"
              placeholder="आजचा अभ्यास लिहा... (उदा: गणित: पान क्र. 45-46 वाचा आणि उदाहरणे सोडवा)"
              maxLength={500}
            />
            <p className="text-sm text-gray-500 mt-1">{studyMessageText.length}/500 अक्षरे</p>
          </div>
          
          <div className="flex justify-between items-center">
            <p className="text-sm text-gray-600 flex items-center">
              <Users className="h-4 w-4 mr-1" />
              सर्व {students.length} पालकांना पाठवले जाईल
            </p>
            <button 
              onClick={sendStudyMessage}
              disabled={!studyMessageText.trim()}
              className="bg-green-600 text-white px-6 py-2 rounded-lg hover:bg-green-700 transition-colors font-medium disabled:bg-gray-400 disabled:cursor-not-allowed"
            >
              पाठवा
            </button>
          </div>
        </div>
      </div>
      
      <div className="bg-white rounded-xl shadow-lg p-6">
        <h3 className="text-lg font-semibold text-gray-900 mb-4">मागील संदेश</h3>
        <div className="space-y-3">
          {studyMessages.map((msg) => (
            <div key={msg.id} className="p-4 bg-gray-50 rounded-lg border-l-4 border-blue-500">
              <p className="text-sm text-gray-900 mb-2">{msg.message}</p>
              <p className="text-xs text-gray-500">
                {new Date(msg.date).toLocaleDateString('hi-IN')} - {msg.time}
              </p>
            </div>
          ))}
          {studyMessages.length === 0 && (
            <p className="text-gray-500 text-center py-8">अद्याप कोणतेही संदेश पाठवलेले नाहीत</p>
          )}
        </div>
      </div>
    </div>
  );

  const renderReports = () => (
    <div className="space-y-6">
      <div className="bg-white rounded-xl shadow-lg p-6">
        <h3 className="text-xl font-bold text-gray-900 mb-6">हजेरी अहवाल</h3>
        
        <div className="grid grid-cols-1 md:grid-cols-3 gap-6">
          <div className="bg-blue-50 p-6 rounded-lg border border-blue-200">
            <h4 className="font-semibold text-blue-900 mb-2">आजचा अहवाल</h4>
            <div className="space-y-2">
              <p className="text-sm">उपस्थित: <span className="font-bold text-green-600">{stats.present}</span></p>
              <p className="text-sm">अनुपस्थित: <span className="font-bold text-red-600">{stats.absent}</span></p>
              <p className="text-sm">उशीर: <span className="font-bold text-yellow-600">{stats.late}</span></p>
              <p className="text-sm">एकूण: <span className="font-bold">{stats.total}</span></p>
            </div>
          </div>
          
          <div className="bg-green-50 p-6 rounded-lg border border-green-200">
            <h4 className="font-semibold text-green-900 mb-2">या आठवड्याचा अहवाल</h4>
            <div className="space-y-2">
              <p className="text-sm">सरासरी उपस्थिती: <span className="font-bold">85%</span></p>
              <p className="text-sm">सर्वाधिक उपस्थिती: <span className="font-bold">92%</span></p>
              <p className="text-sm">कमीत कमी उपस्थिती: <span className="font-bold">78%</span></p>
            </div>
          </div>
          
          <div className="bg-purple-50 p-6 rounded-lg border border-purple-200">
            <h4 className="font-semibold text-purple-900 mb-2">या महिन्याचा अहवाल</h4>
            <div className="space-y-2">
              <p className="text-sm">सरासरी उपस्थिती: <span className="font-bold">88%</span></p>
              <p className="text-sm">एकूण कार्यदिवस: <span className="font-bold">22</span></p>
              <p className="text-sm">अभ्यास संदेश: <span className="font-bold">{studyMessages.length}</span></p>
            </div>
          </div>
        </div>
      </div>
      
      <div className="bg-white rounded-xl shadow-lg p-6">
        <h3 className="text-lg font-semibold text-gray-900 mb-4">विद्यार्थी उपस्थिती तपशील</h3>
        <div className="overflow-x-auto">
          <table className="min-w-full divide-y divide-gray-200">
            <thead className="bg-gray-50">
              <tr>
                <th className="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase">विद्यार्थी</th>
                <th className="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase">आजची स्थिती</th>
                <th className="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase">या आठवड्यात</th>
                <th className="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase">या महिन्यात</th>
              </tr>
            </thead>
            <tbody className="bg-white divide-y divide-gray-200">
              {students.map((student) => {
                const todayStatus = getAttendanceStatus(student.id);
                return (
                  <tr key={student.id} className="hover:bg-gray-50">
                    <td className="px-6 py-4 whitespace-nowrap">
                      <div className="flex items-center">
                        <div className="w-8 h-8 bg-blue-600 text-white rounded-full flex items-center justify-center text-sm font-semibold mr-3">
                          {student.rollNumber}
                        </div>
                        <div>
                          <p className="text-sm font-medium text-gray-900">{student.name}</p>
                        </div>
                      </div>
                    </td>
                    <td className="px-6 py-4 whitespace-nowrap">
                      <span className={`inline-flex px-2 py-1 text-xs font-semibold rounded-full ${
                        todayStatus === 'present' ? 'bg-green-100 text-green-800' :
                        todayStatus === 'absent' ? 'bg-red-100 text-red-800' :
                        todayStatus === 'late' ? 'bg-yellow-100 text-yellow-800' :
                        'bg-gray-100 text-gray-800'
                      }`}>
                        {todayStatus === 'present' ? 'उपस्थित' :
                         todayStatus === 'absent' ? 'अनुपस्थित' :
                         todayStatus === 'late' ? 'उशीर' : 'नोंद नाही'}
                      </span>
                    </td>
                    <td className="px-6 py-4 whitespace-nowrap text-sm text-gray-900">
                      {Math.floor(Math.random() * 20) + 80}%
                    </td>
                    <td className="px-6 py-4 whitespace-nowrap text-sm text-gray-900">
                      {Math.floor(Math.random() * 15) + 85}%
                    </td>
                  </tr>
                );
              })}
            </tbody>
          </table>
        </div>
      </div>
    </div>
  );

  const renderSettings = () => (
    <div className="space-y-6">
      <div className="bg-white rounded-xl shadow-lg p-6">
        <h3 className="text-xl font-bold text-gray-900 mb-6">प्रोफाइल माहिती</h3>
        
        <div className="grid grid-cols-1 md:grid-cols-2 gap-6">
          <div>
            <label className="block text-sm font-medium text-gray-700 mb-2">नाव</label>
            <input
              type="text"
              value={currentUser?.name || ''}
              className="w-full border border-gray-300 rounded-lg px-3 py-2 bg-gray-50"
              readOnly
            />
          </div>
          
          <div>
            <label className="block text-sm font-medium text-gray-700 mb-2">भूमिका</label>
            <input
              type="text"
              value={currentUser?.role === 'teacher' ? 'शिक्षक' : 'मुख्याध्यापक'}
              className="w-full border border-gray-300 rounded-lg px-3 py-2 bg-gray-50"
              readOnly
            />
          </div>
          
          <div>
            <label className="block text-sm font-medium text-gray-700 mb-2">शाळा</label>
            <input
              type="text"
              value={currentUser?.school || ''}
              className="w-full border border-gray-300 rounded-lg px-3 py-2 bg-gray-50"
              readOnly
            />
          </div>
          
          {currentUser?.class && (
            <div>
              <label className="block text-sm font-medium text-gray-700 mb-2">इयत्ता-तुकडी</label>
              <input
                type="text"
                value={`${currentUser.class}-${currentUser.section}`}
                className="w-full border border-gray-300 rounded-lg px-3 py-2 bg-gray-50"
                readOnly
              />
            </div>
          )}
        </div>
      </div>
      
      <div className="bg-white rounded-xl shadow-lg p-6">
        <h3 className="text-xl font-bold text-gray-900 mb-6">पासवर्ड बदला</h3>
        
        <div className="space-y-4 max-w-md">
          <div>
            <label className="block text-sm font-medium text-gray-700 mb-2">सध्याचा पासवर्ड</label>
            <input
              type="password"
              className="w-full border border-gray-300 rounded-lg px-3 py-2 focus:ring-2 focus:ring-blue-500 focus:border-transparent"
            />
          </div>
          
          <div>
            <label className="block text-sm font-medium text-gray-700 mb-2">नवीन पासवर्ड</label>
            <input
              type="password"
              className="w-full border border-gray-300 rounded-lg px-3 py-2 focus:ring-2 focus:ring-blue-500 focus:border-transparent"
            />
          </div>
          
          <div>
            <label className="block text-sm font-medium text-gray-700 mb-2">नवीन पासवर्ड पुष्टी</label>
            <input
              type="password"
              className="w-full border border-gray-300 rounded-lg px-3 py-2 focus:ring-2 focus:ring-blue-500 focus:border-transparent"
            />
          </div>
          
          <button className="bg-blue-600 text-white px-6 py-2 rounded-lg hover:bg-blue-700 transition-colors font-medium">
            पासवर्ड बदला
          </button>
        </div>
      </div>
    </div>
  );

  const renderContent = () => {
    switch (activeSection) {
      case 'dashboard':
        return renderDashboard();
      case 'students':
        return renderStudents();
      case 'attendance':
        return renderAttendance();
      case 'study':
        return renderStudy();
      case 'reports':
        return renderReports();
      case 'settings':
        return renderSettings();
      default:
        return renderDashboard();
    }
  };

  return (
    <div className="min-h-screen bg-gray-100">
      {/* Mobile menu overlay */}
      {sidebarOpen && (
        <div 
          className="fixed inset-0 bg-black bg-opacity-50 z-40 lg:hidden"
          onClick={() => setSidebarOpen(false)}
        />
      )}

      {/* Sidebar */}
      <div className={`fixed inset-y-0 left-0 z-50 w-64 bg-gradient-to-b from-blue-800 to-blue-900 transform ${sidebarOpen ? 'translate-x-0' : '-translate-x-full'} transition-transform duration-300 ease-in-out lg:translate-x-0 lg:static lg:inset-0`}>
        <div className="flex items-center justify-between h-16 px-6 bg-blue-900">
          <div className="flex items-center space-x-2">
            <School className="h-8 w-8 text-white" />
            <span className="text-white font-bold text-lg">शाळा व्यवस्थापन</span>
          </div>
          <button
            onClick={() => setSidebarOpen(false)}
            className="lg:hidden text-white hover:text-gray-300"
          >
            <X className="h-6 w-6" />
          </button>
        </div>

        <div className="px-6 py-4 border-b border-blue-700">
          <div className="text-white">
            <p className="font-medium">{currentUser?.name}</p>
            <p className="text-sm text-blue-200">{currentUser?.school}</p>
            {currentUser?.class && (
              <p className="text-sm text-blue-200">इयत्ता {currentUser.class}-{currentUser.section}</p>
            )}
          </div>
        </div>

        <nav className="mt-6">
          {menuItems.map((item) => {
            const Icon = item.icon;
            return (
              <button
                key={item.id}
                onClick={() => {
                  setActiveSection(item.id);
                  setSidebarOpen(false);
                }}
                className={`w-full flex items-center px-6 py-3 text-left hover:bg-blue-700 transition-colors ${
                  activeSection === item.id ? 'bg-blue-700 border-r-4 border-white' : ''
                }`}
              >
                <Icon className="h-5 w-5 text-white mr-3" />
                <span className="text-white">{item.label}</span>
              </button>
            );
          })}
          
          <button
            onClick={() => setCurrentUser(null)}
            className="w-full flex items-center px-6 py-3 text-left hover:bg-blue-700 transition-colors mt-4"
          >
            <LogOut className="h-5 w-5 text-white mr-3" />
            <span className="text-white">लॉगआउट</span>
          </button>
        </nav>
      </div>

      {/* Main content */}
      <div className="lg:ml-64">
        {/* Top bar */}
        <div className="bg-white shadow-sm border-b border-gray-200">
          <div className="flex items-center justify-between h-16 px-6">
            <div className="flex items-center">
              <button
                onClick={() => setSidebarOpen(true)}
                className="lg:hidden text-gray-600 hover:text-gray-900"
              >
                <Menu className="h-6 w-6" />
              </button>
              <h1 className="ml-4 lg:ml-0 text-xl font-semibold text-gray-900">
                {menuItems.find(item => item.id === activeSection)?.label || 'डॅशबोर्ड'}
              </h1>
            </div>
            <div className="text-sm text-gray-600">
              {new Date().toLocaleDateString('hi-IN', { 
                weekday: 'long', 
                year: 'numeric', 
                month: 'long', 
                day: 'numeric' 
              })}
            </div>
          </div>
        </div>

        {/* Page content */}
        <main className="p-6">
          {renderContent()}
        </main>
      </div>

      {/* Add Student Modal */}
      {showAddStudentModal && (
        <div className="fixed inset-0 bg-black bg-opacity-50 z-50 flex items-center justify-center p-4">
          <div className="bg-white rounded-xl shadow-xl max-w-2xl w-full max-h-[90vh] overflow-y-auto">
            <div className="p-6 border-b border-gray-200">
              <div className="flex items-center justify-between">
                <h3 className="text-xl font-bold text-gray-900">नवीन विद्यार्थी जोडा</h3>
                <button
                  onClick={() => setShowAddStudentModal(false)}
                  className="text-gray-400 hover:text-gray-600"
                >
                  <X className="h-6 w-6" />
                </button>
              </div>
            </div>
            
            <div className="p-6 space-y-4">
              <div className="grid grid-cols-1 md:grid-cols-2 gap-4">
                <div>
                  <label className="block text-sm font-medium text-gray-700 mb-2">हजेरी क्रमांक *</label>
                  <input
                    type="number"
                    value={newStudent.rollNumber}
                    onChange={(e) => setNewStudent({...newStudent, rollNumber: e.target.value})}
                    className="w-full border border-gray-300 rounded-lg px-3 py-2 focus:ring-2 focus:ring-blue-500 focus:border-transparent"
                    required
                  />
                </div>
                
                <div>
                  <label className="block text-sm font-medium text-gray-700 mb-2">विद्यार्थ्याचे नाव *</label>
                  <input
                    type="text"
                    value={newStudent.name}
                    onChange={(e) => setNewStudent({...newStudent, name: e.target.value})}
                    className="w-full border border-gray-300 rounded-lg px-3 py-2 focus:ring-2 focus:ring-blue-500 focus:border-transparent"
                    required
                  />
                </div>
                
                <div>
                  <label className="block text-sm font-medium text-gray-700 mb-2">आईचे नाव *</label>
                  <input
                    type="text"
                    value={newStudent.motherName}
                    onChange={(e) => setNewStudent({...newStudent, motherName: e.target.value})}
                    className="w-full border border-gray-300 rounded-lg px-3 py-2 focus:ring-2 focus:ring-blue-500 focus:border-transparent"
                    required
                  />
                </div>
                
                <div>
                  <label className="block text-sm font-medium text-gray-700 mb-2">वडिलांचे नाव</label>
                  <input
                    type="text"
                    value={newStudent.fatherName}
                    onChange={(e) => setNewStudent({...newStudent, fatherName: e.target.value})}
                    className="w-full border border-gray-300 rounded-lg px-3 py-2 focus:ring-2 focus:ring-blue-500 focus:border-transparent"
                  />
                </div>
                
                <div>
                  <label className="block text-sm font-medium text-gray-700 mb-2">पालकांचा मोबाईल *</label>
                  <input
                    type="tel"
                    value={newStudent.parentMobile}
                    onChange={(e) => setNewStudent({...newStudent, parentMobile: e.target.value})}
                    className="w-full border border-gray-300 rounded-lg px-3 py-2 focus:ring-2 focus:ring-blue-500 focus:border-transparent"
                    pattern="[0-9]{10}"
                    required
                  />
                </div>
                
                <div>
                  <label className="block text-sm font-medium text-gray-700 mb-2">जन्मतारीख</label>
                  <input
                    type="date"
                    value={newStudent.birthDate}
                    onChange={(e) => setNewStudent({...newStudent, birthDate: e.target.value})}
                    className="w-full border border-gray-300 rounded-lg px-3 py-2 focus:ring-2 focus:ring-blue-500 focus:border-transparent"
                  />
                </div>
              </div>
              
              <div>
                <label className="block text-sm font-medium text-gray-700 mb-2">पत्ता</label>
                <textarea
                  value={newStudent.address}
                  onChange={(e) => setNewStudent({...newStudent, address: e.target.value})}
                  className="w-full border border-gray-300 rounded-lg px-3 py-2 focus:ring-2 focus:ring-blue-500 focus:border-transparent"
                  rows={3}
                />
              </div>
            </div>
            
            <div className="p-6 border-t border-gray-200 flex justify-end space-x-3">
              <button
                onClick={() => setShowAddStudentModal(false)}
                className="px-4 py-2 text-gray-700 bg-gray-200 rounded-lg hover:bg-gray-300 transition-colors"
              >
                रद्द करा
              </button>
              <button
                onClick={addStudent}
                className="px-6 py-2 bg-blue-600 text-white rounded-lg hover:bg-blue-700 transition-colors"
              >
                विद्यार्थी जोडा
              </button>
            </div>
          </div>
        </div>
      )}
    </div>
  );
};

export default App;