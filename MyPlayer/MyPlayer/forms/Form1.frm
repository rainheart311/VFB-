#VisualFreeBasic_Form#  Version=5.8.7
Locked=-1

[Form]
Name=Form1
ClassStyle=CS_VREDRAW,CS_HREDRAW,CS_DBLCLKS
ClassName=
WinStyle=WS_VISIBLE,WS_EX_CONTROLPARENT,WS_EX_LEFT,WS_EX_LTRREADING,WS_EX_RIGHTSCROLLBAR,WS_BORDER,WS_CAPTION,WS_SYSMENU,WS_MINIMIZEBOX,WS_CLIPSIBLINGS,WS_CLIPCHILDREN,WS_POPUP
Style=3 - 常规窗口
Icon=
Caption=MyPlayer
StartPosition=1 - 屏幕中心
WindowState=0 - 正常
Enabled=True
Repeat=False
Left=0
Top=0
Width=304
Height=119
TopMost=False
Child=False
MdiChild=False
TitleBar=True
SizeBox=False
SysMenu=True
MaximizeBox=False
MinimizeBox=True
Help=False
Hscroll=False
Vscroll=False
MinWidth=0
MinHeight=0
MaxWidth=0
MaxHeight=0
NoActivate=False
MousePass=False
TransPer=0
TransColor=SYS,25
Shadow=0 - 无阴影
BackColor=SYS,15
MousePointer=0 - 默认
Tag=
Tab=True
ToolTip=
ToolTipBalloon=False
AcceptFiles=False

[PopupMenu]
Name=PopupMenu1
Index=-1
Menu=单曲循环mnuSel10-10顺序播放mnuSel20-10循环播放mnuSel30-10随机播放mnuSel40-10
Left=216
Top=54
Tag=

[Timer]
Name=Timer1
Index=-1
Interval=100
Enabled=False
Left=180
Top=54
Tag=

[Label]
Name=Label1
Index=-1
Style=0 - 无边框
Caption=单曲循环
Enabled=True
Visible=True
ForeColor=SYS,8
BackColor=SYS,25
Font=微软雅黑,9,0
TextAlign=0 - 左对齐
Prefix=True
Ellipsis=False
Left=241
Top=69
Width=48
Height=18
Layout=0 - 不锚定
MousePointer=0 - 默认
Tag=
ToolTip=
ToolTipBalloon=False

[Slider]
Name=Slider2
Index=-1
Style=1 - 刻度在底部
AutoTicks=True
NoTicks=False
EnableSelRange=False
FixedLength=False
NoThumb=False
ToolTips=False
Max=100
Min=1
Value=1
TickFrequency=10
BackColor=SYS,25
Enabled=True
Visible=True
Left=156
Top=69
Width=80
Height=18
Layout=0 - 不锚定
MousePointer=0 - 默认
Tag=
Tab=True
ToolTip=
ToolTipBalloon=False
AcceptFiles=False

[Slider]
Name=Slider1
Index=-1
Style=1 - 刻度在底部
AutoTicks=True
NoTicks=False
EnableSelRange=False
FixedLength=False
NoThumb=False
ToolTips=False
Max=100
Min=1
Value=1
TickFrequency=10
BackColor=SYS,25
Enabled=True
Visible=True
Left=156
Top=44
Width=147
Height=18
Layout=0 - 不锚定
MousePointer=0 - 默认
Tag=
Tab=True
ToolTip=
ToolTipBalloon=False
AcceptFiles=False

[Button]
Name=Command1
Index=-1
Caption=←
TextAlign=1 - 居中
Ico=
Enabled=True
Visible=True
Default=False
OwnDraw=False
MultiLine=False
Font=微软雅黑,9,0
Left=159
Top=3
Width=35
Height=35
Layout=0 - 不锚定
MousePointer=0 - 默认
Tag=
Tab=True
ToolTip=
ToolTipBalloon=False

[ListBox]
Name=List1
Index=-1
Custom=
Style=0 - 单选
BStyle=3 - 凹边框
OwnDraw=0 - 系统绘制
ItemHeight=18
HasString=False
Sorted=False
NoHeight=True
MultiColumn=False
Enabled=True
Visible=True
ForeColor=SYS,8
BackColor=SYS,5
Font=微软雅黑,9,0
Left=2
Top=2
Width=154
Height=87
Layout=0 - 不锚定
MousePointer=0 - 默认
Tag=
Tab=True
ToolTip=
ToolTipBalloon=False
AcceptFiles=False

[Button]
Name=Command2
Index=-1
Caption=>>
TextAlign=1 - 居中
Ico=
Enabled=True
Visible=True
Default=False
OwnDraw=False
MultiLine=False
Font=微软雅黑,9,0
Left=194
Top=3
Width=35
Height=35
Layout=0 - 不锚定
MousePointer=0 - 默认
Tag=
Tab=True
ToolTip=
ToolTipBalloon=False

[Button]
Name=Command3
Index=-1
Caption=→
TextAlign=1 - 居中
Ico=
Enabled=True
Visible=True
Default=False
OwnDraw=False
MultiLine=False
Font=微软雅黑,9,0
Left=228
Top=3
Width=35
Height=35
Layout=0 - 不锚定
MousePointer=0 - 默认
Tag=
Tab=True
ToolTip=
ToolTipBalloon=False

[Button]
Name=Command4
Index=-1
Caption=打开
TextAlign=1 - 居中
Ico=
Enabled=True
Visible=True
Default=False
OwnDraw=False
MultiLine=False
Font=微软雅黑,9,0
Left=263
Top=3
Width=35
Height=35
Layout=0 - 不锚定
MousePointer=0 - 默认
Tag=
Tab=True
ToolTip=
ToolTipBalloon=False

[PopupMenu]
Name=PopupMenu2
Index=-1
Menu=添加mnuAdd0-10删除mnuDelete0-10-Form1_PopupMenu2_Menu10-10清空mnuClear0-10
Left=252
Top=54
Tag=


[AllCode]
'这是标准的工程模版，你也可做自己的模版。
'写好工程，复制全部文件到VFB软件文件夹里【template】里即可，子文件夹名为 VFB新建工程里显示的名称
'快去打造属于你自己的工程模版吧。

Dim Shared bass As clsBass             'bass.dll的类引用
Dim Shared hs As HSTREAM               '当前歌曲打开的流句柄
Dim Shared maxtime As Double               '当前歌曲的播放时间
Dim Shared Mp3FilePath(Any) As String     '全部歌曲的地址
Dim Shared Mp3Mode As ZString * 10 = "单曲循环"  '歌曲模式
'Dim Shared Mp3ListIndex As Long = 0       '当前播放位置
'Dim Shared Mp3Sound As Single = 1.0       '默认声音大小

Dim Shared ini As clsIniFile

Sub Form1_Shown(hWndForm As hWnd,UserData As Integer)  '窗口完全显示后。UserData 来自显示窗口最后1个参数。
    Slider1.Enabled = False 
    Slider2.MaxValue = 100
    Slider2.MinValue = 0
    Slider2.Enabled = False

    If HiWord(bass.GetVersion) <> BASSVERSION Then        '判断版本
        AfxMsg "Bass.dll文件版本不合适!"  
    Else
        If Not bass.Init( -1 ,44100 ,0 ,0 ,NULL) Then 
            'AfxMsg "初始化错误" 
            Form1.Caption = "初始化错误"
            Command1.Enabled = False
            Command2.Enabled = False
            Command3.Enabled = False
            Command4.Enabled = False
        End If
    End If
    
    ini.FilePath = App.Path & "Config.ini"
    Dim nFiles As Long = Val(ini.GetKey("Files", "Count", "0"))
    If nFiles Then
        ReDim Mp3FilePath(nFiles - 1) As String
        For i As Long = 0 To nFiles - 1
            Dim s As String = ini.GetKey("Files", Str(i), "") 
            If s = "" Then
                ini.DelKey("Files", Str(i)) 
            Else
                Mp3FilePath(i) = s
                List1.AddItem AfxGetFileNameX(s) 
            End If 
        Next
        List1.ListIndex = Val(ini.GetKey("Files", "Index", "-1"))
        If List1.ListIndex <> -1 Then
            BassPlay()
            Dim npos As Single = Val(ini.GetKey("Config","Mp3Pos","0"))  
            Dim Position As QWORD = bass.ChannelSeconds2Bytes(hs, npos / 1000)  '转换成歌曲的位置
            bass.ChannelSetPosition(hs ,Position ,BASS_POS_BYTE) '设置歌曲的位置   
        End If 
         
    End If
    Mp3Mode = ini.GetKey("Config","Mp3Mode","单曲循环") 
    Label1.Caption = Mp3Mode
End Sub

Function AddMp3File(tmpfile As String) As Long
    Dim cnt As Long = List1.ListCount 
    Dim s As String = AfxGetFileExt(tmpfile) '判断文件后缀，如果是.mp3或者.wav则存储，否则抛弃
    If s = ".mp3" OrElse s = ".wav" Then
        s = AfxGetFileNameX(tmpfile) 
        Dim i As Long 
        For i = 0 To List1.ListCount - 1
            If s = List1.List(i) Then Exit For 
        Next
        If i >= List1.ListCount Then 
            ReDim Preserve Mp3FilePath(cnt) As String       '修改文件路径的大小
            Mp3FilePath(cnt) = tmpfile '存储文件
            List1.AddItem s '显示文件名
            ini.SetKey("Files", Str(cnt), tmpfile) 
            List1.ListIndex = cnt  
            cnt += 1
            ini.SetKey("Files", "Count", cnt)
        Else
            AfxMsg "文件重复" 
            Return 1
        End If            '
    Else
        AfxMsg "文件格式错误"
        Return 2
    End If 
    Return 0    
End Function

Sub Form1_Command4_BN_Clicked(hWndForm As hWnd ,hWndControl As hWnd) '单击
    'Dim tmpfile As String = AfxOpenFileDialog(NULL, "", "", App.Path, "Mp3 文件(*.mp3)|*.mp3|Wav 文件(*.wav)|*wav", "") '加载音乐文件到临时变量
    Dim tmpfile As String = FF_OpenFileDialog(hWndForm,,,App.Path,"Mp3 文件(*.mp3)|*.mp3|Wav 文件(*.wav)|*wav",,OFN_ALLOWMULTISELECT Or OFN_EXPLORER Or OFN_ENABLESIZING)
    If tmpfile = "" Then Exit Sub '空表示没选
    Dim er As Long
    
    If InStr(tmpfile, "|") Then  '有分割符，则是多选文件，否则是单选
        Dim tmp() As String
        Dim nlen As Long = vbSplit(tmpfile, "|", tmp())  '文件路径格式：路径|文件名|文件名|...文件名
        For i As Long = 1 To nlen - 1
            tmpfile = tmp(0) & "\" & tmp(i)
            er = AddMp3File(tmpfile)
            If er Then Exit For   
        Next
    Else
        er = AddMp3File(tmpfile) 
    End If
    ini.SetKey("Files", "Index", List1.ListIndex)
    BassPlay() 
    If er = 1 AndAlso List1.ListIndex <> -1 Then  '如果是重复，则恢复原始播放进度
        Dim npos As Single = Val(ini.GetKey("Config","Mp3Pos","0")) 
        Dim Position As QWORD = bass.ChannelSeconds2Bytes(hs, npos / 1000)  '转换成歌曲的位置
        bass.ChannelSetPosition(hs, Position, BASS_POS_BYTE) '设置歌曲的位置    
    End If
End Sub

Function BassPlay() As Long
    If hs Then 
        bass.ChannelStop(hs) '停止播放
        bass.StreamFree(hs) '释放原有文件
    End If
    hs = bass.StreamCreateFile(False, StrPtr(Mp3FilePath(List1.ListIndex)), 0, 0, 0) '建立播放流
    If hs < BASS_ERROR_ENDED Then '判断是否打开成功
        Print "打开失败"
        Print bass.ErrorGetCode
        Return 1 
    Else
        Command2.Caption = "||"
        maxtime = bass.ChannelBytes2Seconds(hs ,bass.ChannelGetLength(hs ,BASS_POS_BYTE)) '; {总秒数}
        Slider1.MaxValue = Int(maxtime * 1000)
        Slider1.Enabled = True
        Slider2.Enabled = True
        
        Dim sound As Long = Val(ini.GetKey("Config" ,"Mp3Sound" ,"40")) 
        Slider2.Value = sound
        bass.ChannelSetAttribute(hs, BASS_ATTRIB_VOL, sound / Slider2.MaxValue) 
        
        bass.ChannelSetSync(hs, BASS_SYNC_END, 0, Cast(SYNCPROC Ptr,@Mp3SyncProc), NULL) 
    End If 
    '开始播放 
    bass.ChannelPlay(hs ,False) ' {参数 1 是流句柄; 参数 2 若是 TRUE 每次都会从头播放}
    
    Timer1.Enabled = True
    Return 0
End Function

Sub Mp3SyncProc cdecl(ByVal HSYNC As HANDLE ,ByVal channel As DWORD ,ByVal dat As DWORD ,ByVal user As Any Ptr)
    Select Case Mp3Mode
        Case "单曲循环"
            BassPlay()
        Case "顺序播放"
            If List1.ListIndex < List1.ListCount Then
                List1.ListIndex = List1.ListIndex + 1
                BassPlay()
            Else
                Command2.Caption = ">>"
            End If
        Case "循环播放"
            Print List1.ListIndex
            If List1.ListIndex < (List1.ListCount - 1) Then 
                List1.ListIndex = List1.ListIndex + 1
                Print List1.ListIndex
            Else
                List1.ListIndex = 0
            End If
             
            BassPlay()
        Case "随机播放"
            Dim n As Long = List1.ListCount  '获取歌曲总数
            Randomize
            n = Rnd() * n                    '获取随机数
            If n >= List1.ListCount Then n = List1.ListCount - 1
            List1.ListIndex = n
            BassPlay()
        Case Else
            Print "else"
    End Select
    ini.SetKey("Files", "Index", List1.ListIndex)
End Sub

Sub Form1_Command2_BN_Clicked(hWndForm As hWnd, hWndControl As hWnd)  '单击
    If Command2.Caption = ">>" Then
        If List1.ListIndex = -1 Then 
            Exit Sub 
        End If
        BassPlay()
    Else
        Command2.Caption = ">>"
        If hs Then bass.ChannelPause(hs) '暂停
        Slider1.Enabled = False
        Slider2.Enabled = False
    End If
End Sub

Sub Form1_Command1_BN_Clicked(hWndForm As hWnd, hWndControl As hWnd)  '单击
    If List1.ListIndex Then
        List1.ListIndex = List1.ListIndex - 1
        BassPlay()
    End If
End Sub

Sub Form1_Command3_BN_Clicked(hWndForm As hWnd, hWndControl As hWnd)  '单击
    If List1.ListIndex < (List1.ListCount - 1) Then
        List1.ListIndex = List1.ListIndex + 1
        BassPlay()
    End If
End Sub

Sub Form1_List1_LBN_DblClk(hWndForm As hWnd, hWndControl As hWnd)
    If BassPlay() Then '歌曲不存在，换到第一首
        List1.ListIndex = 0
        If BassPlay() Then
            AfxMsg "歌曲列表不可播放，请重新加载"
        End If
    End If
End Sub

Sub Form1_List1_WM_RButtonUp(hWndForm As hWnd, hWndControl As hWnd, MouseFlags As Long, xPos As Long, yPos As Long)
    Dim pt As Point 
    GetCursorPos(@pt)
    PopupMenu2.PopupMenu ,pt.x,pt.y 
End Sub

Sub Form1_PopupMenu2_WM_Command(hWndForm As hWnd,wID As ULong)
    Select Case wID
    Case mnuAdd ' 添加
        Command4.Click
    Case mnuDelete ' 删除
        If List1.ListIndex < List1.ListCount - 1 Then  '如果是最后一首，则直接删除                                          '不是，则需要移动存储的地址 
            For i As Long = List1.ListIndex To List1.ListCount - 2
                Mp3FilePath(i) = Mp3FilePath(i + 1)                              '搬运大法
                ini.SetKey("Files", Str(i), ini.GetKey("Files", Str(i + 1),""))  '搬运大法
            Next
        End If
 
        ReDim Preserve Mp3FilePath(List1.ListCount - 2) As String
        List1.RemoveItem List1.ListIndex
        ini.SetKey("Files", "Count", List1.ListCount)
        ini.DelKey("Files", Str(List1.ListCount))           '搬运完了，删除尾巴
        Dim index As Long = Val(ini.GetKey("Files", "Index","0"))
        If index = List1.ListIndex Then  '是当前播放的文件，则停止，否则不需要停止
            If hs Then bass.StreamFree(hs) '释放原有文件
            Command2.Caption = ">>"
        End If

    Case mnuClear
        List1.Clear
        Erase Mp3FilePath
        Dim nFiles As Long = Val(ini.GetKey("Files", "Count", "0"))
        If nFiles Then
            For i As Long = 0 To nFiles - 1
                ini.DelKey("Files",Str(i))
            Next
            ini.DelKey("Files", "Index")
            ini.DelKey("Files", "Count")
        End If
        If hs Then bass.StreamFree(hs) '释放原有文件
        Command2.Caption = ">>"
    End Select
End Sub

Sub Form1_Timer1_WM_Timer(hWndForm As hWnd, wTimerID As Long)  '定时器
    If hs Then
        Dim s As Double = bass.ChannelBytes2Seconds(hs, bass.ChannelGetPosition(hs, BASS_POS_BYTE)) 
        Slider1.Value = s * 1000
        ini.SetKey("Config","Mp3Pos",Slider1.Value) 
    End If
End Sub

Sub Form1_Label1_WM_LButtonDown(hWndForm As hWnd, MouseFlags As Long, xPos As Long, yPos As Long)
    Select Case Mp3Mode
    Case "单曲循环" ' 
        Label1.Caption = "顺序播放"  
    Case "顺序播放" ' 
        Label1.Caption = "循环播放"
    Case "循环播放" ' 
        Label1.Caption = "随机播放"
    Case "随机播放" ' 
        Label1.Caption = "单曲循环"
    End Select
    Mp3Mode = Label1.Caption
    ini.SetKey("Config","Mp3Mode",Mp3Mode) 
End Sub

Sub Form1_Label1_WM_RButtonUp(hWndForm As hWnd, MouseFlags As Long, xPos As Long, yPos As Long)  '释放鼠标右键
    Dim pt As Point 
    GetCursorPos(@pt)
    PopupMenu1.PopupMenu ,pt.x,pt.y 
End Sub

Sub Form1_PopupMenu1_WM_Command(hWndForm As hWnd,wID As ULong)  '点击了菜单项
    Select Case wID
    Case mnuSel1 ' 
        Label1.Caption = "单曲循环"  
    Case mnuSel2 ' 
        Label1.Caption = "顺序播放"
    Case mnuSel3 ' 
        Label1.Caption = "循环播放"
    Case mnuSel4 ' 
        Label1.Caption = "随机播放"
    End Select
    Mp3Mode = Label1.Caption
    ini.SetKey("Config","Mp3Mode",Mp3Mode) 
End Sub

Sub Form1_Slider1_WM_HScroll(hWndForm As hWnd,hWndControl As hWnd, nScrollCode As Long, nPosition As Long)  '发生水平滚动
    If hs Then 
        Dim npos As Single = Slider1.Value / 1000
        ini.SetKey("Config","Mp3Pos",Slider1.Value) 
        Dim Position As QWORD = bass.ChannelSeconds2Bytes(hs, npos)  '转换成歌曲的位置
        bass.ChannelSetPosition(hs, Position, BASS_POS_BYTE) '设置歌曲的位置    
    End If        
End Sub

Sub Form1_Slider2_WM_HScroll(hWndForm As hWnd,hWndControl As hWnd, nScrollCode As Long, nPosition As Long)  '发生水平滚动
    If hs Then 
        'Dim vol As Single
        ini.SetKey("Config","Mp3Sound",Slider2.Value) 
        bass.ChannelSetAttribute(hs, BASS_ATTRIB_VOL, Slider2.Value / Slider2.MaxValue / 10) 
        'bass.ChannelGetAttribute(hs, BASS_ATTRIB_VOL, @vol)
        'Print vol
    End If       
End Sub

'[Form1]事件 : 即将关闭窗口，返回非0可阻止关闭
'hWndForm  当前窗口的句柄(WIN系统用来识别窗口的一个编号，如果多开本窗口，必须 Me.hWndForm = hWndForm 后才可以执行后续操作本窗口的代码)
Function Form1_WM_Close(hWndForm As hWnd) As LResult
    bass.ChannelStop(hs) '停止播放
    bass.StreamFree(hs) '释放音频流
    bass.Stop() '停止所有输出
    bass.free() 
    Function = False ' 返回 TRUE 阻止关闭窗口。
End Function





























