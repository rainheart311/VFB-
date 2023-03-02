#Ifndef __CLSBASS_BI__
#define __CLSBASS_BI__

#inclib "bass"
#ifdef __FB_WIN32__
#Include once "win/wtypes.bi"
#else
type BYTE as ubyte
type WORD as ushort
type DWORD as uinteger
type BOOL as integer
type float as single
#Define TRUE 1
#Define FALSE 0
#define MAKEWORD(a,b) cushort( cubyte(a) or (cushort(cubyte(b)) shl 8) )
#define MAKELONG(a,b) cint( cushort(a) or (cuint(cushort(b)) shl 16) )
#endif '' __FB_WIN32__


type QWORD as ulongint

#define BASSVERSION         &h204   ' API version
#define BASSVERSIONTEXT      "2.4"


type as DWORD HMUSIC      ' MOD music handle
type as DWORD HSAMPLE      ' sample handle
type as DWORD HCHANNEL      ' playing sample's channel handle
type as DWORD HSTREAM      ' sample stream handle
type as DWORD HRECORD      ' recording handle
type as DWORD HSYNC          ' synchronizer handle
type as DWORD HDSP         ' DSP handle
type as DWORD HFX         ' DX8 effect handle
type as DWORD HPLUGIN      ' Plugin handle

' Error codes returned by BASS_ErrorGetCode
#define BASS_OK            0   ' all is OK
#define BASS_ERROR_MEM      1   ' memory error
#define BASS_ERROR_FILEOPEN   2   ' can't open the file
#define BASS_ERROR_DRIVER   3   ' can't find a free/valid driver
#define BASS_ERROR_BUFLOST   4   ' the sample buffer was lost
#define BASS_ERROR_HANDLE   5   ' invalid handle
#define BASS_ERROR_FORMAT   6   ' unsupported sample format
#define BASS_ERROR_POSITION   7   ' invalid position
#define BASS_ERROR_INIT      8   ' BASS_Init has not been successfully called
#define BASS_ERROR_START   9   ' BASS_Start has not been successfully called
#define BASS_ERROR_ALREADY   14   ' already initialized/paused/whatever
#define BASS_ERROR_NOCHAN   18   ' can't get a free channel
#define BASS_ERROR_ILLTYPE   19   ' an illegal type was specified
#define BASS_ERROR_ILLPARAM   20   ' an illegal parameter was specified
#define BASS_ERROR_NO3D      21   ' no 3D support
#define BASS_ERROR_NOEAX   22   ' no EAX support
#define BASS_ERROR_DEVICE   23   ' illegal device number
#define BASS_ERROR_NOPLAY   24   ' not playing
#define BASS_ERROR_FREQ      25   ' illegal sample rate
#define BASS_ERROR_NOTFILE   27   ' the stream is not a file stream
#define BASS_ERROR_NOHW      29   ' no hardware voices available
#define BASS_ERROR_EMPTY   31   ' the MOD music has no sequence data
#define BASS_ERROR_NONET   32   ' no internet connection could be opened
#define BASS_ERROR_CREATE   33   ' couldn't create the file
#define BASS_ERROR_NOFX      34   ' effects are not available
#define BASS_ERROR_NOTAVAIL   37   ' requested data is not available
#define BASS_ERROR_DECODE   38   ' the channel is a "decoding channel"
#define BASS_ERROR_DX      39   ' a sufficient DirectX version is not installed
#define BASS_ERROR_TIMEOUT   40   ' connection timedout
#define BASS_ERROR_FILEFORM   41   ' unsupported file format
#define BASS_ERROR_SPEAKER   42   ' unavailable speaker
#define BASS_ERROR_VERSION   43   ' invalid BASS version (used by add-ons)
#define BASS_ERROR_CODEC   44   ' codec is not available/supported
#define BASS_ERROR_ENDED   45   ' the channel/file has ended
#define BASS_ERROR_BUSY      46   ' the device is busy
#define BASS_ERROR_UNKNOWN   -1   ' some other mystery problem

' BASS_SetConfig options
#define BASS_CONFIG_BUFFER         0
#define BASS_CONFIG_UPDATEPERIOD   1
#define BASS_CONFIG_GVOL_SAMPLE      4
#define BASS_CONFIG_GVOL_STREAM      5
#define BASS_CONFIG_GVOL_MUSIC      6
#define BASS_CONFIG_CURVE_VOL      7
#define BASS_CONFIG_CURVE_PAN      8
#define BASS_CONFIG_FLOATDSP      9
#define BASS_CONFIG_3DALGORITHM      10
#define BASS_CONFIG_NET_TIMEOUT      11
#define BASS_CONFIG_NET_BUFFER      12
#define BASS_CONFIG_PAUSE_NOPLAY   13
#define BASS_CONFIG_NET_PREBUF      15
#define BASS_CONFIG_NET_PASSIVE      18
#define BASS_CONFIG_REC_BUFFER      19
#define BASS_CONFIG_NET_PLAYLIST   21
#define BASS_CONFIG_MUSIC_VIRTUAL   22
#define BASS_CONFIG_VERIFY         23
#define BASS_CONFIG_UPDATETHREADS   24
#define BASS_CONFIG_DEV_BUFFER      27
#define BASS_CONFIG_IOS_MIXAUDIO   34
#define BASS_CONFIG_DEV_DEFAULT      36
#define BASS_CONFIG_NET_READTIMEOUT   37
#define BASS_CONFIG_IOS_SPEAKER      39

' BASS_SetConfigPtr options
#define BASS_CONFIG_NET_AGENT      16
#define BASS_CONFIG_NET_PROXY      17

' BASS_Init flags
#define BASS_DEVICE_8BITS      1   ' use 8 bit resolution, else 16 bit
#define BASS_DEVICE_MONO      2   ' use mono, else stereo
#define BASS_DEVICE_3D         4   ' enable 3D functionality
#define BASS_DEVICE_LATENCY      256   ' calculate device latency (BASS_INFO struct)
#define BASS_DEVICE_CPSPEAKERS   1024 ' detect speakers via Windows control panel
#define BASS_DEVICE_SPEAKERS   2048 ' force enabling of speaker assignment
#define BASS_DEVICE_NOSPEAKER   4096 ' ignore speaker arrangement
#ifdef __FB_LINUX__
#define BASS_DEVICE_DMIX      8192 ' use ALSA "dmix" plugin
#endif

' DirectSound interfaces (for use with BASS_GetDSoundObject)
#define BASS_OBJECT_DS      1   ' IDirectSound
#define BASS_OBJECT_DS3DL   2   ' IDirectSound3DListener

' Device info structure
Type BASS_DEVICEINFO
    Name as Const ZString Ptr    ' description
    Driver as Const ZString Ptr  ' driver
    Flags As DWORD 
End Type

' BASS_DEVICEINFO flags
#define BASS_DEVICE_ENABLED      1
#define BASS_DEVICE_DEFAULT      2
#define BASS_DEVICE_INIT      4

Type BASS_INFO
    flags As DWORD       ' device capabilities (DSCAPS_xxx flags)
    hwsize As DWORD       ' size of total device hardware memory
    hwfree As DWORD    ' size of free device hardware memory
    freesam As DWORD   ' number of free sample slots in the hardware
    free3d   as DWORD    ' number of free 3D sample slots in the hardware
    minrate As DWORD   ' min sample rate supported by the hardware
    maxrate As DWORD   ' max sample rate supported by the hardware
    eax   As BOOL           ' device supports EAX? (always FALSE if BASS_DEVICE_3D was not used)
    minbuf As DWORD     ' recommended minimum buffer length in ms (requires BASS_DEVICE_LATENCY)
    dsver As DWORD      ' DirectSound version
    latency   As DWORD    ' delay (in ms) before start of playback (requires BASS_DEVICE_LATENCY)
    initflags As DWORD  ' BASS_Init "flags" parameter
    speakers As DWORD   ' number of speakers available
    freq As DWORD       ' current output rate (Vista/OSX only)
End Type 

' BASS_INFO flags (from DSOUND.H)
#Ifndef __win_dsound_bi__
#define DSCAPS_CONTINUOUSRATE   &h00000010   ' supports all sample rates between min/maxrate
#define DSCAPS_EMULDRIVER      &h00000020   ' device does NOT have hardware DirectSound support
#define DSCAPS_CERTIFIED      &h00000040   ' device driver has been certified by Microsoft
#define DSCAPS_SECONDARYMONO   &h00000100   ' mono
#define DSCAPS_SECONDARYSTEREO   &h00000200   ' stereo
#define DSCAPS_SECONDARY8BIT   &h00000400   ' 8 bit
#define DSCAPS_SECONDARY16BIT   &h00000800   ' 16 bit
#endif

' Recording device info structure
Type BASS_RECORDINFO
    flags As DWORD  ' device capabilities (DSCCAPS_xxx flags)
    formats   As DWORD' supported standard formats (WAVE_FORMAT_xxx flags)
    inputs As DWORD ' number of inputs
    singlein As BOOL' TRUE = only 1 input can be set at a time
    freq As DWORD   ' current input rate (Vista/OSX only)
End Type 

' BASS_RECORDINFO flags (from DSOUND.H)
#Ifndef __win_dsound_bi__
#define DSCCAPS_EMULDRIVER   DSCAPS_EMULDRIVER   ' device does NOT have hardware DirectSound recording support
#define DSCCAPS_CERTIFIED   DSCAPS_CERTIFIED   ' device driver has been certified by Microsoft
#EndIf
' defines for formats field of BASS_RECORDINFO (from MMSYSTEM.H)
#ifndef WAVE_FORMAT_1M08
#define WAVE_FORMAT_1M08       &h00000001       /' 11.025 kHz, Mono,   8-bit  '/
#define WAVE_FORMAT_1S08       &h00000002       /' 11.025 kHz, Stereo, 8-bit  '/
#define WAVE_FORMAT_1M16       &h00000004       /' 11.025 kHz, Mono,   16-bit '/
#define WAVE_FORMAT_1S16       &h00000008       /' 11.025 kHz, Stereo, 16-bit '/
#define WAVE_FORMAT_2M08       &h00000010       /' 22.05  kHz, Mono,   8-bit  '/
#define WAVE_FORMAT_2S08       &h00000020       /' 22.05  kHz, Stereo, 8-bit  '/
#define WAVE_FORMAT_2M16       &h00000040       /' 22.05  kHz, Mono,   16-bit '/
#define WAVE_FORMAT_2S16       &h00000080       /' 22.05  kHz, Stereo, 16-bit '/
#define WAVE_FORMAT_4M08       &h00000100       /' 44.1   kHz, Mono,   8-bit  '/
#define WAVE_FORMAT_4S08       &h00000200       /' 44.1   kHz, Stereo, 8-bit  '/
#define WAVE_FORMAT_4M16       &h00000400       /' 44.1   kHz, Mono,   16-bit '/
#define WAVE_FORMAT_4S16       &h00000800       /' 44.1   kHz, Stereo, 16-bit '/
#endif

' Sample info structure
Type BASS_SAMPLE
    freq As DWORD       ' default playback rate
    volume As float       ' default volume (0-1)
    pan As float      ' default pan (-1=left, 0=middle, 1=right)
    flags As DWORD       ' BASS_SAMPLE_xxx flags
    length As DWORD     ' length (in bytes)
    max As DWORD        ' maximum simultaneous playbacks
    origres As DWORD    ' original resolution bits
    chans As DWORD        ' number of channels
    mingap As DWORD    ' minimum gap (ms) between creating channels
    mode3d   as DWORD    ' BASS_3DMODE_xxx mode
    mindist As float    ' minimum distance
    maxdist As float    ' maximum distance
    iangle As DWORD    ' angle of inside projection cone
    oangle As DWORD     ' angle of outside projection cone
    outvol As float     ' delta-volume outside the projection cone
    vam As DWORD        ' voice allocation/management flags (BASS_VAM_xxx)
    priority As DWORD   ' priority (0=lowest, &hffffffff=highest)
End Type

#define BASS_SAMPLE_8BITS      1   ' 8 bit
#define BASS_SAMPLE_FLOAT      256   ' 32-bit floating-point
#define BASS_SAMPLE_MONO      2   ' mono
#define BASS_SAMPLE_LOOP      4   ' looped
#define BASS_SAMPLE_3D         8   ' 3D functionality
#define BASS_SAMPLE_SOFTWARE   16   ' not using hardware mixing
#define BASS_SAMPLE_MUTEMAX      32   ' mute at max distance (3D only)
#define BASS_SAMPLE_VAM         64   ' DX7 voice allocation & management
#define BASS_SAMPLE_FX         128   ' old implementation of DX8 effects
#define BASS_SAMPLE_OVER_VOL   &h10000   ' override lowest volume
#define BASS_SAMPLE_OVER_POS   &h20000   ' override longest playing
#define BASS_SAMPLE_OVER_DIST   &h30000 ' override furthest from listener (3D only)

#define BASS_STREAM_PRESCAN      &h20000 ' enable pin-point seeking/length (MP3/MP2/MP1)
#define BASS_MP3_SETPOS         BASS_STREAM_PRESCAN
#define BASS_STREAM_AUTOFREE   &h40000   ' automatically free the stream when it stop/ends
#define BASS_STREAM_RESTRATE   &h80000   ' restrict the download rate of internet file streams
#define BASS_STREAM_BLOCK      &h100000 ' download/play internet file stream in small blocks
#define BASS_STREAM_DECODE      &h200000 ' don't play the stream, only decode (BASS_ChannelGetData)
#define BASS_STREAM_STATUS      &h800000 ' give server status info (HTTP/ICY tags) in DOWNLOADPROC

#define BASS_MUSIC_FLOAT      BASS_SAMPLE_FLOAT
#define BASS_MUSIC_MONO         BASS_SAMPLE_MONO
#define BASS_MUSIC_LOOP         BASS_SAMPLE_LOOP
#define BASS_MUSIC_3D         BASS_SAMPLE_3D
#define BASS_MUSIC_FX         BASS_SAMPLE_FX
#define BASS_MUSIC_AUTOFREE      BASS_STREAM_AUTOFREE
#define BASS_MUSIC_DECODE      BASS_STREAM_DECODE
#define BASS_MUSIC_PRESCAN      BASS_STREAM_PRESCAN   ' calculate playback length
#define BASS_MUSIC_CALCLEN      BASS_MUSIC_PRESCAN
#define BASS_MUSIC_RAMP         &h200   ' normal ramping
#define BASS_MUSIC_RAMPS      &h400   ' sensitive ramping
#define BASS_MUSIC_SURROUND      &h800   ' surround sound
#define BASS_MUSIC_SURROUND2   &h1000   ' surround sound (mode 2)
#define BASS_MUSIC_FT2MOD      &h2000   ' play .MOD as FastTracker 2 does
#define BASS_MUSIC_PT1MOD      &h4000   ' play .MOD as ProTracker 1 does
#define BASS_MUSIC_NONINTER      &h10000   ' non-interpolated sample mixing
#define BASS_MUSIC_SINCINTER   &h800000 ' sinc interpolated sample mixing
#define BASS_MUSIC_POSRESET      &h8000   ' stop all notes when moving position
#define BASS_MUSIC_POSRESETEX   &h400000 ' stop all notes and reset bmp/etc when moving position
#define BASS_MUSIC_STOPBACK      &h80000   ' stop the music on a backwards jump effect
#define BASS_MUSIC_NOSAMPLE      &h100000 ' don't load the samples

' Speaker assignment flags
#define BASS_SPEAKER_FRONT   &h1000000   ' front speakers
#define BASS_SPEAKER_REAR   &h2000000   ' rear/side speakers
#define BASS_SPEAKER_CENLFE   &h3000000   ' center & LFE speakers (5.1)
#define BASS_SPEAKER_REAR2   &h4000000   ' rear center speakers (7.1)
#define BASS_SPEAKER_N(n)   ((n) shl 24)   ' 'n'th pair of speakers (max 15)
#define BASS_SPEAKER_LEFT   &h10000000   ' modifier: left
#define BASS_SPEAKER_RIGHT   &h20000000   ' modifier: right
#define BASS_SPEAKER_FRONTLEFT   BASS_SPEAKER_FRONT or BASS_SPEAKER_LEFT
#define BASS_SPEAKER_FRONTRIGHT   BASS_SPEAKER_FRONT or BASS_SPEAKER_RIGHT
#define BASS_SPEAKER_REARLEFT   BASS_SPEAKER_REAR or BASS_SPEAKER_LEFT
#define BASS_SPEAKER_REARRIGHT   BASS_SPEAKER_REAR or BASS_SPEAKER_RIGHT
#define BASS_SPEAKER_CENTER      BASS_SPEAKER_CENLFE or BASS_SPEAKER_LEFT
#define BASS_SPEAKER_LFE      BASS_SPEAKER_CENLFE or BASS_SPEAKER_RIGHT
#define BASS_SPEAKER_REAR2LEFT   BASS_SPEAKER_REAR2 or BASS_SPEAKER_LEFT
#define BASS_SPEAKER_REAR2RIGHT   BASS_SPEAKER_REAR2 or BASS_SPEAKER_RIGHT

#define BASS_UNICODE         &h80000000

#define BASS_RECORD_PAUSE      &h8000   ' start recording paused

' DX7 voice allocation & management flags
#define BASS_VAM_HARDWARE      1
#define BASS_VAM_SOFTWARE      2
#define BASS_VAM_TERM_TIME      4
#define BASS_VAM_TERM_DIST      8
#define BASS_VAM_TERM_PRIO      16

' Channel info structure
Type BASS_CHANNELINFO
    freq As DWORD                  ' default playback rate
    chans As DWORD                ' channels
    flags As DWORD                ' BASS_SAMPLE/STREAM/MUSIC/SPEAKER flags
    ctype As DWORD                ' type of channel
    origres As DWORD              ' original resolution
    plugin As HPLUGIN             ' plugin
    sample As HSAMPLE             ' sample
    filename As Const ZString Ptr ' filename
End Type

' BASS_CHANNELINFO types
#define BASS_CTYPE_SAMPLE      1
#define BASS_CTYPE_RECORD      2
#define BASS_CTYPE_STREAM      &h10000
#define BASS_CTYPE_STREAM_OGG   &h10002
#define BASS_CTYPE_STREAM_MP1   &h10003
#define BASS_CTYPE_STREAM_MP2   &h10004
#define BASS_CTYPE_STREAM_MP3   &h10005
#define BASS_CTYPE_STREAM_AIFF   &h10006
#define BASS_CTYPE_STREAM_CA   &h10007
#define BASS_CTYPE_STREAM_MF   &h10008
#define BASS_CTYPE_STREAM_WAV   &h40000 ' WAVE flag, LOWORD=codec
#define BASS_CTYPE_STREAM_WAV_PCM   &h50001
#define BASS_CTYPE_STREAM_WAV_FLOAT   &h50003
#define BASS_CTYPE_MUSIC_MOD   &h20000
#define BASS_CTYPE_MUSIC_MTM   &h20001
#define BASS_CTYPE_MUSIC_S3M   &h20002
#define BASS_CTYPE_MUSIC_XM      &h20003
#define BASS_CTYPE_MUSIC_IT      &h20004
#define BASS_CTYPE_MUSIC_MO3   &h00100 ' MO3 flag

Type BASS_PLUGINFORM
    ctype As DWORD       ' channel type
    Name As const ZString ptr    ' format description
    exts As const ZString ptr    ' file extension filter (*.ext1*.ext2etc...)
End Type

type BASS_PLUGININFO
    version As DWORD                ' version (same form as BASS_GetVersion)
    formatc As DWORD                ' number of formats
    formats As Const BASS_PLUGINFORM Ptr' the array of formats
End Type

' 3D vector (for 3D positions/velocities/orientations)
Type BASS_3DVECTOR
    x As float    ' +=right, -=left
    y As float    ' +=up, -=down
    z As float    ' +=front, -=behind
End Type

' 3D channel modes
#define BASS_3DMODE_NORMAL      0   ' normal 3D processing
#define BASS_3DMODE_RELATIVE   1   ' position is relative to the listener
#define BASS_3DMODE_OFF         2   ' no 3D processing

' software 3D mixing algorithms (used with BASS_CONFIG_3DALGORITHM)
#define BASS_3DALG_DEFAULT   0
#define BASS_3DALG_OFF      1
#define BASS_3DALG_FULL      2
#define BASS_3DALG_LIGHT   3

' EAX environments, use with BASS_SetEAXParameters
Enum 
    EAX_ENVIRONMENT_GENERIC
    EAX_ENVIRONMENT_PADDEDCELL
    EAX_ENVIRONMENT_ROOM
    EAX_ENVIRONMENT_BATHROOM
    EAX_ENVIRONMENT_LIVINGROOM
    EAX_ENVIRONMENT_STONEROOM
    EAX_ENVIRONMENT_AUDITORIUM
    EAX_ENVIRONMENT_CONCERTHALL
    EAX_ENVIRONMENT_CAVE
    EAX_ENVIRONMENT_ARENA
    EAX_ENVIRONMENT_HANGAR
    EAX_ENVIRONMENT_CARPETEDHALLWAY
    EAX_ENVIRONMENT_HALLWAY
    EAX_ENVIRONMENT_STONECORRIDOR
    EAX_ENVIRONMENT_ALLEY
    EAX_ENVIRONMENT_FOREST
    EAX_ENVIRONMENT_CITY
    EAX_ENVIRONMENT_MOUNTAINS
    EAX_ENVIRONMENT_QUARRY
    EAX_ENVIRONMENT_PLAIN
    EAX_ENVIRONMENT_PARKINGLOT
    EAX_ENVIRONMENT_SEWERPIPE
    EAX_ENVIRONMENT_UNDERWATER
    EAX_ENVIRONMENT_DRUGGED
    EAX_ENVIRONMENT_DIZZY
    EAX_ENVIRONMENT_PSYCHOTIC

    EAX_ENVIRONMENT_COUNT         ' total number of environments
End Enum

' EAX presets, usage: BASS_SetEAXParameters(EAX_PRESET_xxx)
#define EAX_PRESET_GENERIC         EAX_ENVIRONMENT_GENERIC,0.5,1.493,0.5
#define EAX_PRESET_PADDEDCELL      EAX_ENVIRONMENT_PADDEDCELL,0.25,0.1,0.0
#define EAX_PRESET_ROOM            EAX_ENVIRONMENT_ROOM,0.417,0.4,0.666
#define EAX_PRESET_BATHROOM        EAX_ENVIRONMENT_BATHROOM,0.653,1.499,0.166
#define EAX_PRESET_LIVINGROOM      EAX_ENVIRONMENT_LIVINGROOM,0.208,0.478,0.0
#define EAX_PRESET_STONEROOM       EAX_ENVIRONMENT_STONEROOM,0.5,2.309,0.888
#define EAX_PRESET_AUDITORIUM      EAX_ENVIRONMENT_AUDITORIUM,0.403,4.279,0.5
#define EAX_PRESET_CONCERTHALL     EAX_ENVIRONMENT_CONCERTHALL,0.5,3.961,0.5
#define EAX_PRESET_CAVE            EAX_ENVIRONMENT_CAVE,0.5,2.886,1.304
#define EAX_PRESET_ARENA           EAX_ENVIRONMENT_ARENA,0.361,7.284,0.332
#define EAX_PRESET_HANGAR          EAX_ENVIRONMENT_HANGAR,0.5,10.0,0.3
#define EAX_PRESET_CARPETEDHALLWAY EAX_ENVIRONMENT_CARPETEDHALLWAY,0.153,0.259,2.0
#define EAX_PRESET_HALLWAY         EAX_ENVIRONMENT_HALLWAY,0.361,1.493,0.0
#define EAX_PRESET_STONECORRIDOR   EAX_ENVIRONMENT_STONECORRIDOR,0.444,2.697,0.638
#define EAX_PRESET_ALLEY           EAX_ENVIRONMENT_ALLEY,0.25,1.752,0.776
#define EAX_PRESET_FOREST          EAX_ENVIRONMENT_FOREST,0.111,3.145,0.472
#define EAX_PRESET_CITY            EAX_ENVIRONMENT_CITY,0.111,2.767,0.224
#define EAX_PRESET_MOUNTAINS       EAX_ENVIRONMENT_MOUNTAINS,0.194,7.841,0.472
#define EAX_PRESET_QUARRY          EAX_ENVIRONMENT_QUARRY,1.0,1.499,0.5
#define EAX_PRESET_PLAIN           EAX_ENVIRONMENT_PLAIN,0.097,2.767,0.224
#define EAX_PRESET_PARKINGLOT      EAX_ENVIRONMENT_PARKINGLOT,0.208,1.652,1.5
#define EAX_PRESET_SEWERPIPE       EAX_ENVIRONMENT_SEWERPIPE,0.652,2.886,0.25
#define EAX_PRESET_UNDERWATER      EAX_ENVIRONMENT_UNDERWATER,1.0,1.499,0.0
#define EAX_PRESET_DRUGGED         EAX_ENVIRONMENT_DRUGGED,0.875,8.392,1.388
#define EAX_PRESET_DIZZY           EAX_ENVIRONMENT_DIZZY,0.139,17.234,0.666
#define EAX_PRESET_PSYCHOTIC       EAX_ENVIRONMENT_PSYCHOTIC,0.486,7.563,0.806

type STREAMPROC as function (byval handle as HSTREAM, byval buffer as any ptr, byval length as DWORD , byval user as any ptr) as DWORD 
/' User stream callback function. NOTE: A stream function should obviously be as quick
as possible, other streams (and MOD musics) can't be mixed until it's finished.
handle : The stream that needs writing
buffer : Buffer to write the samples in
length : Number of bytes to write
user   : The 'user' parameter value given when calling BASS_StreamCreate
RETURN : Number of bytes written. Set the BASS_STREAMPROC_END flag to end
         the stream. '/

#define BASS_STREAMPROC_END      &h80000000   ' end of user stream flag

' special STREAMPROCs
#define STREAMPROC_DUMMY      0      ' "dummy" stream
#define STREAMPROC_PUSH         -1      ' push stream

' BASS_StreamCreateFileUser file systems
#define STREAMFILE_NOBUFFER      0
#define STREAMFILE_BUFFER      1
#define STREAMFILE_BUFFERPUSH   2

' User file stream callback functions
type FILECLOSEPROC as sub (byval user as any ptr)
type FILELENPROC as function (byval user as any ptr) as QWORD 
type FILEREADPROC as function (byval buffer as any ptr, length as DWORD, byval user as any ptr) as DWORD
type FILESEEKPROC as function (byval offset as QWORD , byval user as any ptr) as BOOL

Type BASS_FILEPROCS
   Close As FILECLOSEPROC Ptr 
   length As FILELENPROC Ptr  
   Read As FILEREADPROC Ptr  
   Seek As FILESEEKPROC Ptr  
End Type

' BASS_StreamPutFileData options
#define BASS_FILEDATA_END      0   ' end & close the file

' BASS_StreamGetFilePosition modes
#define BASS_FILEPOS_CURRENT   0
#define BASS_FILEPOS_DECODE      BASS_FILEPOS_CURRENT
#define BASS_FILEPOS_DOWNLOAD   1
#define BASS_FILEPOS_END      2
#define BASS_FILEPOS_START      3
#define BASS_FILEPOS_CONNECTED   4
#define BASS_FILEPOS_BUFFER      5
#define BASS_FILEPOS_SOCKET      6

type DOWNLOADPROC as sub (byval buffer as const any ptr, byval length as DWORD, byval user as any ptr)
/' Internet stream download callback function.
buffer : Buffer containing the downloaded data... NULL=end of download
length : Number of bytes in the buffer
user   : The 'user' parameter value given when calling BASS_StreamCreateURL 
'/
' BASS_ChannelSetSync types
#define BASS_SYNC_POS         0
#define BASS_SYNC_END         2
#define BASS_SYNC_META         4
#define BASS_SYNC_SLIDE         5
#define BASS_SYNC_STALL         6
#define BASS_SYNC_DOWNLOAD      7
#define BASS_SYNC_FREE         8
#define BASS_SYNC_SETPOS      11
#define BASS_SYNC_MUSICPOS      10
#define BASS_SYNC_MUSICINST      1
#define BASS_SYNC_MUSICFX      3
#define BASS_SYNC_OGG_CHANGE   12
#define BASS_SYNC_MIXTIME      &h40000000   ' FLAG: sync at mixtime, else at playtime
#define BASS_SYNC_ONETIME      &h80000000   ' FLAG: sync only once, else continuously

Type SYNCPROC as Sub (ByVal HSYNC  as HANDLE, ByVal channel as DWORD , ByVal Data as DWORD, ByVal user as Any Ptr)
/' Sync callback function. NOTE: a sync callback function should be very
quick as other syncs can't be processed until it has finished. If the sync
is a "mixtime" sync, then other streams and MOD musics can't be mixed until
it's finished either.
handle : The sync that has occured
channel: Channel that the sync occured in
data   : Additional data associated with the sync's occurance
user   : The 'user' parameter given when calling BASS_ChannelSetSync 
'/
type DSPPROC as sub(byval handle as HDSP, byval channel as DWORD, byval buffer as any ptr, byval length as DWORD, byval user as any ptr)
/' DSP callback function. NOTE: A DSP function should obviously be as quick as
possible... other DSP functions, streams and MOD musics can not be processed
until it's finished.
handle : The DSP handle
channel: Channel that the DSP is being applied to
buffer : Buffer to apply the DSP to
length : Number of bytes in the buffer
user   : The 'user' parameter given when calling BASS_ChannelSetDSP 
'/
type RECORDPROC as function (byval handle as HRECORD, byval buffer as const any ptr, byval length as DWORD, byval user as any ptr) as BOOL
/' Recording callback function.
handle : The recording handle
buffer : Buffer containing the recorded sample data
length : Number of bytes
user   : The 'user' parameter value given when calling BASS_RecordStart
RETURN : TRUE = continue recording, FALSE = stop 
'/
' BASS_ChannelIsActive return values
#define BASS_ACTIVE_STOPPED   0
#define BASS_ACTIVE_PLAYING   1
#define BASS_ACTIVE_STALLED   2
#define BASS_ACTIVE_PAUSED   3

' Channel attributes
#define BASS_ATTRIB_FREQ         1
#define BASS_ATTRIB_VOL            2
#define BASS_ATTRIB_PAN            3
#define BASS_ATTRIB_EAXMIX         4
#define BASS_ATTRIB_NOBUFFER      5
#define BASS_ATTRIB_CPU            7
#define BASS_ATTRIB_MUSIC_AMPLIFY   &h100
#define BASS_ATTRIB_MUSIC_PANSEP   &h101
#define BASS_ATTRIB_MUSIC_PSCALER   &h102
#define BASS_ATTRIB_MUSIC_BPM      &h103
#define BASS_ATTRIB_MUSIC_SPEED      &h104
#define BASS_ATTRIB_MUSIC_VOL_GLOBAL &h105
#define BASS_ATTRIB_MUSIC_VOL_CHAN   &h200 ' + channel #
#define BASS_ATTRIB_MUSIC_VOL_INST   &h300 ' + instrument #

' BASS_ChannelGetData flags
#define BASS_DATA_AVAILABLE   0         ' query how much data is buffered
#define BASS_DATA_FLOAT      &h40000000   ' flag: return floating-point sample data
#define BASS_DATA_FFT256   &h80000000   ' 256 sample FFT
#define BASS_DATA_FFT512   &h80000001   ' 512 FFT
#define BASS_DATA_FFT1024   &h80000002   ' 1024 FFT
#define BASS_DATA_FFT2048   &h80000003   ' 2048 FFT
#define BASS_DATA_FFT4096   &h80000004   ' 4096 FFT
#define BASS_DATA_FFT8192   &h80000005   ' 8192 FFT
#define BASS_DATA_FFT16384   &h80000006   ' 16384 FFT
#define BASS_DATA_FFT_INDIVIDUAL &h10   ' FFT flag: FFT for each channel, else all combined
#define BASS_DATA_FFT_NOWINDOW   &h20   ' FFT flag: no Hanning window
#define BASS_DATA_FFT_REMOVEDC   &h40   ' FFT flag: pre-remove DC bias

' BASS_ChannelGetTags types : what's returned
#define BASS_TAG_ID3      0   ' ID3v1 tags : TAG_ID3 structure
#define BASS_TAG_ID3V2      1   ' ID3v2 tags : variable length block
#define BASS_TAG_OGG      2   ' OGG comments : series of null-terminated UTF-8 strings
#define BASS_TAG_HTTP      3   ' HTTP headers : series of null-terminated ANSI strings
#define BASS_TAG_ICY      4   ' ICY headers : series of null-terminated ANSI strings
#define BASS_TAG_META      5   ' ICY metadata : ANSI string
#define BASS_TAG_APE      6   ' APE tags : series of null-terminated UTF-8 strings
#define BASS_TAG_MP4       7   ' MP4/iTunes metadata : series of null-terminated UTF-8 strings
#define BASS_TAG_VENDOR      9   ' OGG encoder : UTF-8 string
#define BASS_TAG_LYRICS3   10   ' Lyric3v2 tag : ASCII string
#define BASS_TAG_CA_CODEC   11   ' CoreAudio codec info : TAG_CA_CODEC structure
#define BASS_TAG_MF         13   ' Media Foundation tags : series of null-terminated UTF-8 strings
#define BASS_TAG_WAVEFORMAT   14   ' WAVE format : WAVEFORMATEEX structure
#define BASS_TAG_RIFF_INFO   &h100 ' RIFF "INFO" tags : series of null-terminated ANSI strings
#define BASS_TAG_RIFF_BEXT   &h101 ' RIFF/BWF "bext" tags : TAG_BEXT structure
#define BASS_TAG_RIFF_CART   &h102 ' RIFF/BWF "cart" tags : TAG_CART structure
#define BASS_TAG_RIFF_DISP   &h103 ' RIFF "DISP" text tag : ANSI string
#define BASS_TAG_APE_BINARY   &h1000   ' + index #, binary APE tag : TAG_APE_BINARY structure
#define BASS_TAG_MUSIC_NAME      &h10000   ' MOD music name : ANSI string
#define BASS_TAG_MUSIC_MESSAGE   &h10001   ' MOD message : ANSI string
#define BASS_TAG_MUSIC_ORDERS   &h10002   ' MOD order list : BYTE array of pattern numbers
#define BASS_TAG_MUSIC_INST      &h10100   ' + instrument #, MOD instrument name : ANSI string
#define BASS_TAG_MUSIC_SAMPLE   &h10300   ' + sample #, MOD sample name : ANSI string

' ID3v1 tag structure
type TAG_ID3
   id As zstring * 3 
   title As zstring * 30 
   artist As zstring * 30 
   album As zstring * 30 
   Year As zstring * 4 
   comment As zstring * 30 
   genre As BYTE 
end type

' Binary APE tag structure
type TAG_APE_BINARY
    key As Const zstring ptr 
   Data As const any ptr 
   length As DWORD 
end type

' BWF "bext" tag structure
type TAG_BEXT
   Description As zstring * 256          ' description
   Originator As zstring * 32          ' name of the originator
   OriginatorReference As zstring * 32    ' reference of the originator
   OriginationDate As zstring * 10       ' date of creation (yyyy-mm-dd)
   OriginationTime As zstring * 8       ' time of creation (hh-mm-ss)
   TimeReference As QWORD          ' first sample count since midnight (little-endian)
   Version As WORD                ' BWF version (little-endian)
   UMID(64-1) As BYTE                ' SMPTE UMID
   Reserved(190-1) As BYTE 
   CodingHistory As zstring * 1          ' history
end type

' BWF "cart" tag structures
type TAG_CART_TIMER
   dwUsage As DWORD                ' FOURCC timer usage ID
   dwValue As DWORD                ' timer value in samples from head
end type

type TAG_CART
   Version As zstring * 4             ' version of the data structure
   Title As zstring * 64                ' title of cart audio sequence
   Artist As zstring * 64             ' artist or creator name
   CutID As zstring * 64                ' cut number identification
   ClientID As zstring * 64             ' client identification
   Category As zstring * 64             ' category ID, PSA, NEWS, etc
   Classification As zstring * 64        ' classification or auxiliary key
   OutCue As zstring * 64             ' out cue text
   StartDate As zstring * 10             ' yyyy-mm-dd
   StartTime As zstring * 8             ' hh:mm:ss
   EndDate As zstring * 10              ' yyyy-mm-dd
   EndTime As zstring * 8             ' hh:mm:ss
   ProducerAppID As zstring * 64          ' name of vendor or application
   ProducerAppVersion As zstring * 64    ' version of producer application
   UserDef As zstring * 64             ' user defined text
   dwLevelReference As DWORD          ' sample value for 0 dB reference
   PostTimer(8-1) As TAG_CART_TIMER    ' 8 time markers after head
   Reserved As zstring * 276 
   URL As zstring * 1024                ' uniform resource locator
   TagText As zstring * 1             ' free form text for scripts or tags
end type

' CoreAudio codec info structure
type TAG_CA_CODEC
   ftype As DWORD                ' file format
   atype As DWORD                ' audio format
   Name As const zstring ptr             ' description
end type

' BASS_ChannelGetLength/GetPosition/SetPosition modes
#define BASS_POS_BYTE         0      ' byte position
#define BASS_POS_MUSIC_ORDER   1      ' order.row position, MAKELONG(order,row)
#define BASS_POS_DECODE         &h10000000 ' flag: get the decoding (not playing) position
#define BASS_POS_DECODETO      &h20000000 ' flag: decode to the position instead of seeking

' BASS_RecordSetInput flags
#define BASS_INPUT_OFF      &h10000
#define BASS_INPUT_ON      &h20000

#define BASS_INPUT_TYPE_MASK      &hff000000
#define BASS_INPUT_TYPE_UNDEF      &h00000000
#define BASS_INPUT_TYPE_DIGITAL      &h01000000
#define BASS_INPUT_TYPE_LINE      &h02000000
#define BASS_INPUT_TYPE_MIC         &h03000000
#define BASS_INPUT_TYPE_SYNTH      &h04000000
#define BASS_INPUT_TYPE_CD         &h05000000
#define BASS_INPUT_TYPE_PHONE      &h06000000
#define BASS_INPUT_TYPE_SPEAKER      &h07000000
#define BASS_INPUT_TYPE_WAVE      &h08000000
#define BASS_INPUT_TYPE_AUX         &h09000000
#define BASS_INPUT_TYPE_ANALOG      &h0a000000

' DX8 effect types, use with BASS_ChannelSetFX
enum
   BASS_FX_DX8_CHORUS
   BASS_FX_DX8_COMPRESSOR
   BASS_FX_DX8_DISTORTION
   BASS_FX_DX8_ECHO
   BASS_FX_DX8_FLANGER
   BASS_FX_DX8_GARGLE
   BASS_FX_DX8_I3DL2REVERB
   BASS_FX_DX8_PARAMEQ
   BASS_FX_DX8_REVERB
end enum

type BASS_DX8_CHORUS
    fWetDryMix as float       
    fDepth as float       
    fFeedback as float       
    fFrequency as float       
    lWaveform as DWORD          ' 0=triangle, 1=sine
    fDelay as float       
    lPhase as DWORD             ' BASS_DX8_PHASE_xxx
End Type

type BASS_DX8_COMPRESSOR
    fGain as float   
    fAttack as float   
    fRelease as float   
    fThreshold as float   
    fRatio as float   
    fPredelay as float   
End Type

type BASS_DX8_DISTORTION
    fGain as float   
    fEdge as float   
    fPostEQCenterFrequency as float   
    fPostEQBandwidth as float   
    fPreLowpassCutoff as float   
End Type

type BASS_DX8_ECHO
    fWetDryMix as float   
    fFeedback as float   
    fLeftDelay as float   
    fRightDelay as float   
    lPanDelay As BOOL    
End Type

type BASS_DX8_FLANGER
    fWetDryMix as float       
    fDepth as float       
    fFeedback as float       
    fFrequency as float       
    lWaveform as DWORD          ' 0=triangle, 1=sine
    fDelay as float       
    lPhase as DWORD             ' BASS_DX8_PHASE_xxx
end type

type BASS_DX8_GARGLE
    dwRateHz as DWORD                      ' Rate of modulation in hz
    dwWaveShape as DWORD                   ' 0=triangle, 1=square
end type

type BASS_DX8_I3DL2REVERB
    lRoom as Integer                       ' [-10000, 0]      default: -1000 mB
    lRoomHF as Integer                     ' [-10000, 0]      default: 0 mB
    flRoomRolloffFactor as float       ' [0.0, 10.0]      default: 0.0
    flDecayTime as float               ' [0.1, 20.0]      default: 1.49s
    flDecayHFRatio as float            ' [0.1, 2.0]       default: 0.83
    lReflections as Integer                ' [-10000, 1000]   default: -2602 mB
    flReflectionsDelay as float        ' [0.0, 0.3]       default: 0.007 s
    lReverb as Integer                     ' [-10000, 2000]   default: 200 mB
    flReverbDelay as float             ' [0.0, 0.1]       default: 0.011 s
    flDiffusion as float               ' [0.0, 100.0]     default: 100.0 %
    flDensity as float                 ' [0.0, 100.0]     default: 100.0 %
    flHFReference as float             ' [20.0, 20000.0]  default: 5000.0 Hz
end type

type BASS_DX8_PARAMEQ
    fCenter as float   
    fBandwidth as float   
    fGain as float   
End Type

type BASS_DX8_REVERB
    fInGain as float                   ' [-96.0,0.0]            default: 0.0 dB
    fReverbMix as float                ' [-96.0,0.0]            default: 0.0 db
    fReverbTime as float               ' [0.001,3000.0]         default: 1000.0 ms
    fHighFreqRTRatio as float          ' [0.001,0.999]          default: 0.001
End Type

#define BASS_DX8_PHASE_NEG_180        0
#define BASS_DX8_PHASE_NEG_90         1
#define BASS_DX8_PHASE_ZERO           2
#define BASS_DX8_PHASE_90             3
#define BASS_DX8_PHASE_180            4


'= = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = =  
'
Type clsBass Extends Object
Private:   
    m_pDll As Any Ptr     
    
    
Private:     
    
    
Public:    
    Declare Constructor
    Declare Destructor    
    
    
    
Public:     
    Declare Function SetConfig(ByVal nOption As DWORD ,ByVal nValue As DWORD) As BOOLEAN 'declare function BASS_SetConfig alias "BASS_SetConfig"(byval option as DWORD, byval value as DWORD ) as BOOL
    Declare Function GetConfig(ByVal nOption As DWORD) As DWORD 'declare function BASS_GetConfig alias "BASS_GetConfig"(byval option as DWORD ) as DWORD
    Declare Function SetConfigPtr(ByVal nOption As DWORD ,ByVal nValue As Any Ptr) As BOOLEAN 'declare function BASS_SetConfigPtr alias "BASS_SetConfigPtr"(byval nOption as DWORD, byval value as any ptr) as BOOL
    Declare Function GetConfigPtr(ByVal nOption As DWORD) As Any Ptr 'declare function BASS_GetConfigPtr alias "BASS_GetConfigPtr"(byval nOption as DWORD) as any ptr
    Declare Function GetVersion() as DWORD 'declare function BASS_GetVersion alias "BASS_GetVersion"() as DWORD
    Declare Function ErrorGetCode() as Integer 'declare function BASS_ErrorGetCode alias "BASS_ErrorGetCode"() as integer
    Declare Function GetDeviceInfo(ByVal nDevice as DWORD, ByVal info as BASS_DEVICEINFO Ptr) as Boolean 'declare function BASS_GetDeviceInfo alias "BASS_GetDeviceInfo"(byval device as DWORD, byval info as BASS_DEVICEINFO ptr) as BOOL  
#ifdef __FB_WIN32__
    Declare Function Init(ByVal nDevice as Integer, ByVal freq as DWORD, ByVal nFlags as DWORD, ByVal hWin as .hWnd, ByVal dsGuid as Const GUID Ptr) as Boolean   'declare function BASS_Init alias "BASS_Init"(byval device as integer, byval freq as DWORD, byval flags as DWORD, byval win as HWND, byval dsguid as const GUID ptr) as BOOL
#else
    Declare Function Init(ByVal nDevice as Integer, ByVal freq as DWORD, ByVal nFlags as DWORD, ByVal hWin as Any Ptr, ByVal dsGuid as Any Ptr) as Boolean  'declare function BASS_Init alias "BASS_Init"(byval device as integer, byval freq as DWORD , byval flags as DWORD , byval win as any ptr, byval dsguid as any ptr) as BOOL
#endif
    Declare Function SetDevice(ByVal nDevice as DWORD) as BOOLEAN 'declare function BASS_SetDevice alias "BASS_SetDevice"(byval device as DWORD) as BOOL 
    Declare Function GetDevice() as DWORD 'declare function BASS_GetDevice alias "BASS_GetDevice"() as DWORD
    Declare Function free() as BOOLEAN 'declare function BASS_Free alias "BASS_Free"() as BOOL 
#ifdef __FB_WIN32__
    Declare Function GetDSoundObject(ByVal nObject as DWORD) as Any Ptr 'declare function BASS_GetDSoundObject alias "BASS_GetDSoundObject"(byval object as DWORD) as any ptr
#endif
    Declare Function GetInfo(ByVal info as BASS_INFO Ptr) as BOOLEAN 'declare function BASS_GetInfo alias "BASS_GetInfo"(byval info as BASS_INFO  ptr) as BOOL
    Declare Function Update(ByVal nLength as DWORD) as Boolean 'declare function BASS_Update alias "BASS_Update"(byval length as DWORD) as BOOL
    Declare Function GetCPU() as float 'declare function BASS_GetCPU alias "BASS_GetCPU"() as float
    Declare Function Start() as Boolean 'declare function BASS_Start alias "BASS_Start"() as BOOL 
    Declare Function Stop() as Boolean 'declare function BASS_Stop alias "BASS_Stop"() as BOOL
    Declare Function Pause() as Boolean 'declare function BASS_Pause alias "BASS_Pause"() as BOOL
    Declare Function SetVolume(byval volume as float) as Boolean'declare function BASS_SetVolume alias "BASS_SetVolume"(byval volume as float ) as BOOL
    Declare Function GetVolume() as float 'declare function BASS_GetVolume alias "BASS_GetVolume"() as float
'
    Declare Function PluginLoad(ByVal pFile as Const Any Ptr, ByVal nFlags as DWORD) as HPLUGIN 'declare function BASS_PluginLoad alias "BASS_PluginLoad"(byval file as const any ptr, byval flags as DWORD) as HPLUGIN
    Declare Function PluginFree(ByVal nHandle as HPLUGIN) as Boolean'declare function BASS_PluginFree alias "BASS_PluginFree"(byval handle as HPLUGIN) as BOOL
    Declare Function PluginGetInfo(ByVal nHandle as HPLUGIN) as Const BASS_PLUGININFO Ptr 'declare function BASS_PluginGetInfo alias "BASS_PluginGetInfo"(byval handle as HPLUGIN) as const BASS_PLUGININFO ptr
'
    Declare Function Set3DFactors(ByVal distf as float, ByVal rollf as float, ByVal doppf as float) as Boolean'declare function BASS_Set3DFactors alias "BASS_Set3DFactors"(byval distf as FLOAT, byval rollf as float, byval doppf as float ) as BOOL 
    Declare Function Get3DFactors(ByVal distf as float Ptr, ByVal rollf as float Ptr, ByVal doppf as float Ptr) as Boolean'declare function BASS_Get3DFactors alias "BASS_Get3DFactors"(byval distf as float ptr, byval rollf as float ptr, byval doppf as float ptr) as BOOL
    Declare Function Set3DPosition(ByVal nPos as Const BASS_3DVECTOR Ptr, ByVal vel as Const BASS_3DVECTOR Ptr, ByVal front as Const BASS_3DVECTOR Ptr, ByVal top as Const BASS_3DVECTOR Ptr) as Boolean'declare function BASS_Set3DPosition alias "BASS_Set3DPosition"(byval pos as const BASS_3DVECTOR ptr, byval vel as const BASS_3DVECTOR ptr, byval front as const BASS_3DVECTOR ptr, byval top as const BASS_3DVECTOR ptr) as BOOL
    Declare Function Get3DPosition(ByVal nPos as BASS_3DVECTOR Ptr, ByVal vel as BASS_3DVECTOR Ptr, ByVal front as BASS_3DVECTOR Ptr, ByVal top as BASS_3DVECTOR Ptr) as Boolean'declare function BASS_Get3DPosition alias "BASS_Get3DPosition"(byval pos as BASS_3DVECTOR ptr, byval vel as BASS_3DVECTOR ptr, byval front as BASS_3DVECTOR ptr, byval top as BASS_3DVECTOR ptr) as BOOL
    Declare Sub Apply3D() 'declare sub  BASS_Apply3D alias "BASS_Apply3D"()
#ifdef __FB_WIN32__
    Declare Function SetEAXParameters(ByVal env as Integer, ByVal vol as float, ByVal decay as float, ByVal damp as float) as Boolean'declare function BASS_SetEAXParameters alias "BASS_SetEAXParameters"(byval env as integer, byval vol as float, byval decay as float, byval damp as float) as BOOL
    Declare Function GetEAXParameters(ByVal env As DWORD Ptr, ByVal vol As FLOAT Ptr, ByVal decay As FLOAT Ptr, ByVal damp As FLOAT Ptr) As Boolean'declare function BASS_GetEAXParameters alias "BASS_GetEAXParameters"(byval env as DWORD ptr, byval vol as float ptr, byval decay as float ptr, byval damp as float ptr) as BOOL
#endif
'
    Declare Function MusicLoad(ByVal mem as BOOL, ByVal pFile as Const Any Ptr, ByVal offset as QWORD, ByVal length as DWORD, ByVal nFlags as DWORD, ByVal freq as DWORD) as HMUSIC'declare function BASS_MusicLoad alias "BASS_MusicLoad"(byval mem as BOOL, byval file as const any ptr, byval offset as QWORD, byval length as DWORD, byval flags as DWORD, byval freq as DWORD) as HMUSIC 
    Declare Function MusicFree(ByVal nHandle as HMUSIC) as Boolean'declare function BASS_MusicFree alias "BASS_MusicFree"(byval handle as HMUSIC) as BOOL
'
    Declare Function SampleLoad(ByVal mem as BOOL, ByVal pFile as Const Any Ptr, ByVal offset as QWORD, ByVal length as DWORD, ByVal max as DWORD , ByVal nFlags as DWORD) as HSAMPLE  'declare function BASS_SampleLoad alias "BASS_SampleLoad"(byval mem as BOOL, byval file as const any ptr, byval offset as QWORD, byval length as DWORD, byval max as DWORD , byval flags as DWORD) as HSAMPLE
    Declare Function SampleCreate(ByVal length as DWORD, ByVal freq as DWORD, ByVal chans as DWORD , ByVal max as DWORD, ByVal nFlags as DWORD) as HSAMPLE'declare function BASS_SampleCreate alias "BASS_SampleCreate"(byval length as DWORD, byval freq as DWORD, byval chans as DWORD , byval max as DWORD, byval flags as DWORD) as HSAMPLE
    Declare Function SampleFree(ByVal nHandle as HSAMPLE) as Boolean'declare function BASS_SampleFree alias "BASS_SampleFree"(byval handle as HSAMPLE) as BOOL
    Declare Function SampleSetData(ByVal nHandle as HSAMPLE,ByVal buffer as Const Any Ptr) as Boolean'declare function BASS_SampleSetData alias "BASS_SampleSetData"(byval handle as HSAMPLE , byval buffer as const any ptr) as BOOL
    Declare Function SampleGetData(ByVal nHandle as HSAMPLE,ByVal buffer as Any Ptr) as Boolean'declare function BASS_SampleGetData alias "BASS_SampleGetData"(byval handle as HSAMPLE, byval buffer as any ptr) as BOOL
    Declare Function SampleGetInfo(ByVal nHandle as HSAMPLE,ByVal info as BASS_SAMPLE Ptr) as BOOLEAN 'declare function BASS_SampleGetInfo alias "BASS_SampleGetInfo"(byval handle as HSAMPLE, byval info as BASS_SAMPLE ptr) as BOOL 
    Declare Function SampleSetInfo(ByVal nHandle as HSAMPLE,ByVal info as Const BASS_SAMPLE Ptr) as Boolean'declare function BASS_SampleSetInfo alias "BASS_SampleSetInfo"(byval handle as HSAMPLE, byval info as const BASS_SAMPLE ptr) as BOOL
    Declare Function SampleGetChannel(ByVal nHandle as HSAMPLE,ByVal onlynew as BOOL) as HCHANNEL 'declare function BASS_SampleGetChannel alias "BASS_SampleGetChannel"(byval handle as HSAMPLE, byval onlynew as BOOL) as HCHANNEL
    Declare Function SampleGetChannels(ByVal nHandle as HSAMPLE, ByVal channels as HCHANNEL Ptr) as DWORD'declare function BASS_SampleGetChannels alias "BASS_SampleGetChannels"(byval handle as HSAMPLE, byval channels as HCHANNEL ptr) as DWORD
    Declare Function SampleStop(ByVal nHandle as HSAMPLE) as Boolean'declare function BASS_SampleStop alias "BASS_SampleStop"(byval handle as HSAMPLE) as BOOL
'
    Declare Function StreamCreate(ByVal freq as DWORD, ByVal chans as DWORD, ByVal nFlags as DWORD , ByVal pProc as STREAMPROC Ptr, ByVal user as Any Ptr) as HSTREAM'declare function BASS_StreamCreate alias "BASS_StreamCreate"(byval freq as DWORD, byval chans as DWORD, byval flags as DWORD , byval proc as STREAMPROC ptr, byval user as any ptr) as HSTREAM
    Declare Function StreamCreateFile(ByVal mem as BOOL , ByVal pFile as Any Ptr, ByVal offset as QWORD, ByVal length as QWORD, ByVal nFlags as DWORD) as HSTREAM'declare function BASS_StreamCreateFile alias "BASS_StreamCreateFile"(byval mem as BOOL , byval file as any ptr, byval offset as QWORD, byval length as QWORD, byval flags as DWORD ) as HSTREAM
    Declare Function StreamCreateURL(ByVal url as ZString Ptr, ByVal offset as DWORD, ByVal nFlags as DWORD, ByVal pProc as DOWNLOADPROC Ptr, ByVal user as Any Ptr) as HSTREAM 'declare function BASS_StreamCreateURL alias "BASS_StreamCreateURL"(byval url as zstring ptr, byval offset as DWORD, byval flags as DWORD, byval proc as DOWNLOADPROC ptr, byval user as any ptr) as HSTREAM 
    Declare Function StreamCreateFileUser(ByVal nSystem as DWORD, ByVal nFlags as DWORD, ByVal pProc as Const BASS_FILEPROCS Ptr, ByVal user as Any Ptr) as HSTREAM'declare function BASS_StreamCreateFileUser alias "BASS_StreamCreateFileUser"(byval system as DWORD, byval flags as DWORD, byval proc as const BASS_FILEPROCS ptr, byval user as any ptr) as HSTREAM
    Declare Function StreamFree(ByVal nHandle as HSTREAM) as Boolean'declare function BASS_StreamFree alias "BASS_StreamFree"(byval handle as HSTREAM) as BOOL
'
    Declare Function StreamGetFilePosition(ByVal nHandle as HSTREAM, ByVal mode as DWORD) as QWORD'declare function BASS_StreamGetFilePosition alias "BASS_StreamGetFilePosition"(byval handle as HSTREAM, byval mode as DWORD) as QWORD
    Declare Function StreamPutData(ByVal nHandle as HSTREAM, ByVal buffer as Any Ptr, ByVal length as DWORD) as DWORD'declare function BASS_StreamPutData alias "BASS_StreamPutData"(byval handle as HSTREAM, byval buffer as any ptr, byval length as DWORD) as DWORD
    Declare Function StreamPutFileData(ByVal nHandle as HSTREAM, ByVal buffer as Const Any Ptr, ByVal length as DWORD) as DWORD'declare function BASS_StreamPutFileData alias "BASS_StreamPutFileData"(byval handle as HSTREAM, byval buffer as const any ptr, byval length as DWORD) as DWORD
'
    Declare Function RecordGetDeviceInfo(ByVal nDevice as DWORD, ByVal info as BASS_DEVICEINFO Ptr) as Boolean'declare function BASS_RecordGetDeviceInfo alias "BASS_RecordGetDeviceInfo"(byval device as DWORD , byval info as BASS_DEVICEINFO ptr) as BOOL
    Declare Function RecordInit(ByVal nDevice as Integer) as Boolean'declare function BASS_RecordInit alias "BASS_RecordInit"(byval device as integer) as BOOL
    Declare Function RecordSetDevice(ByVal nDevice as DWORD) as Boolean'declare function BASS_RecordSetDevice alias "BASS_RecordSetDevice"(byval device as DWORD) as BOOL 
    Declare Function RecordGetDevice() as DWORD'declare function BASS_RecordGetDevice alias "BASS_RecordGetDevice"() as DWORD
    Declare Function RecordFree() as Boolean'declare function BASS_RecordFree alias "BASS_RecordFree"() as BOOL
    Declare Function RecordGetInfo(ByVal info as BASS_RECORDINFO Ptr) as Boolean'declare function BASS_RecordGetInfo alias "BASS_RecordGetInfo"(byval info as BASS_RECORDINFO ptr) as BOOL
    Declare Function RecordGetInputName(ByVal nInput as Integer) as ZString Ptr'declare function BASS_RecordGetInputName alias "BASS_RecordGetInputName"(byval input as integer) as zstring ptr
    Declare Function RecordSetInput(ByVal nInput as Integer, ByVal nFlags as DWORD, ByVal volume as float) as Boolean'declare function BASS_RecordSetInput alias "BASS_RecordSetInput"(byval input as integer, byval flags as DWORD, byval volume as float) as BOOL
    Declare Function RecordGetInput(ByVal nInput as Integer, ByVal volume as float Ptr) as DWORD'declare function BASS_RecordGetInput alias "BASS_RecordGetInput"(byval input as integer, byval volume as float ptr) as DWORD
    Declare Function RecordStart(ByVal freq as DWORD, ByVal chans as DWORD, ByVal nFlags as DWORD, ByVal pProc as RECORDPROC Ptr, ByVal user as Any Ptr) as HRECORD'declare function BASS_RecordStart alias "BASS_RecordStart"(byval freq as DWORD, byval chans as DWORD, byval flags as DWORD, byval proc as RECORDPROC ptr, byval user as any ptr) as HRECORD
'
    Declare Function ChannelBytes2Seconds(ByVal nHandle as DWORD, ByVal nPos as QWORD) as Double'declare function BASS_ChannelBytes2Seconds alias "BASS_ChannelBytes2Seconds"(byval handle as DWORD , byval pos as QWORD) as double
    Declare Function ChannelSeconds2Bytes(ByVal nHandle as DWORD, ByVal nPos as Double) as QWORD'declare function BASS_ChannelSeconds2Bytes alias "BASS_ChannelSeconds2Bytes"(byval handle as DWORD, byval pos as double) as QWORD
    Declare Function ChannelGetDevice(ByVal nHandle as DWORD) as DWORD'declare function BASS_ChannelGetDevice alias "BASS_ChannelGetDevice"(byval handle as DWORD) as DWORD
    Declare Function ChannelSetDevice(ByVal nHandle As DWORD, ByVal nDevice As DWORD) As Boolean'declare function BASS_ChannelSetDevice alias "BASS_ChannelSetDevice"(byval handle as DWORD, byval device as DWORD) as BOOL
    Declare Function ChannelIsActive(ByVal nHandle as DWORD) as DWORD'declare function BASS_ChannelIsActive alias "BASS_ChannelIsActive"(byval handle as DWORD) as DWORD
    Declare Function ChannelGetInfo(ByVal nHandle as DWORD,ByVal info as BASS_CHANNELINFO Ptr) as Boolean'declare function BASS_ChannelGetInfo alias "BASS_ChannelGetInfo"(byval handle as DWORD, byval info as BASS_CHANNELINFO ptr) as BOOL
    Declare Function ChannelGetTags(ByVal nHandle as DWORD,ByVal tags as DWORD) as ZString Ptr'declare function BASS_ChannelGetTags alias "BASS_ChannelGetTags"(byval handle as DWORD, byval tags as DWORD) as zstring ptr
    Declare Function ChannelFlags(ByVal nHandle as DWORD,ByVal nFlags as DWORD, ByVal mask as DWORD) as DWORD'declare function BASS_ChannelFlags alias "BASS_ChannelFlags"(byval handle as DWORD, byval flags as DWORD, byval mask as DWORD) as DWORD
    Declare Function ChannelUpdate(ByVal nHandle as DWORD,ByVal length as DWORD) as Boolean'declare function BASS_ChannelUpdate alias "BASS_ChannelUpdate"(byval handle as DWORD, byval length as DWORD) as BOOL
    Declare Function ChannelLock(ByVal nHandle as DWORD,ByVal nLock as BOOL) as Boolean'declare function BASS_ChannelLock alias "BASS_ChannelLock"(byval handle as DWORD, byval lock as BOOL) as BOOL
    Declare Function ChannelPlay(ByVal nHandle as DWORD,ByVal restart as BOOL) as Boolean'declare function BASS_ChannelPlay alias "BASS_ChannelPlay"(byval handle as DWORD, byval restart as BOOL) as BOOL
    Declare Function ChannelStop(ByVal nHandle as DWORD) as Boolean'declare function BASS_ChannelStop alias "BASS_ChannelStop"(byval handle as DWORD) as BOOL
    Declare Function ChannelPause(ByVal nHandle as DWORD) as Boolean'declare function BASS_ChannelPause alias "BASS_ChannelPause"(byval handle as DWORD) as BOOL
    Declare Function ChannelSetAttribute(ByVal nHandle as DWORD, ByVal attrib as DWORD, ByVal nValue as float) as Boolean'declare function BASS_ChannelSetAttribute alias "BASS_ChannelSetAttribute"(byval handle as DWORD, byval attrib as DWORD, byval value as float) as BOOL
    Declare Function ChannelGetAttribute(ByVal nHandle as DWORD, ByVal attrib as DWORD, ByVal nValue as float Ptr) as Boolean'declare function BASS_ChannelGetAttribute alias "BASS_ChannelGetAttribute"(byval handle as DWORD, byval attrib as DWORD, byval value as float ptr) as BOOL
    Declare Function ChannelSlideAttribute(ByVal nHandle as DWORD, ByVal attrib as DWORD, ByVal nValue as float, ByVal nTime as DWORD) as Boolean'declare function BASS_ChannelSlideAttribute alias "BASS_ChannelSlideAttribute"(byval handle as DWORD, byval attrib as DWORD, byval value as float, byval time as DWORD) as BOOL
    Declare Function ChannelIsSliding(ByVal nHandle as DWORD, ByVal attrib as DWORD) as Boolean'declare function BASS_ChannelIsSliding alias "BASS_ChannelIsSliding"(byval handle as DWORD, byval attrib as DWORD) as BOOL
    Declare Function ChannelSet3DAttributes(ByVal nHandle as DWORD, ByVal mode as Integer, ByVal min as float, ByVal max as float, ByVal iangle as Integer, ByVal oangle as Integer, ByVal outvol as float) as Boolean'declare function BASS_ChannelSet3DAttributes alias "BASS_ChannelSet3DAttributes"(byval handle as DWORD, byval mode as integer, byval min as float, byval max as float, byval iangle as integer, byval oangle as integer, byval outvol as float) as BOOL
    Declare Function ChannelGet3DAttributes(ByVal nHandle as DWORD, ByVal mode as DWORD Ptr, ByVal min as float Ptr, ByVal max as float Ptr, ByVal iangle as DWORD Ptr, ByVal oangle as DWORD Ptr, ByVal outvol as float Ptr) as Boolean'declare function BASS_ChannelGet3DAttributes alias "BASS_ChannelGet3DAttributes"(byval handle as DWORD, byval mode as DWORD ptr, byval min as float ptr, byval max as float ptr, byval iangle as DWORD ptr, byval oangle as DWORD ptr, byval outvol as float ptr) as BOOL
    Declare Function ChannelSet3DPosition(ByVal nHandle as DWORD, ByVal nPos as Const BASS_3DVECTOR Ptr, ByVal orient as Const BASS_3DVECTOR Ptr, ByVal vel as Const BASS_3DVECTOR Ptr) as Boolean'declare function BASS_ChannelSet3DPosition alias "BASS_ChannelSet3DPosition"(byval handle as DWORD, byval pos as const BASS_3DVECTOR ptr, byval orient as const BASS_3DVECTOR ptr, byval vel as const BASS_3DVECTOR ptr) as BOOL
    Declare Function ChannelGet3DPosition(ByVal nHandle as DWORD, ByVal nPos as BASS_3DVECTOR Ptr, ByVal orient as BASS_3DVECTOR Ptr, ByVal vel as BASS_3DVECTOR Ptr) as Boolean'declare function BASS_ChannelGet3DPosition alias "BASS_ChannelGet3DPosition"(byval handle as DWORD, byval pos as BASS_3DVECTOR ptr, byval orient as BASS_3DVECTOR ptr, byval vel as BASS_3DVECTOR ptr) as BOOL
    Declare Function ChannelGetLength(ByVal nHandle as DWORD, ByVal mode as DWORD) as QWORD'declare function BASS_ChannelGetLength alias "BASS_ChannelGetLength"(byval handle as DWORD, byval mode as DWORD) as QWORD
    Declare Function ChannelSetPosition(ByVal nHandle as DWORD, ByVal nPos as QWORD, ByVal mode as DWORD) as Boolean'declare function BASS_ChannelSetPosition alias "BASS_ChannelSetPosition"(byval handle as DWORD, byval pos as QWORD, byval mode as DWORD) as BOOL
    Declare Function ChannelGetPosition(ByVal nHandle as DWORD, ByVal mode as DWORD) as QWORD'declare function BASS_ChannelGetPosition alias "BASS_ChannelGetPosition"(byval handle as DWORD, byval mode as DWORD) as QWORD
    Declare Function ChannelGetLevel(ByVal nHandle as DWORD) as DWORD'declare function BASS_ChannelGetLevel alias "BASS_ChannelGetLevel"(byval handle as DWORD) as DWORD
    Declare Function ChannelGetData(ByVal nHandle as DWORD, ByVal buffer as Any Ptr, ByVal length as DWORD) as DWORD'declare function BASS_ChannelGetData alias "BASS_ChannelGetData"(byval handle as DWORD, byval buffer as any ptr, byval length as DWORD) as DWORD
    Declare Function ChannelSetSync(ByVal nHandle as DWORD, ByVal nType as DWORD, ByVal param as QWORD, ByVal pProc as SYNCPROC Ptr, ByVal user as Any Ptr) as HSYNC'declare function BASS_ChannelSetSync alias "BASS_ChannelSetSync"(byval handle as DWORD, byval type as DWORD, byval param as QWORD, byval proc as SYNCPROC ptr, byval user as any ptr) as HSYNC 
    Declare Function ChannelRemoveSync(ByVal nHandle as DWORD, ByVal sync as HSYNC) as Boolean'declare function BASS_ChannelRemoveSync alias "BASS_ChannelRemoveSync"(byval handle as DWORD, byval sync as HSYNC) as BOOL
    Declare Function ChannelSetDSP(ByVal nHandle as DWORD, ByVal pProc as DSPPROC Ptr, ByVal user as Any Ptr, ByVal priority as Integer) as HDSP'declare function BASS_ChannelSetDSP alias "BASS_ChannelSetDSP"(byval handle as DWORD, byval proc as DSPPROC ptr, byval user as any ptr, byval priority as integer) as HDSP
    Declare Function ChannelRemoveDSP(ByVal nHandle as DWORD, ByVal dsp as HDSP) as Boolean'declare function BASS_ChannelRemoveDSP alias "BASS_ChannelRemoveDSP"(byval handle as DWORD, byval dsp as HDSP) as BOOL
    Declare Function ChannelSetLink(ByVal nHandle as DWORD , ByVal chan as DWORD) as Boolean'declare function BASS_ChannelSetLink alias "BASS_ChannelSetLink"(byval handle as DWORD , byval chan as DWORD) as BOOL
    Declare Function ChannelRemoveLink(ByVal nHandle as DWORD, ByVal chan as DWORD) as Boolean'declare function BASS_ChannelRemoveLink alias "BASS_ChannelRemoveLink"(byval handle as DWORD, byval chan as DWORD) as BOOL
    Declare Function ChannelSetFX(ByVal nHandle as DWORD, ByVal nType as DWORD, ByVal priority as Integer) as HFX 'declare function BASS_ChannelSetFX alias "BASS_ChannelSetFX"(byval handle as DWORD, byval type as DWORD, byval priority as integer) as HFX
    Declare Function ChannelRemoveFX(ByVal nHandle as DWORD, ByVal fx as HFX) as Boolean'declare function BASS_ChannelRemoveFX alias "BASS_ChannelRemoveFX"(byval handle as DWORD, byval fx as HFX) as BOOL
'
    Declare Function FXSetParameters(ByVal nHandle as HFX, ByVal params as Const Any Ptr) as Boolean'declare function BASS_FXSetParameters alias "BASS_FXSetParameters"(byval handle as HFX, byval params as const any ptr) as BOOL
    Declare Function FXGetParameters(ByVal nHandle as HFX, ByVal params as Any Ptr) as Boolean'declare function BASS_FXGetParameters alias "BASS_FXGetParameters"(byval handle as HFX, byval params as any ptr) as BOOL
    Declare Function FXReset(ByVal nHandle as HFX) as Boolean'declare function BASS_FXReset alias "BASS_FXReset"(byval handle as HFX) as BOOL 
End Type

Constructor clsBass
    m_pDll = DyLibLoad("bass.dll")
    If m_pDll Then
    
    Else
        AfxMsg "BASS.dll文件不存在"
    End If
End Constructor

Destructor clsBass
    If m_pDll Then
        DyLibFree(m_pDll)
    End If
End Destructor
    

'declare function BASS_SetConfig alias "BASS_SetConfig"(byval nOption as DWORD, byval value as DWORD ) as BOOL
Function clsBass.SetConfig(ByVal nOption as DWORD ,ByVal nValue as DWORD) as BOOLEAN 
    If m_pDll Then
        Dim pFunc as Function(ByVal as DWORD,ByVal as DWORD) as BOOL   
        pFunc = DyLibSymbol(m_pDll ,"BASS_SetConfig")
        If pFunc Then
            Return pFunc(nOption,nValue)
        End If
    End If 
End Function

'declare function BASS_GetConfig alias "BASS_GetConfig"(byval nOption as DWORD ) as DWORD
Function clsBass.GetConfig(ByVal nOption As DWORD) As DWORD 
    If m_pDll Then
        Dim pFunc as Function(ByVal as DWORD) as DWORD  
        pFunc = DyLibSymbol(m_pDll ,"BASS_GetConfig")
        If pFunc Then
            Return pFunc(nOption)
        End If
    End If 
End Function

'declare function BASS_SetConfigPtr alias "BASS_SetConfigPtr"(byval nOption as DWORD, byval value as any ptr) as BOOL
Function clsBass.SetConfigPtr(ByVal nOption as DWORD ,ByVal nValue as Any Ptr) as BOOLEAN 
    If m_pDll Then
        Dim pFunc as Function(ByVal as DWORD,ByVal as Any Ptr) as BOOL 
        pFunc = DyLibSymbol(m_pDll ,"BASS_SetConfigPtr")
        If pFunc Then
            Return pFunc(nOption,nValue)
        End If
    End If 
End Function

'declare function BASS_GetConfigPtr alias "BASS_GetConfigPtr"(byval nOption as DWORD) as any ptr
Function clsBass.GetConfigPtr(ByVal nOption As DWORD) As Any Ptr 
    If m_pDll Then
        Dim pFunc as Function(ByVal as DWORD) as Any Ptr 
        pFunc = DyLibSymbol(m_pDll ,"BASS_GetConfigPtr")
        If pFunc Then
            Return pFunc(nOption)
        End If
    End If
End Function

'declare function BASS_GetVersion alias "BASS_GetVersion"() as DWORD
Function clsBass.GetVersion() as DWORD 
    If m_pDll Then
        Dim pFunc As Function() As DWORD    
        pFunc = DyLibSymbol(m_pDll ,"BASS_GetVersion")
        If pFunc Then
            Return pFunc()
        End If
    End If
End Function

'declare function BASS_ErrorGetCode alias "BASS_ErrorGetCode"() as integer
Function clsBass.ErrorGetCode() as Integer 
    If m_pDll Then
        Dim pFunc as Function() as Integer  
        pFunc = DyLibSymbol(m_pDll ,"BASS_ErrorGetCode")
        If pFunc Then
            Return pFunc()
        End If
    End If 
End Function

'declare function BASS_GetDeviceInfo alias "BASS_GetDeviceInfo"(byval device as DWORD, byval info as BASS_DEVICEINFO ptr) as BOOL 
Function clsBass.GetDeviceInfo(ByVal nDevice as DWORD ,ByVal info as BASS_DEVICEINFO Ptr) as Boolean 
    If m_pDll Then
        Dim pFunc as Function(ByVal as DWORD,ByVal as BASS_DEVICEINFO Ptr) as BOOL 
        pFunc = DyLibSymbol(m_pDll ,"BASS_GetDeviceInfo")
        If pFunc Then
            Return pFunc(nDevice,info)
        End If
    End If
End Function
 
#ifdef __FB_WIN32__
'declare function BASS_Init alias "BASS_Init"(byval device as integer, byval freq as DWORD, byval flags as DWORD, byval win as HWND, byval dsguid as const GUID ptr) as BOOL
Function clsBass.Init(ByVal nDevice As Integer ,ByVal freq As DWORD ,ByVal nFlags As DWORD ,ByVal hWin As .hWnd ,ByVal dsGuid As Const GUID Ptr) As Boolean   
#Else
'declare function BASS_Init alias "BASS_Init"(byval device as integer, byval freq as DWORD , byval flags as DWORD , byval win as any ptr, byval dsguid as any ptr) as BOOL
Function clsBass.Init(ByVal nDevice as Integer, ByVal freq as DWORD, ByVal nFlags as DWORD, ByVal hWin as Any Ptr, ByVal dsGuid as Any Ptr) as Boolean  
#EndIf 
    If m_pDll Then
    #Ifdef __FB_WIN32__
        Dim pFunc as Function(ByVal As Integer,ByVal As DWORD,ByVal As DWORD,ByVal as .hWnd,ByVal As Const GUID Ptr) as BOOL 
    #Else
        Dim pFunc as Function(ByVal As Integer,ByVal As DWORD,ByVal As DWORD,ByVal as Any Ptr,ByVal as Any Ptr) as BOOL 
    #EndIf
        pFunc = DyLibSymbol(m_pDll ,"BASS_Init")
        If pFunc Then
            Return pFunc(nDevice,freq,nFlags,hWin,dsGuid)
        End If
    End If
End Function

'declare function BASS_SetDevice alias "BASS_SetDevice"(byval device as DWORD) as BOOL
Function clsBass.SetDevice(ByVal nDevice as DWORD) as BOOLEAN 
    If m_pDll Then
        Dim pFunc as Function(ByVal as DWORD) as BOOL 
        pFunc = DyLibSymbol(m_pDll ,"BASS_SetDevice")
        If pFunc Then
            Return pFunc(nDevice)
        End If
    End If
End Function

'declare function BASS_GetDevice alias "BASS_GetDevice"() as DWORD
Function clsBass.GetDevice() as DWORD 
    If m_pDll Then
        Dim pFunc as Function() as DWORD 
        pFunc = DyLibSymbol(m_pDll ,"BASS_GetDevice")
        If pFunc Then
            Return pFunc()
        End If
    End If    
End Function

'declare function BASS_Free alias "BASS_Free"() as BOOL 
Function clsBass.free() as BOOLEAN 
    If m_pDll Then
        Dim pFunc as Function() as BOOL 
        pFunc = DyLibSymbol(m_pDll ,"BASS_Free")
        If pFunc Then
            Return pFunc()
        End If
    End If
End Function

#ifdef __FB_WIN32__
'declare function BASS_GetDSoundObject alias "BASS_GetDSoundObject"(byval object as DWORD) as any ptr
Function clsBass.GetDSoundObject(ByVal nObject as DWORD) as Any Ptr 
    If m_pDll Then
        Dim pFunc as Function(ByVal as DWORD) as Any Ptr 
        pFunc = DyLibSymbol(m_pDll ,"BASS_GetDSoundObject")
        If pFunc Then
            Return pFunc(nObject)
        End If
    End If
End Function
#endif

'declare function BASS_GetInfo alias "BASS_GetInfo"(byval info as BASS_INFO  ptr) as BOOL
Function clsBass.GetInfo(ByVal info as BASS_INFO Ptr) as BOOLEAN 
    If m_pDll Then
        Dim pFunc as Function(ByVal as BASS_INFO Ptr) as BOOL 
        pFunc = DyLibSymbol(m_pDll ,"BASS_GetInfo")
        If pFunc Then
            Return pFunc(info)
        End If
    End If
End Function

'declare function BASS_Update alias "BASS_Update"(byval length as DWORD) as BOOL
Function clsBass.Update(ByVal nLength as DWORD) as Boolean 
    If m_pDll Then
        Dim pFunc as Function(ByVal as DWORD) as BOOL 
        pFunc = DyLibSymbol(m_pDll ,"BASS_Update")
        If pFunc Then
            Return pFunc(nLength)
        End If
    End If
End Function

'declare function BASS_GetCPU alias "BASS_GetCPU"() as float
Function clsBass.GetCPU() as float 
    If m_pDll Then
        Dim pFunc as Function() as float 
        pFunc = DyLibSymbol(m_pDll ,"BASS_GetCPU")
        If pFunc Then
            Return pFunc()
        End If
    End If
End Function

'declare function BASS_Start alias "BASS_Start"() as BOOL 
Function clsBass.Start() as Boolean 
    If m_pDll Then
        Dim pFunc as Function() as BOOL 
        pFunc = DyLibSymbol(m_pDll ,"BASS_Start")
        If pFunc Then
            Return pFunc()
        End If
    End If
End Function

'declare function BASS_Stop alias "BASS_Stop"() as BOOL
Function clsBass.Stop() as Boolean 
    If m_pDll Then
        Dim pFunc as Function() as BOOL 
        pFunc = DyLibSymbol(m_pDll ,"BASS_Stop")
        If pFunc Then
            Return pFunc()
        End If
    End If
End Function

'declare function BASS_Pause alias "BASS_Pause"() as BOOL
Function clsBass.Pause() as Boolean 
    If m_pDll Then
        Dim pFunc as Function() as BOOL 
        pFunc = DyLibSymbol(m_pDll ,"BASS_Pause")
        If pFunc Then
            Return pFunc()
        End If
    End If
End Function

'declare function BASS_SetVolume alias "BASS_SetVolume"(byval volume as float ) as BOOL
Function clsBass.SetVolume(ByVal volume as float) as Boolean 
    If m_pDll Then
        Dim pFunc as Function(ByVal as float) as BOOL 
        pFunc = DyLibSymbol(m_pDll ,"BASS_SetVolume")
        If pFunc Then
            Return pFunc(volume)
        End If
    End If
End Function

'declare function BASS_GetVolume alias "BASS_GetVolume"() as float
Function clsBass.GetVolume() as float 
    If m_pDll Then
        Dim pFunc as Function() as float
        pFunc = DyLibSymbol(m_pDll ,"BASS_GetVolume")
        If pFunc Then
            Return pFunc()
        End If
    End If
End Function

'declare function BASS_PluginLoad alias "BASS_PluginLoad"(byval file as const any ptr, byval flags as DWORD) as HPLUGIN
Function clsBass.PluginLoad(ByVal pFile as Const Any Ptr ,ByVal nFlags as DWORD) as HPLUGIN 
    If m_pDll Then
        Dim pFunc as Function(ByVal as Const Any Ptr,ByVal as DWORD) as HPLUGIN 
        pFunc = DyLibSymbol(m_pDll ,"BASS_PluginLoad")
        If pFunc Then
            Return pFunc(pFile,nFlags)
        End If
    End If
End Function

'declare function BASS_PluginFree alias "BASS_PluginFree"(byval handle as HPLUGIN) as BOOL
Function clsBass.PluginFree(ByVal nHandle as HPLUGIN) as Boolean 
    If m_pDll Then
        Dim pFunc as Function(ByVal as HPLUGIN) as BOOL 
        pFunc = DyLibSymbol(m_pDll ,"BASS_SetVolume")
        If pFunc Then
            Return pFunc(nHandle)
        End If
    End If
End Function

'declare function BASS_PluginGetInfo alias "BASS_PluginGetInfo"(byval handle as HPLUGIN) as const BASS_PLUGININFO ptr
Function clsBass.PluginGetInfo(ByVal nHandle as HPLUGIN) as Const BASS_PLUGININFO Ptr 
    If m_pDll Then
        Dim pFunc as Function(ByVal as HPLUGIN) as Const BASS_PLUGININFO Ptr 
        pFunc = DyLibSymbol(m_pDll ,"BASS_PluginGetInfo")
        If pFunc Then
            Return pFunc(nHandle)
        End If
    End If
End Function

'declare function BASS_Set3DFactors alias "BASS_Set3DFactors"(byval distf as FLOAT, byval rollf as float, byval doppf as float ) as BOOL
Function clsBass.Set3DFactors(ByVal distf as float ,ByVal rollf as float ,ByVal doppf as float) as Boolean
    If m_pDll Then
        Dim pFunc as Function(ByVal as float,ByVal as float,ByVal as float) as BOOL  
        pFunc = DyLibSymbol(m_pDll ,"BASS_Set3DFactors")
        If pFunc Then
            Return pFunc(distf,rollf,doppf)
        End If
    End If
End Function

'declare function BASS_Get3DFactors alias "BASS_Get3DFactors"(byval distf as float ptr, byval rollf as float ptr, byval doppf as float ptr) as BOOL
Function clsBass.Get3DFactors(ByVal distf as float Ptr ,ByVal rollf as float Ptr ,ByVal doppf as float Ptr) as Boolean
    If m_pDll Then
        Dim pFunc as Function(ByVal as float Ptr,ByVal as float Ptr,ByVal as float Ptr) as BOOL  
        pFunc = DyLibSymbol(m_pDll ,"BASS_Get3DFactors")
        If pFunc Then
            Return pFunc(distf,rollf,doppf)
        End If
    End If
End Function

'declare function BASS_Set3DPosition alias "BASS_Set3DPosition"(byval pos as const BASS_3DVECTOR ptr, byval vel as const BASS_3DVECTOR ptr, byval front as const BASS_3DVECTOR ptr, byval top as const BASS_3DVECTOR ptr) as BOOL
Function clsBass.Set3DPosition(ByVal nPos as Const BASS_3DVECTOR Ptr ,ByVal vel as Const BASS_3DVECTOR Ptr ,ByVal front as Const BASS_3DVECTOR Ptr ,ByVal top as Const BASS_3DVECTOR Ptr) as Boolean
    If m_pDll Then
        Dim pFunc as Function(ByVal as Const BASS_3DVECTOR Ptr,ByVal as Const BASS_3DVECTOR Ptr,ByVal as Const BASS_3DVECTOR Ptr,ByVal as Const BASS_3DVECTOR Ptr) as BOOL  
        pFunc = DyLibSymbol(m_pDll ,"BASS_Set3DPosition")
        If pFunc Then
            Return pFunc(nPos,vel,front,top)
        End If
    End If
End Function

'declare function BASS_Get3DPosition alias "BASS_Get3DPosition"(byval pos as BASS_3DVECTOR ptr, byval vel as BASS_3DVECTOR ptr, byval front as BASS_3DVECTOR ptr, byval top as BASS_3DVECTOR ptr) as BOOL                                                        
Function clsBass.Get3DPosition(ByVal nPos As BASS_3DVECTOR Ptr ,ByVal vel As BASS_3DVECTOR Ptr ,ByVal front As BASS_3DVECTOR Ptr ,ByVal top As BASS_3DVECTOR Ptr) As Boolean
    If m_pDll Then
        Dim pFunc as Function(ByVal as Const BASS_3DVECTOR Ptr,ByVal as Const BASS_3DVECTOR Ptr,ByVal as Const BASS_3DVECTOR Ptr,ByVal as Const BASS_3DVECTOR Ptr) as BOOL  
        pFunc = DyLibSymbol(m_pDll ,"BASS_Get3DPosition")
        If pFunc Then
            Return pFunc(nPos,vel,front,top)
        End If
    End If
End Function

'declare sub  BASS_Apply3D alias "BASS_Apply3D"()
Sub clsBass.Apply3D() 
    If m_pDll Then
        Dim pFunc as Sub() 
        pFunc = DyLibSymbol(m_pDll ,"BASS_Apply3D")
        If pFunc Then
            pFunc()
        End If
    End If 
End Sub

#ifdef __FB_WIN32__
'declare function BASS_SetEAXParameters alias "BASS_SetEAXParameters"(byval env as integer, byval vol as float, byval decay as float, byval damp as float) as BOOL
Function clsBass.SetEAXParameters(ByVal env as Integer,ByVal vol as float,ByVal decay as float,ByVal damp as float) as Boolean
    If m_pDll Then
        Dim pFunc as Function(ByVal as Integer,ByVal as float,ByVal as float,ByVal as float) as BOOL  
        pFunc = DyLibSymbol(m_pDll ,"BASS_SetEAXParameters")
        If pFunc Then
            Return pFunc(env,vol,decay,damp)
        End If
    End If
End Function

'declare function BASS_GetEAXParameters alias "BASS_GetEAXParameters"(byval env as DWORD ptr, byval vol as float ptr, byval decay as float ptr, byval damp as float ptr) as BOOL
Function clsBass.GetEAXParameters(ByVal env as DWORD Ptr ,ByVal vol as float Ptr ,ByVal decay as float Ptr ,ByVal damp as float Ptr) as Boolean
    If m_pDll Then
        Dim pFunc as Function(ByVal as DWORD Ptr,ByVal as float Ptr,ByVal as float Ptr,ByVal as float Ptr) as BOOL  
        pFunc = DyLibSymbol(m_pDll ,"BASS_GetEAXParameters")
        If pFunc Then
            Return pFunc(env,vol,decay,damp)
        End If
    End If 
End Function
#endif

'declare function BASS_MusicLoad alias "BASS_MusicLoad"(byval mem as BOOL, byval file as const any ptr, byval offset as QWORD, byval length as DWORD, byval flags as DWORD, byval freq as DWORD) as HMUSIC
Function clsBass.MusicLoad(ByVal mem as BOOL ,ByVal pFile as Const Any Ptr ,ByVal offset as QWORD ,ByVal length as DWORD ,ByVal nFlags as DWORD ,ByVal freq as DWORD) as HMUSIC
    If m_pDll Then
        Dim pFunc as Function(ByVal as BOOL,ByVal as Const Any Ptr,ByVal as QWORD,ByVal as DWORD,ByVal as DWORD,ByVal as DWORD) as HMUSIC  
        pFunc = DyLibSymbol(m_pDll ,"BASS_MusicLoad")
        If pFunc Then
            Return pFunc(mem,pFile,offset,length,nFlags,freq)
        End If
    End If 
End Function

'declare function BASS_MusicFree alias "BASS_MusicFree"(byval handle as HMUSIC) as BOOL
Function clsBass.MusicFree(ByVal nHandle as HMUSIC) as Boolean
    If m_pDll Then
        Dim pFunc as Function(ByVal as HMUSIC) as BOOL  
        pFunc = DyLibSymbol(m_pDll ,"BASS_MusicFree")
        If pFunc Then
            Return pFunc(nHandle)
        End If
    End If 
End Function

'declare function BASS_SampleLoad alias "BASS_SampleLoad"(byval mem as BOOL, byval file as const any ptr, byval offset as QWORD, byval length as DWORD, byval max as DWORD , byval flags as DWORD) as HSAMPLE
Function clsBass.SampleLoad(ByVal mem as BOOL ,ByVal pFile as Const Any Ptr ,ByVal offset as QWORD ,ByVal length as DWORD ,ByVal max as DWORD ,ByVal nFlags as DWORD) as HSAMPLE  
    If m_pDll Then
        Dim pFunc as Function(ByVal as BOOL,ByVal as Const Any Ptr,ByVal as QWORD,ByVal as DWORD,ByVal as DWORD,ByVal as DWORD) as HSAMPLE  
        pFunc = DyLibSymbol(m_pDll ,"BASS_SampleLoad")
        If pFunc Then
            Return pFunc(mem,pFile,offset,length,max,nFlags)
        End If
    End If 
End Function

'declare function BASS_SampleCreate alias "BASS_SampleCreate"(byval length as DWORD, byval freq as DWORD, byval chans as DWORD , byval max as DWORD, byval flags as DWORD) as HSAMPLE
Function clsBass.SampleCreate(ByVal length as DWORD ,ByVal freq as DWORD ,ByVal chans as DWORD ,ByVal max as DWORD ,ByVal nFlags as DWORD) as HSAMPLE
    If m_pDll Then
        Dim pFunc as Function(ByVal as DWORD,ByVal as DWORD,ByVal as DWORD,ByVal as DWORD,ByVal as DWORD) as HSAMPLE  
        pFunc = DyLibSymbol(m_pDll ,"BASS_SampleCreate")
        If pFunc Then
            Return pFunc(length,freq,chans,max,nFlags)
        End If
    End If 
End Function

'declare function BASS_SampleFree alias "BASS_SampleFree"(byval handle as HSAMPLE) as BOOL
Function clsBass.SampleFree(ByVal nHandle as HSAMPLE) as Boolean
    If m_pDll Then
        Dim pFunc as Function(ByVal as HSAMPLE) as BOOL  
        pFunc = DyLibSymbol(m_pDll ,"BASS_SampleFree")
        If pFunc Then
            Return pFunc(nHandle)
        End If
    End If 
End Function

'declare function BASS_SampleSetData alias "BASS_SampleSetData"(byval handle as HSAMPLE , byval buffer as const any ptr) as BOOL
Function clsBass.SampleSetData(ByVal nHandle as HSAMPLE ,ByVal buffer as Const Any Ptr) as Boolean
    If m_pDll Then
        Dim pFunc as Function(ByVal as HSAMPLE,ByVal as Const Any Ptr) as BOOL  
        pFunc = DyLibSymbol(m_pDll ,"BASS_SampleSetData")
        If pFunc Then
            Return pFunc(nHandle,buffer)
        End If
    End If 
End Function

'declare function BASS_SampleGetData alias "BASS_SampleGetData"(byval handle as HSAMPLE, byval buffer as any ptr) as BOOL
Function clsBass.SampleGetData(ByVal nHandle As HSAMPLE ,ByVal buffer As Any Ptr) As Boolean
    If m_pDll Then
        Dim pFunc as Function(ByVal as HSAMPLE,ByVal as Const Any Ptr) as BOOL  
        pFunc = DyLibSymbol(m_pDll ,"BASS_SampleGetData")
        If pFunc Then
            Return pFunc(nHandle,buffer)
        End If
    End If
End Function

'declare function BASS_SampleGetInfo alias "BASS_SampleGetInfo"(byval handle as HSAMPLE, byval info as BASS_SAMPLE ptr) as BOOL 
Function clsBass.SampleGetInfo(ByVal nHandle as HSAMPLE ,ByVal info as BASS_SAMPLE Ptr) as BOOLEAN 
    If m_pDll Then
        Dim pFunc as Function(ByVal as HSAMPLE,ByVal as BASS_SAMPLE Ptr) as BOOL  
        pFunc = DyLibSymbol(m_pDll ,"BASS_SampleGetInfo")
        If pFunc Then
            Return pFunc(nHandle,info)
        End If
    End If
End Function

'declare function BASS_SampleSetInfo alias "BASS_SampleSetInfo"(byval handle as HSAMPLE, byval info as const BASS_SAMPLE ptr) as BOOL
Function clsBass.SampleSetInfo(ByVal nHandle as HSAMPLE ,ByVal info as Const BASS_SAMPLE Ptr) as Boolean
    If m_pDll Then
        Dim pFunc as Function(ByVal as HSAMPLE,ByVal As Const BASS_SAMPLE Ptr) as BOOL  
        pFunc = DyLibSymbol(m_pDll ,"BASS_SampleSetInfo")
        If pFunc Then
            Return pFunc(nHandle,info)
        End If
    End If
End Function

'declare function BASS_SampleGetChannel alias "BASS_SampleGetChannel"(byval handle as HSAMPLE, byval onlynew as BOOL) as HCHANNEL
Function clsBass.SampleGetChannel(ByVal nHandle as HSAMPLE ,ByVal onlynew as BOOL) as HCHANNEL 
    If m_pDll Then
        Dim pFunc as Function(ByVal as HSAMPLE,ByVal as BOOL) as HCHANNEL  
        pFunc = DyLibSymbol(m_pDll ,"BASS_SampleGetChannel")
        If pFunc Then
            Return pFunc(nHandle,onlynew)
        End If
    End If
End Function

'declare function BASS_SampleGetChannels alias "BASS_SampleGetChannels"(byval handle as HSAMPLE, byval channels as HCHANNEL ptr) as DWORD
Function clsBass.SampleGetChannels(ByVal nHandle as HSAMPLE ,ByVal channels as HCHANNEL Ptr) as DWORD
    If m_pDll Then
        Dim pFunc as Function(ByVal as HSAMPLE,ByVal as HCHANNEL Ptr) as DWORD 
        pFunc = DyLibSymbol(m_pDll ,"BASS_SampleGetChannels")
        If pFunc Then
            Return pFunc(nHandle,channels)
        End If
    End If
End Function

'declare function BASS_SampleStop alias "BASS_SampleStop"(byval handle as HSAMPLE) as BOOL
Function clsBass.SampleStop(ByVal nHandle As HSAMPLE) As Boolean
    If m_pDll Then
        Dim pFunc as Function(ByVal as HSAMPLE) as BOOL 
        pFunc = DyLibSymbol(m_pDll ,"BASS_SampleStop")
        If pFunc Then
            Return pFunc(nHandle)
        End If
    End If
End Function

'declare function BASS_StreamCreate alias "BASS_StreamCreate"(byval freq as DWORD, byval chans as DWORD, byval flags as DWORD , byval proc as STREAMPROC ptr, byval user as any ptr) as HSTREAM
Function clsBass.StreamCreate(ByVal freq as DWORD ,ByVal chans as DWORD ,ByVal nFlags as DWORD ,ByVal pProc as STREAMPROC Ptr ,ByVal user as Any Ptr) as HSTREAM
    If m_pDll Then
        Dim pFunc as Function(ByVal as DWORD,ByVal as DWORD,ByVal as DWORD,ByVal as STREAMPROC Ptr,ByVal as Any Ptr) as HSTREAM  
        pFunc = DyLibSymbol(m_pDll ,"BASS_StreamCreate")
        If pFunc Then
            Return pFunc(freq,chans,nFlags,pProc,user)
        End If
    End If
End Function

'declare function BASS_StreamCreateFile alias "BASS_StreamCreateFile"(byval mem as BOOL , byval file as any ptr, byval offset as QWORD, byval length as QWORD, byval flags as DWORD ) as HSTREAM
Function clsBass.StreamCreateFile(ByVal mem as BOOL ,ByVal pFile as Any Ptr ,ByVal offset as QWORD ,ByVal length as QWORD ,ByVal nFlags as DWORD) as HSTREAM
    If m_pDll Then
        Dim pFunc as Function(ByVal as BOOL,ByVal as Any Ptr,ByVal as QWORD,ByVal as QWORD,ByVal as DWORD) as HSTREAM  
        pFunc = DyLibSymbol(m_pDll ,"BASS_StreamCreateFile")
        If pFunc Then
            Return pFunc(mem,pFile,offset,length,nFlags)
        End If
    End If
End Function

'declare function BASS_StreamCreateURL alias "BASS_StreamCreateURL"(byval url as zstring ptr, byval offset as DWORD, byval flags as DWORD, byval proc as DOWNLOADPROC ptr, byval user as any ptr) as HSTREAM 
Function clsBass.StreamCreateURL(ByVal url as ZString Ptr ,ByVal offset as DWORD ,ByVal nFlags as DWORD ,ByVal pProc as DOWNLOADPROC Ptr ,ByVal user as Any Ptr) as HSTREAM 
    If m_pDll Then
        Dim pFunc as Function(ByVal as ZString Ptr,ByVal as DWORD,ByVal as DWORD,ByVal as DOWNLOADPROC Ptr,ByVal as Any Ptr) as HSTREAM  
        pFunc = DyLibSymbol(m_pDll ,"BASS_StreamCreateURL")
        If pFunc Then
            Return pFunc(url,offset,nFlags,pProc,user)
        End If
    End If
End Function

'declare function BASS_StreamCreateFileUser alias "BASS_StreamCreateFileUser"(byval system as DWORD, byval flags as DWORD, byval proc as const BASS_FILEPROCS ptr, byval user as any ptr) as HSTREAM
Function clsBass.StreamCreateFileUser(ByVal nSystem as DWORD ,ByVal nFlags as DWORD ,ByVal pProc as Const BASS_FILEPROCS Ptr ,ByVal user as Any Ptr) as HSTREAM
    If m_pDll Then
        Dim pFunc as Function(ByVal as DWORD,ByVal as DWORD,ByVal as Const BASS_FILEPROCS Ptr,ByVal as Any Ptr) as HSTREAM  
        pFunc = DyLibSymbol(m_pDll ,"BASS_StreamCreateFileUser")
        If pFunc Then
            Return pFunc(nSystem,nFlags,pProc,user)
        End If
    End If
End Function

'declare function BASS_StreamFree alias "BASS_StreamFree"(byval handle as HSTREAM) as BOOL
Function clsBass.StreamFree(ByVal nHandle as HSTREAM) as Boolean
    If m_pDll Then
        Dim pFunc as Function(ByVal as HSTREAM) as BOOL  
        pFunc = DyLibSymbol(m_pDll ,"BASS_StreamFree")
        If pFunc Then
            Return pFunc(nHandle)
        End If
    End If
End Function

'declare function BASS_StreamGetFilePosition alias "BASS_StreamGetFilePosition"(byval handle as HSTREAM, byval mode as DWORD) as QWORD
Function clsBass.StreamGetFilePosition(ByVal nHandle as HSTREAM ,ByVal mode as DWORD) as QWORD
    If m_pDll Then
        Dim pFunc as Function(ByVal as HSTREAM,ByVal as DWORD) as QWORD 
        pFunc = DyLibSymbol(m_pDll ,"BASS_StreamGetFilePosition")
        If pFunc Then
            Return pFunc(nHandle,mode)
        End If
    End If
End Function

'declare function BASS_StreamPutData alias "BASS_StreamPutData"(byval handle as HSTREAM, byval buffer as any ptr, byval length as DWORD) as DWORD
Function clsBass.StreamPutData(ByVal nHandle as HSTREAM ,ByVal buffer as Any Ptr ,ByVal length as DWORD) as DWORD
    If m_pDll Then
        Dim pFunc as Function(ByVal as HSTREAM,ByVal as Any Ptr,ByVal as DWORD) as DWORD 
        pFunc = DyLibSymbol(m_pDll ,"BASS_StreamPutData")
        If pFunc Then
            Return pFunc(nHandle,buffer,length)
        End If
    End If
End Function

'declare function BASS_StreamPutFileData alias "BASS_StreamPutFileData"(byval handle as HSTREAM, byval buffer as const any ptr, byval length as DWORD) as DWORD
Function clsBass.StreamPutFileData(ByVal nHandle as HSTREAM ,ByVal buffer as Const Any Ptr ,ByVal length as DWORD) as DWORD
    If m_pDll Then
        Dim pFunc as Function(ByVal as HSTREAM,ByVal as Const Any Ptr,ByVal as DWORD) as DWORD 
        pFunc = DyLibSymbol(m_pDll ,"BASS_StreamPutFileData")
        If pFunc Then
            Return pFunc(nHandle,buffer,length)
        End If
    End If
End Function

'declare function BASS_RecordGetDeviceInfo alias "BASS_RecordGetDeviceInfo"(byval device as DWORD , byval info as BASS_DEVICEINFO ptr) as BOOL
Function clsBass.RecordGetDeviceInfo(ByVal nDevice As DWORD ,ByVal info As BASS_DEVICEINFO Ptr) As Boolean
    If m_pDll Then
        Dim pFunc as Function(ByVal as DWORD,ByVal as BASS_DEVICEINFO Ptr) as BOOL 
        pFunc = DyLibSymbol(m_pDll ,"BASS_RecordGetDeviceInfo")
        If pFunc Then
            Return pFunc(nDevice,info)
        End If
    End If
End Function

'declare function BASS_RecordInit alias "BASS_RecordInit"(byval device as integer) as BOOL
Function clsBass.RecordInit(ByVal nDevice as Integer) as Boolean
    If m_pDll Then
        Dim pFunc as Function(ByVal as Integer) as BOOL 
        pFunc = DyLibSymbol(m_pDll ,"BASS_RecordInit")
        If pFunc Then
            Return pFunc(nDevice)
        End If
    End If
End Function

'declare function BASS_RecordSetDevice alias "BASS_RecordSetDevice"(byval device as DWORD) as BOOL
Function clsBass.RecordSetDevice(ByVal nDevice As DWORD) As Boolean
    If m_pDll Then
        Dim pFunc as Function(ByVal as Integer) as BOOL 
        pFunc = DyLibSymbol(m_pDll ,"BASS_RecordSetDevice")
        If pFunc Then
            Return pFunc(nDevice)
        End If
    End If
End Function

'declare function BASS_RecordGetDevice alias "BASS_RecordGetDevice"() as DWORD 
Function clsBass.RecordGetDevice() as DWORD
    If m_pDll Then
        Dim pFunc as Function() as DWORD 
        pFunc = DyLibSymbol(m_pDll ,"BASS_RecordGetDevice")
        If pFunc Then
            Return pFunc()
        End If
    End If 
End Function

'declare function BASS_RecordFree alias "BASS_RecordFree"() as BOOL
Function clsBass.RecordFree() As Boolean
    If m_pDll Then
        Dim pFunc as Function() as BOOL 
        pFunc = DyLibSymbol(m_pDll ,"BASS_RecordFree")
        If pFunc Then
            Return pFunc()
        End If
    End If 
End Function

'declare function BASS_RecordGetInfo alias "BASS_RecordGetInfo"(byval info as BASS_RECORDINFO ptr) as BOOL
Function clsBass.RecordGetInfo(ByVal info as BASS_RECORDINFO Ptr) as Boolean
    If m_pDll Then
        Dim pFunc as Function(ByVal as BASS_RECORDINFO Ptr) as BOOL 
        pFunc = DyLibSymbol(m_pDll ,"BASS_RecordGetInfo")
        If pFunc Then
            Return pFunc(info)
        End If
    End If
End Function

'declare function BASS_RecordGetInputName alias "BASS_RecordGetInputName"(byval input as integer) as zstring ptr
Function clsBass.RecordGetInputName(ByVal nInput as Integer) as ZString Ptr
    If m_pDll Then
        Dim pFunc as Function(ByVal as Integer) as ZString Ptr 
        pFunc = DyLibSymbol(m_pDll ,"BASS_RecordGetInputName")
        If pFunc Then
            Return pFunc(nInput)
        End If
    End If
End Function

'declare function BASS_RecordSetInput alias "BASS_RecordSetInput"(byval input as integer, byval flags as DWORD, byval volume as float) as BOOL
Function clsBass.RecordSetInput(ByVal nInput as Integer ,ByVal nFlags as DWORD ,ByVal volume as float) as Boolean
    If m_pDll Then
        Dim pFunc as Function(ByVal as Integer,ByVal as DWORD,ByVal as float) as BOOL
        pFunc = DyLibSymbol(m_pDll ,"BASS_RecordSetInput")
        If pFunc Then
            Return pFunc(nInput,nFlags,volume)
        End If
    End If
End Function

'declare function BASS_RecordGetInput alias "BASS_RecordGetInput"(byval input as integer, byval volume as float ptr) as DWORD
Function clsBass.RecordGetInput(ByVal nInput as Integer ,ByVal volume as float Ptr) as DWORD
    If m_pDll Then
        Dim pFunc as Function(ByVal as Integer,ByVal as float Ptr) as DWORD
        pFunc = DyLibSymbol(m_pDll ,"BASS_RecordGetInput")
        If pFunc Then
            Return pFunc(nInput,volume)
        End If
    End If
End Function

'declare function BASS_RecordStart alias "BASS_RecordStart"(byval freq as DWORD, byval chans as DWORD, byval flags as DWORD, byval proc as RECORDPROC ptr, byval user as any ptr) as HRECORD
Function clsBass.RecordStart(ByVal freq as DWORD ,ByVal chans as DWORD ,ByVal nFlags as DWORD ,ByVal pProc as RECORDPROC Ptr ,ByVal user as Any Ptr) as HRECORD
    If m_pDll Then
        Dim pFunc as Function(ByVal as DWORD,ByVal as DWORD,ByVal as DWORD,ByVal as RECORDPROC Ptr,ByVal as Any Ptr) as HRECORD
        pFunc = DyLibSymbol(m_pDll ,"BASS_RecordStart")
        If pFunc Then
            Return pFunc(freq,chans,nFlags,pProc,user)
        End If
    End If
End Function

'declare function BASS_ChannelBytes2Seconds alias "BASS_ChannelBytes2Seconds"(byval handle as DWORD , byval pos as QWORD) as double
Function clsBass.ChannelBytes2Seconds(ByVal nHandle as DWORD ,ByVal nPos as QWORD) as Double
    If m_pDll Then
        Dim pFunc as Function(ByVal as DWORD,ByVal as QWORD) as Double
        pFunc = DyLibSymbol(m_pDll ,"BASS_ChannelBytes2Seconds")
        If pFunc Then
            Return pFunc(nHandle,nPos)
        End If
    End If
End Function

'declare function BASS_ChannelSeconds2Bytes alias "BASS_ChannelSeconds2Bytes"(byval handle as DWORD, byval pos as double) as QWORD
Function clsBass.ChannelSeconds2Bytes(ByVal nHandle as DWORD ,ByVal nPos as Double) as QWORD
    If m_pDll Then
        Dim pFunc as Function(ByVal as DWORD,ByVal as Double) as QWORD
        pFunc = DyLibSymbol(m_pDll ,"BASS_ChannelSeconds2Bytes")
        If pFunc Then
            Return pFunc(nHandle,nPos)
        End If
    End If
End Function

'declare function BASS_ChannelGetDevice alias "BASS_ChannelGetDevice"(byval handle as DWORD) as DWORD
Function clsBass.ChannelGetDevice(ByVal nHandle as DWORD) as DWORD
    If m_pDll Then
        Dim pFunc as Function(ByVal as DWORD) as DWORD
        pFunc = DyLibSymbol(m_pDll ,"BASS_ChannelGetDevice")
        If pFunc Then
            Return pFunc(nHandle)
        End If
    End If
End Function

'declare function BASS_ChannelSetDevice alias "BASS_ChannelSetDevice"(byval handle as DWORD, byval device as DWORD) as BOOL
Function clsBass.ChannelSetDevice(ByVal nHandle as DWORD ,ByVal nDevice as DWORD) as Boolean
    If m_pDll Then
        Dim pFunc as Function(ByVal as DWORD,ByVal as DWORD) as BOOL
        pFunc = DyLibSymbol(m_pDll ,"BASS_ChannelSetDevice")
        If pFunc Then
            Return pFunc(nHandle,nDevice)
        End If
    End If
End Function

'declare function BASS_ChannelIsActive alias "BASS_ChannelIsActive"(byval handle as DWORD) as DWORD
Function clsBass.ChannelIsActive(ByVal nHandle As DWORD) As DWORD
    If m_pDll Then
        Dim pFunc as Function(ByVal as DWORD) as DWORD
        pFunc = DyLibSymbol(m_pDll ,"BASS_ChannelIsActive")
        If pFunc Then
            Return pFunc(nHandle)
        End If
    End If 
End Function

'declare function BASS_ChannelGetInfo alias "BASS_ChannelGetInfo"(byval handle as DWORD, byval info as BASS_CHANNELINFO ptr) as BOOL
Function clsBass.ChannelGetInfo(ByVal nHandle as DWORD ,ByVal info as BASS_CHANNELINFO Ptr) as Boolean
    If m_pDll Then
        Dim pFunc as Function(ByVal as DWORD,ByVal as BASS_CHANNELINFO Ptr) as BOOL
        pFunc = DyLibSymbol(m_pDll ,"BASS_ChannelGetInfo")
        If pFunc Then
            Return pFunc(nHandle,info)
        End If
    End If 
End Function

'declare function BASS_ChannelGetTags alias "BASS_ChannelGetTags"(byval handle as DWORD, byval tags as DWORD) as zstring ptr
Function clsBass.ChannelGetTags(ByVal nHandle as DWORD ,ByVal tags as DWORD) as ZString Ptr
    If m_pDll Then
        Dim pFunc as Function(ByVal as DWORD,ByVal as DWORD) as ZString Ptr
        pFunc = DyLibSymbol(m_pDll ,"BASS_ChannelGetTags")
        If pFunc Then
            Return pFunc(nHandle,tags)
        End If
    End If 
End Function

'declare function BASS_ChannelFlags alias "BASS_ChannelFlags"(byval handle as DWORD, byval flags as DWORD, byval mask as DWORD) as DWORD
Function clsBass.ChannelFlags(ByVal nHandle as DWORD ,ByVal nFlags as DWORD ,ByVal mask as DWORD) as DWORD
    If m_pDll Then
        Dim pFunc as Function(ByVal as DWORD,ByVal as DWORD,ByVal as DWORD) as DWORD
        pFunc = DyLibSymbol(m_pDll ,"BASS_ChannelFlags")
        If pFunc Then
            Return pFunc(nHandle,nFlags,mask)
        End If
    End If 
End Function

'declare function BASS_ChannelUpdate alias "BASS_ChannelUpdate"(byval handle as DWORD, byval length as DWORD) as BOOL
Function clsBass.ChannelUpdate(ByVal nHandle as DWORD ,ByVal length as DWORD) as Boolean
    If m_pDll Then
        Dim pFunc as Function(ByVal as DWORD,ByVal as DWORD) as BOOL
        pFunc = DyLibSymbol(m_pDll ,"BASS_ChannelUpdate")
        If pFunc Then
            Return pFunc(nHandle,length)
        End If
    End If 
End Function

'declare function BASS_ChannelLock alias "BASS_ChannelLock"(byval handle as DWORD, byval lock as BOOL) as BOOL
Function clsBass.ChannelLock(ByVal nHandle as DWORD ,ByVal nLock as BOOL) as Boolean
    If m_pDll Then
        Dim pFunc as Function(ByVal as DWORD,ByVal as BOOL) as BOOL
        pFunc = DyLibSymbol(m_pDll ,"BASS_ChannelLock")
        If pFunc Then
            Return pFunc(nHandle,nLock)
        End If
    End If 
End Function

'declare function BASS_ChannelPlay alias "BASS_ChannelPlay"(byval handle as DWORD, byval restart as BOOL) as BOOL
Function clsBass.ChannelPlay(ByVal nHandle as DWORD ,ByVal restart as BOOL) as Boolean
    If m_pDll Then
        Dim pFunc as Function(ByVal as DWORD,ByVal as BOOL) as BOOL  
        pFunc = DyLibSymbol(m_pDll ,"BASS_ChannelPlay")
        If pFunc Then
            Return pFunc(nHandle,restart)
        End If
    End If    
End Function

'declare function BASS_ChannelStop alias "BASS_ChannelStop"(byval handle as DWORD) as BOOL
Function clsBass.ChannelStop(ByVal nHandle As DWORD) As Boolean
    If m_pDll Then
        Dim pFunc as Function(ByVal as DWORD) as BOOL  
        pFunc = DyLibSymbol(m_pDll ,"BASS_ChannelStop")
        If pFunc Then
            Return pFunc(nHandle)
        End If
    End If  
End Function

'declare function BASS_ChannelPause alias "BASS_ChannelPause"(byval handle as DWORD) as BOOL
Function clsBass.ChannelPause(ByVal nHandle As DWORD) As Boolean
    If m_pDll Then
        Dim pFunc as Function(ByVal as DWORD) as BOOL  
        pFunc = DyLibSymbol(m_pDll ,"BASS_ChannelPause")
        If pFunc Then
            Return pFunc(nHandle)
        End If
    End If 
End Function

'declare function BASS_ChannelSetAttribute alias "BASS_ChannelSetAttribute"(byval handle as DWORD, byval attrib as DWORD, byval value as float) as BOOL
Function clsBass.ChannelSetAttribute(ByVal nHandle as DWORD ,ByVal attrib as DWORD ,ByVal nValue as float) as Boolean
    If m_pDll Then
        Dim pFunc as Function(ByVal as DWORD,ByVal as DWORD,ByVal as float) as BOOL
        pFunc = DyLibSymbol(m_pDll ,"BASS_ChannelSetAttribute")
        If pFunc Then
            Return pFunc(nHandle,attrib,nValue)
        End If
    End If 
End Function

'declare function BASS_ChannelGetAttribute alias "BASS_ChannelGetAttribute"(byval handle as DWORD, byval attrib as DWORD, byval value as float ptr) as BOOL
Function clsBass.ChannelGetAttribute(ByVal nHandle as DWORD ,ByVal attrib as DWORD ,ByVal nValue as float Ptr) as Boolean
    If m_pDll Then
        Dim pFunc as Function(ByVal as DWORD,ByVal as DWORD,ByVal as float Ptr) as BOOL
        pFunc = DyLibSymbol(m_pDll ,"BASS_ChannelGetAttribute")
        If pFunc Then
            Return pFunc(nHandle,attrib,nValue)
        End If
    End If 
End Function

'declare function BASS_ChannelSlideAttribute alias "BASS_ChannelSlideAttribute"(byval handle as DWORD, byval attrib as DWORD, byval value as float, byval time as DWORD) as BOOL
Function clsBass.ChannelSlideAttribute(ByVal nHandle as DWORD ,ByVal attrib as DWORD ,ByVal nValue as float ,ByVal nTime as DWORD) as Boolean
    If m_pDll Then
        Dim pFunc as Function(ByVal as DWORD,ByVal as DWORD,ByVal as float,ByVal as DWORD) as BOOL
        pFunc = DyLibSymbol(m_pDll ,"BASS_ChannelSlideAttribute")
        If pFunc Then
            Return pFunc(nHandle,attrib,nValue,nTime)
        End If
    End If 
End Function

'declare function BASS_ChannelIsSliding alias "BASS_ChannelIsSliding"(byval handle as DWORD, byval attrib as DWORD) as BOOL
Function clsBass.ChannelIsSliding(ByVal nHandle As DWORD ,ByVal attrib As DWORD) As Boolean
    If m_pDll Then
        Dim pFunc as Function(ByVal as DWORD,ByVal as DWORD) as BOOL
        pFunc = DyLibSymbol(m_pDll ,"BASS_ChannelIsSliding")
        If pFunc Then
            Return pFunc(nHandle,attrib)
        End If
    End If 
End Function

'declare function BASS_ChannelSet3DAttributes alias "BASS_ChannelSet3DAttributes"(byval handle as DWORD, byval mode as integer, byval min as float, byval max as float, byval iangle as integer, byval oangle as integer, byval outvol as float) as BOOL
Function clsBass.ChannelSet3DAttributes(ByVal nHandle as DWORD ,ByVal mode as Integer ,ByVal min as float ,ByVal max as float ,ByVal iangle as Integer ,ByVal oangle as Integer ,ByVal outvol as float) as Boolean
    If m_pDll Then
        Dim pFunc as Function(ByVal as DWORD,ByVal as Integer,ByVal as float,ByVal as float,ByVal as Integer,ByVal as Integer,ByVal as float) as BOOL
        pFunc = DyLibSymbol(m_pDll ,"BASS_ChannelSet3DAttributes")
        If pFunc Then
            Return pFunc(nHandle,mode,min,max,iangle,oangle,outvol)
        End If
    End If 
End Function

'declare function BASS_ChannelGet3DAttributes alias "BASS_ChannelGet3DAttributes"(byval handle as DWORD, byval mode as DWORD ptr, byval min as float ptr, byval max as float ptr, byval iangle as DWORD ptr, byval oangle as DWORD ptr, byval outvol as float ptr) as BOOL
Function clsBass.ChannelGet3DAttributes(ByVal nHandle as DWORD ,ByVal mode as DWORD Ptr ,ByVal min as float Ptr ,ByVal max as float Ptr ,ByVal iangle as DWORD Ptr ,ByVal oangle as DWORD Ptr ,ByVal outvol as float Ptr) as Boolean
    If m_pDll Then
        Dim pFunc as Function(ByVal as DWORD ,ByVal as DWORD Ptr ,ByVal as float Ptr ,ByVal as float Ptr ,ByVal as DWORD Ptr ,ByVal as DWORD Ptr ,ByVal as float Ptr) as BOOL
        pFunc = DyLibSymbol(m_pDll ,"BASS_ChannelGet3DAttributes")
        If pFunc Then
            Return pFunc(nHandle,mode,min,max,iangle,oangle,outvol)
        End If
    End If 
End Function

'declare function BASS_ChannelSet3DPosition alias "BASS_ChannelSet3DPosition"(byval handle as DWORD, byval pos as const BASS_3DVECTOR ptr, byval orient as const BASS_3DVECTOR ptr, byval vel as const BASS_3DVECTOR ptr) as BOOL
Function clsBass.ChannelSet3DPosition(ByVal nHandle as DWORD ,ByVal nPos as Const BASS_3DVECTOR Ptr ,ByVal orient as Const BASS_3DVECTOR Ptr ,ByVal vel as Const BASS_3DVECTOR Ptr) as Boolean
    If m_pDll Then
        Dim pFunc as Function(ByVal as DWORD,ByVal as Const BASS_3DVECTOR Ptr,ByVal as Const BASS_3DVECTOR Ptr,ByVal as Const BASS_3DVECTOR Ptr) as BOOL
        pFunc = DyLibSymbol(m_pDll ,"BASS_ChannelSet3DPosition")
        If pFunc Then
            Return pFunc(nHandle,nPos,orient,vel)
        End If
    End If 
End Function

'declare function BASS_ChannelGet3DPosition alias "BASS_ChannelGet3DPosition"(byval handle as DWORD, byval pos as BASS_3DVECTOR ptr, byval orient as BASS_3DVECTOR ptr, byval vel as BASS_3DVECTOR ptr) as BOOL
Function clsBass.ChannelGet3DPosition(ByVal nHandle as DWORD ,ByVal nPos as BASS_3DVECTOR Ptr ,ByVal orient as BASS_3DVECTOR Ptr ,ByVal vel as BASS_3DVECTOR Ptr) as Boolean
    If m_pDll Then
        Dim pFunc as Function(ByVal as DWORD,ByVal as Const BASS_3DVECTOR Ptr,ByVal as Const BASS_3DVECTOR Ptr,ByVal as Const BASS_3DVECTOR Ptr) as BOOL
        pFunc = DyLibSymbol(m_pDll ,"BASS_ChannelGet3DPosition")
        If pFunc Then
            Return pFunc(nHandle,nPos,orient,vel)
        End If
    End If 
End Function

'declare function BASS_ChannelGetLength alias "BASS_ChannelGetLength"(byval handle as DWORD, byval mode as DWORD) as QWORD
Function clsBass.ChannelGetLength(ByVal nHandle as DWORD ,ByVal mode as DWORD) as QWORD
    If m_pDll Then
        Dim pFunc as Function(ByVal as DWORD,ByVal as DWORD) as QWORD
        pFunc = DyLibSymbol(m_pDll ,"BASS_ChannelGetLength")
        If pFunc Then
            Return pFunc(nHandle,mode)
        End If
    End If 
End Function

'declare function BASS_ChannelSetPosition alias "BASS_ChannelSetPosition"(byval handle as DWORD, byval pos as QWORD, byval mode as DWORD) as BOOL
Function clsBass.ChannelSetPosition(ByVal nHandle as DWORD ,ByVal nPos as QWORD ,ByVal mode as DWORD) as Boolean
    If m_pDll Then
        Dim pFunc as Function(ByVal as DWORD,ByVal as QWORD,ByVal as DWORD) as BOOL
        pFunc = DyLibSymbol(m_pDll ,"BASS_ChannelSetPosition")
        If pFunc Then
            Return pFunc(nHandle,nPos,mode)
        End If
    End If 
End Function

'declare function BASS_ChannelGetPosition alias "BASS_ChannelGetPosition"(byval handle as DWORD, byval mode as DWORD) as QWORD
Function clsBass.ChannelGetPosition(ByVal nHandle as DWORD ,ByVal mode as DWORD) as QWORD
    If m_pDll Then
        Dim pFunc as Function(ByVal as DWORD,ByVal as DWORD) as QWORD
        pFunc = DyLibSymbol(m_pDll ,"BASS_ChannelGetPosition")
        If pFunc Then
            Return pFunc(nHandle,mode)
        End If
    End If 
End Function

'declare function BASS_ChannelGetLevel alias "BASS_ChannelGetLevel"(byval handle as DWORD) as DWORD
Function clsBass.ChannelGetLevel(ByVal nHandle As DWORD) As DWORD
    If m_pDll Then
        Dim pFunc as Function(ByVal as DWORD) as DWORD
        pFunc = DyLibSymbol(m_pDll ,"BASS_ChannelGetLevel")
        If pFunc Then
            Return pFunc(nHandle)
        End If
    End If 
End Function

'declare function BASS_ChannelGetData alias "BASS_ChannelGetData"(byval handle as DWORD, byval buffer as any ptr, byval length as DWORD) as DWORD
Function clsBass.ChannelGetData(ByVal nHandle as DWORD ,ByVal buffer as Any Ptr ,ByVal length as DWORD) as DWORD
    If m_pDll Then
        Dim pFunc as Function(ByVal as DWORD,ByVal as Any Ptr,ByVal as DWORD) as DWORD
        pFunc = DyLibSymbol(m_pDll ,"BASS_ChannelGetData")
        If pFunc Then
            Return pFunc(nHandle,buffer,length)
        End If
    End If 
End Function

'declare function BASS_ChannelSetSync alias "BASS_ChannelSetSync"(byval handle as DWORD, byval type as DWORD, byval param as QWORD, byval proc as SYNCPROC ptr, byval user as any ptr) as HSYNC
Function clsBass.ChannelSetSync(ByVal nHandle as DWORD ,ByVal nType as DWORD ,ByVal param as QWORD ,ByVal pProc as SYNCPROC Ptr ,ByVal user as Any Ptr) as HSYNC
    If m_pDll Then
        Dim pFunc as Function(ByVal as DWORD,ByVal as DWORD,ByVal as QWORD,as SYNCPROC Ptr,ByVal as Any Ptr) as HSYNC
        pFunc = DyLibSymbol(m_pDll ,"BASS_ChannelSetSync")
        If pFunc Then
            Return pFunc(nHandle,nType,param,pProc,user)
        End If
    End If 
End Function

'declare function BASS_ChannelRemoveSync alias "BASS_ChannelRemoveSync"(byval handle as DWORD, byval sync as HSYNC) as BOOL
Function clsBass.ChannelRemoveSync(ByVal nHandle as DWORD ,ByVal sync as HSYNC) as Boolean
    If m_pDll Then
        Dim pFunc as Function(ByVal as DWORD,ByVal as HSYNC) as BOOL
        pFunc = DyLibSymbol(m_pDll ,"BASS_ChannelRemoveSync")
        If pFunc Then
            Return pFunc(nHandle,sync)
        End If
    End If 
End Function

'declare function BASS_ChannelSetDSP alias "BASS_ChannelSetDSP"(byval handle as DWORD, byval proc as DSPPROC ptr, byval user as any ptr, byval priority as integer) as HDSP
Function clsBass.ChannelSetDSP(ByVal nHandle as DWORD ,ByVal pProc as DSPPROC Ptr ,ByVal user as Any Ptr ,ByVal priority as Integer) as HDSP
    If m_pDll Then
        Dim pFunc as Function(ByVal as DWORD,ByVal as DSPPROC Ptr,as Any Ptr,as Integer) as HDSP
        pFunc = DyLibSymbol(m_pDll ,"BASS_ChannelSetDSP")
        If pFunc Then
            Return pFunc(nHandle,pProc,user,priority)
        End If
    End If 
End Function

'declare function BASS_ChannelRemoveDSP alias "BASS_ChannelRemoveDSP"(byval handle as DWORD, byval dsp as HDSP) as BOOL
Function clsBass.ChannelRemoveDSP(ByVal nHandle as DWORD ,ByVal dsp as HDSP) as Boolean
    If m_pDll Then
        Dim pFunc as Function(ByVal as DWORD,ByVal as HDSP) as BOOL
        pFunc = DyLibSymbol(m_pDll ,"BASS_ChannelRemoveDSP")
        If pFunc Then
            Return pFunc(nHandle,dsp)
        End If
    End If 
End Function

'declare function BASS_ChannelSetLink alias "BASS_ChannelSetLink"(byval handle as DWORD , byval chan as DWORD) as BOOL
Function clsBass.ChannelSetLink(ByVal nHandle as DWORD ,ByVal chan as DWORD) as Boolean
    If m_pDll Then
        Dim pFunc as Function(ByVal as DWORD,ByVal as DWORD) as BOOL
        pFunc = DyLibSymbol(m_pDll ,"BASS_ChannelSetLink")
        If pFunc Then
            Return pFunc(nHandle,chan)
        End If
    End If 
End Function

'declare function BASS_ChannelRemoveLink alias "BASS_ChannelRemoveLink"(byval handle as DWORD, byval chan as DWORD) as BOOL
Function clsBass.ChannelRemoveLink(ByVal nHandle as DWORD ,ByVal chan as DWORD) as Boolean
    If m_pDll Then
        Dim pFunc as Function(ByVal as DWORD,ByVal as DWORD) as BOOL
        pFunc = DyLibSymbol(m_pDll ,"BASS_ChannelRemoveLink")
        If pFunc Then
            Return pFunc(nHandle,chan)
        End If
    End If  
End Function

'declare function BASS_ChannelSetFX alias "BASS_ChannelSetFX"(byval handle as DWORD, byval type as DWORD, byval priority as integer) as HFX
Function clsBass.ChannelSetFX(ByVal nHandle as DWORD ,ByVal nType as DWORD ,ByVal priority as Integer) as HFX 
    If m_pDll Then
        Dim pFunc as Function(ByVal as DWORD,ByVal as DWORD,ByVal as Integer) as HFX
        pFunc = DyLibSymbol(m_pDll ,"BASS_ChannelSetFX")
        If pFunc Then
            Return pFunc(nHandle,nType,priority)
        End If
    End If   
End Function

'declare function BASS_ChannelRemoveFX alias "BASS_ChannelRemoveFX"(byval handle as DWORD, byval fx as HFX) as BOOL
Function clsBass.ChannelRemoveFX(ByVal nHandle as DWORD ,ByVal fx as HFX) as Boolean
    If m_pDll Then
        Dim pFunc as Function(ByVal as DWORD,ByVal as HFX) as BOOL
        pFunc = DyLibSymbol(m_pDll ,"BASS_ChannelRemoveFX")
        If pFunc Then
            Return pFunc(nHandle,fx)
        End If
    End If    
End Function

'declare function BASS_FXSetParameters alias "BASS_FXSetParameters"(byval handle as HFX, byval params as const any ptr) as BOOL
Function clsBass.FXSetParameters(ByVal nHandle as HFX ,ByVal params as Const Any Ptr) as Boolean
    If m_pDll Then
        Dim pFunc as Function(ByVal as HFX,ByVal as Const Any Ptr) as BOOL
        pFunc = DyLibSymbol(m_pDll ,"BASS_FXSetParameters")
        If pFunc Then
            Return pFunc(nHandle,params)
        End If
    End If    
End Function

'declare function BASS_FXGetParameters alias "BASS_FXGetParameters"(byval handle as HFX, byval params as any ptr) as BOOL
Function clsBass.FXGetParameters(ByVal nHandle as HFX ,ByVal params as Any Ptr) as Boolean
    If m_pDll Then
        Dim pFunc as Function(ByVal as HFX,ByVal as Const Any Ptr) as BOOL
        pFunc = DyLibSymbol(m_pDll ,"BASS_FXGetParameters")
        If pFunc Then
            Return pFunc(nHandle,params)
        End If
    End If    
End Function

'declare function BASS_FXReset alias "BASS_FXReset"(byval handle as HFX) as BOOL
Function clsBass.FXReset(ByVal nHandle As HFX) As Boolean
    If m_pDll Then
        Dim pFunc as Function(ByVal as HFX) as BOOL
        pFunc = DyLibSymbol(m_pDll ,"BASS_FXReset")
        If pFunc Then
            Return pFunc(nHandle)
        End If
    End If   
End Function
#endif





















