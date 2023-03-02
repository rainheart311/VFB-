Type clsIniFile
Private:
    m_FilePath As String
Public:
    Declare Constructor
    Declare Destructor  

    Declare Function DelKey(sSection As String,sKey As String) As Boolean   
    Declare Function GetKey(sSection As String,sKey As String,sDefault As String) As String 
    Declare Function SetKey(sSection As String, sKey As String, sValue As String) As Boolean  
    Declare Function GetKey(sSection As String,sKey As String,nDefault As Integer) As Integer
    Declare Function SetKey(sSection As String, sKey As String, nValue As Integer) As Boolean  
    Declare Function GetKeys(lpszApp As String,lpszKey As String,szTypes As String,lpDta As Any Ptr) As Boolean
    Declare Function SetKeys(lpszApp As String,ByVal lpszKey As String,lpszTypes As String,lpDta As Any Ptr) As Boolean
    
    
    Declare Property FilePath() As String
    Declare Property FilePath(sFilePath As String) 
End Type

Constructor clsIniFile
    m_FilePath = ""
End Constructor

Destructor clsIniFile

End Destructor

Function clsIniFile.DelKey(sSection As String,sKey As String) As Boolean   
    if AfxFileExists(m_FilePath) Then 
        Function = WritePrivateProfileStringA(strptr(sSection), strptr(sKey), NULL,strptr(m_FilePath))
    end if
End Function

Function clsIniFile.GetKey(sSection As String, sKey As String, sDefault As String) As String
    Dim m_Text As ZString * 4096 
    GetPrivateProfileStringA(strptr(sSection),strptr(sKey),strptr(sDefault), @m_Text,SizeOf(m_Text),strptr(m_FilePath))
    Function = m_Text
End Function  

Function clsIniFile.SetKey(sSection As String,sKey As String,sValue As String) As Boolean     
    Function = WritePrivateProfileStringA(strptr(sSection),strptr(sKey),strptr(sValue),strptr(m_FilePath))
End Function

Function clsIniFile.GetKey(sSection As String, sKey As String, nDefault As Integer) As Integer
    Dim m_Text As ZString * 4096 
    Dim sDefault As String = str(nDefault) 
    GetPrivateProfileStringA(strptr(sSection),strptr(sKey),strptr(sDefault), @m_Text,SizeOf(m_Text),strptr(m_FilePath))
    Function = val(m_Text)
End Function  

Function clsIniFile.SetKey(sSection As String, sKey As String, nValue As Integer) As Boolean  
    dim sValue as String = str(nValue)   
    Function = WritePrivateProfileStringA(strptr(sSection),strptr(sKey),strptr(sValue),strptr(m_FilePath))
End Function

Function clsIniFile.GetKeys(lpszApp As String,lpszKey As String,szTypes As String,lpDta As Any Ptr) As Boolean
   Dim i As Integer
   Dim ofs As Integer
   Dim v As Integer
   Dim p As LPSTR
   Dim tmp As ZString * 256
    Dim m_Text As ZString * 4096 

   If GetPrivateProfileStringA(strptr(lpszApp),strptr(lpszKey),NULL,@m_Text,SizeOf(m_Text),strptr(m_FilePath)) Then
      For i=1 To Len(szTypes) 'get nulber
         v=0
         Select Case Asc(szTypes,i)-48 'get type
            Case 0
               ' String
               RtlMoveMemory(@p,lpDta+ofs,4)
               If InStr(m_Text,",") Then
                  tmp=Left(m_Text,InStr(m_Text,",")-1)
               Else
                  tmp=m_Text
               EndIf
               lstrcpya(p,@tmp)
               ofs=ofs+4
            Case 1  '1 char
               ' Byte
               If Len(m_Text) Then
                  v=Val(m_Text)
                  RtlMoveMemory(lpDta+ofs,@v,1)
               EndIf
               ofs=ofs+1
            Case 2  '2 char = short
               ' Word
               If Len(m_Text) Then
                  v=Val(m_Text)
                  RtlMoveMemory(lpDta+ofs,@v,2)
               EndIf
               ofs=ofs+2
            Case 4 '4 char = long
               ' DWord
               If Len(m_Text) Then
                  v=Val(m_Text)
                  RtlMoveMemory(lpDta+ofs,@v,4)
               EndIf
               ofs=ofs+4
         End Select
         If InStr(m_Text,",") Then
            m_Text=Mid(m_Text,InStr(m_Text,",")+1)
         Else
            m_Text=""
         EndIf
      Next i
   Else
      Return FALSE
   EndIf
   Return TRUE
End Function

Function clsIniFile.SetKeys(lpszApp As String,ByVal lpszKey As String,lpszTypes As String,lpDta As Any Ptr) As Boolean
   Dim i As Integer
   Dim ofs As Integer
   Dim v As Integer
   Dim p As LPSTR
    Dim m_Text As ZString * 4096 

   For i=0 To lstrlen(lpszTypes)-1
      v=0
      Select Case lpszTypes[i]-48
         Case 0
            ' String
            RtlMoveMemory(@p,lpDta+ofs,4)
            m_Text=m_Text & ","
            lstrcata(@m_Text,p)
            ofs=ofs+4
         Case 1
            ' Byte
            RtlMoveMemory(@v,lpDta+ofs,1)
            ofs=ofs+1
            m_Text=m_Text & "," & Str(v)
         Case 2
            ' Word
            RtlMoveMemory(@v,lpDta+ofs,2)
            ofs=ofs+2
            m_Text=m_Text & "," & Str(v)
         Case 4
            ' DWord
            RtlMoveMemory(@v,lpDta+ofs,4)
            ofs=ofs+4
            m_Text=m_Text & "," & Str(v)
      End Select
   Next i
   m_Text=Mid(m_Text,2)
   WritePrivateProfileStringA(strptr(lpszApp),strptr(lpszKey),@m_Text,strptr(m_FilePath))
   Return TRUE
End Function 

Property clsIniFile.FilePath() As String
    Return m_FilePath
End Property

Property clsIniFile.FilePath(sFilePath As String) 
    m_FilePath = sFilePath
End Property




