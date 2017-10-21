
---
title: Fasm Syntax Theme Test
...

# My Line Numbers Tests

Using `!raw{!HighlightLN(fasm)(15)(2)}`:

!HighlightLN(fasm)(15)(2)
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
; Simple text editor - fasm example program

format PE GUI 4.0
entry start

include 'win32a.inc'

IDR_ICON = 17
IDR_MENU = 37
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Using `!raw{!FasmLN(15)(2)}`:

!FasmLN(15)(2)
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
; Simple text editor - fasm example program

format PE GUI 4.0
entry start

include 'win32a.inc'

IDR_ICON = 17
IDR_MENU = 37
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~



# My Strings Tests

!Fasm
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
db 'string'
db 'escaped string\n'
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~


# MINIPAD.ASM

!Fasm
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

; Simple text editor - fasm example program

format PE GUI 4.0
entry start

include 'win32a.inc'

IDR_ICON = 17
IDR_MENU = 37

IDM_NEW   = 101
IDM_EXIT  = 102
IDM_ABOUT = 901

section '.text' code readable executable

  start:

    invoke  GetModuleHandle,0
    mov [wc.hInstance],eax

    invoke  LoadIcon,eax,IDR_ICON
    mov [wc.hIcon],eax
    invoke  LoadCursor,0,IDC_ARROW
    mov [wc.hCursor],eax
    invoke  RegisterClass,wc
    test    eax,eax
    jz  error

    invoke  LoadMenu,[wc.hInstance],IDR_MENU
    invoke  CreateWindowEx,0,_class,_title,WS_VISIBLE+WS_OVERLAPPEDWINDOW,144,128,256,256,NULL,eax,[wc.hInstance],NULL
    test    eax,eax
    jz  error

  msg_loop:
    invoke  GetMessage,msg,NULL,0,0
    cmp eax,1
    jb  end_loop
    jne msg_loop
    invoke  TranslateMessage,msg
    invoke  DispatchMessage,msg
    jmp msg_loop

  error:
    invoke  MessageBox,NULL,_error,NULL,MB_ICONERROR+MB_OK

  end_loop:
    invoke  ExitProcess,[msg.wParam]

proc WindowProc hwnd,wmsg,wparam,lparam
    push    ebx esi edi
    mov eax,[wmsg]
    cmp eax,WM_CREATE
    je  .wmcreate
    cmp eax,WM_SIZE
    je  .wmsize
    cmp eax,WM_SETFOCUS
    je  .wmsetfocus
    cmp eax,WM_COMMAND
    je  .wmcommand
    cmp eax,WM_DESTROY
    je  .wmdestroy
  .defwndproc:
    invoke  DefWindowProc,[hwnd],[wmsg],[wparam],[lparam]
    jmp .finish
  .wmcreate:
    invoke  GetClientRect,[hwnd],client
    invoke  CreateWindowEx,WS_EX_CLIENTEDGE,_edit,0,WS_VISIBLE+WS_CHILD+WS_HSCROLL+WS_VSCROLL+ES_AUTOHSCROLL+ES_AUTOVSCROLL+ES_MULTILINE,[client.left],[client.top],[client.right],[client.bottom],[hwnd],0,[wc.hInstance],NULL
    or  eax,eax
    jz  .failed
    mov [edithwnd],eax
    invoke  CreateFont,16,0,0,0,0,FALSE,FALSE,FALSE,ANSI_CHARSET,OUT_RASTER_PRECIS,CLIP_DEFAULT_PRECIS,DEFAULT_QUALITY,FIXED_PITCH+FF_DONTCARE,NULL
    or  eax,eax
    jz  .failed
    mov [editfont],eax
    invoke  SendMessage,[edithwnd],WM_SETFONT,eax,FALSE
    xor eax,eax
    jmp .finish
      .failed:
    or  eax,-1
    jmp .finish
  .wmsize:
    invoke  GetClientRect,[hwnd],client
    invoke  MoveWindow,[edithwnd],[client.left],[client.top],[client.right],[client.bottom],TRUE
    xor eax,eax
    jmp .finish
  .wmsetfocus:
    invoke  SetFocus,[edithwnd]
    xor eax,eax
    jmp .finish
  .wmcommand:
    mov eax,[wparam]
    and eax,0FFFFh
    cmp eax,IDM_NEW
    je  .new
    cmp eax,IDM_ABOUT
    je  .about
    cmp eax,IDM_EXIT
    je  .wmdestroy
    jmp .defwndproc
      .new:
    invoke  SendMessage,[edithwnd],WM_SETTEXT,0,0
    jmp .finish
      .about:
    invoke  MessageBox,[hwnd],_about_text,_about_title,MB_OK
    jmp .finish
  .wmdestroy:
    invoke  DeleteObject,[editfont]
    invoke  PostQuitMessage,0
    xor eax,eax
  .finish:
    pop edi esi ebx
    ret
endp

section '.data' data readable writeable

  _title TCHAR 'MiniPad',0
  _about_title TCHAR 'About MiniPad',0
  _about_text TCHAR 'This is Win32 example program created with flat assembler.',0
  _error TCHAR 'Startup failed.',0

  _class TCHAR 'MINIPAD32',0
  _edit TCHAR 'EDIT',0

  wc WNDCLASS 0,WindowProc,0,0,NULL,NULL,NULL,COLOR_BTNFACE+1,NULL,_class

  edithwnd dd ?
  editfont dd ?

  msg MSG
  client RECT

section '.idata' import data readable writeable

  library kernel,'KERNEL32.DLL',\
      user,'USER32.DLL',\
      gdi,'GDI32.DLL'

  import kernel,\
     GetModuleHandle,'GetModuleHandleA',\
     ExitProcess,'ExitProcess'

  import user,\
     RegisterClass,'RegisterClassA',\
     CreateWindowEx,'CreateWindowExA',\
     DefWindowProc,'DefWindowProcA',\
     SetWindowLong,'SetWindowLongA',\
     RedrawWindow,'RedrawWindow',\
     GetMessage,'GetMessageA',\
     TranslateMessage,'TranslateMessage',\
     DispatchMessage,'DispatchMessageA',\
     SendMessage,'SendMessageA',\
     LoadCursor,'LoadCursorA',\
     LoadIcon,'LoadIconA',\
     LoadMenu,'LoadMenuA',\
     GetClientRect,'GetClientRect',\
     MoveWindow,'MoveWindow',\
     SetFocus,'SetFocus',\
     MessageBox,'MessageBoxA',\
     PostQuitMessage,'PostQuitMessage'

  import gdi,\
     CreateFont,'CreateFontA',\
     DeleteObject,'DeleteObject'

section '.rsrc' resource data readable

  ; resource directory

  directory RT_MENU,menus,\
        RT_ICON,icons,\
        RT_GROUP_ICON,group_icons,\
        RT_VERSION,versions

  ; resource subdirectories

  resource menus,\
       IDR_MENU,LANG_ENGLISH+SUBLANG_DEFAULT,main_menu

  resource icons,\
       1,LANG_NEUTRAL,icon_data

  resource group_icons,\
       IDR_ICON,LANG_NEUTRAL,main_icon

  resource versions,\
       1,LANG_NEUTRAL,version

  menu main_menu
       menuitem '&File',0,MFR_POPUP
        menuitem '&New',IDM_NEW
        menuseparator
        menuitem 'E&xit',IDM_EXIT,MFR_END
       menuitem '&Help',0,MFR_POPUP + MFR_END
        menuitem '&About...',IDM_ABOUT,MFR_END

  icon main_icon,icon_data,'minipad.ico'

  versioninfo version,VOS__WINDOWS32,VFT_APP,VFT2_UNKNOWN,LANG_ENGLISH+SUBLANG_DEFAULT,0,\
          'FileDescription','MiniPad - example program',\
          'LegalCopyright','No rights reserved.',\
          'FileVersion','1.0',\
          'ProductVersion','1.0',\
          'OriginalFilename','MINIPAD.EXE'
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~


# LASTERR.ASM

!Fasm
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

format PE GUI 4.0
entry start

include 'win32a.inc'

section '.text' code readable executable

  start:
    invoke  SetLastError,0
    invoke  ShowLastError,HWND_DESKTOP
    invoke  ExitProcess,0

section '.idata' import data readable writeable

  library kernel,'KERNEL32.DLL',\
      errormsg,'ERRORMSG.DLL'

  import kernel,\
     SetLastError,'SetLastError',\
     ExitProcess,'ExitProcess'

  import errormsg,\
     ShowLastError,'ShowLastError'
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~


# ERRORMSG.ASM

!Fasm
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

; DLL creation example

format PE GUI 4.0 DLL
entry DllEntryPoint

include 'win32a.inc'

section '.text' code readable executable

proc DllEntryPoint hinstDLL,fdwReason,lpvReserved
    mov eax,TRUE
    ret
endp

; VOID ShowErrorMessage(HWND hWnd,DWORD dwError);

proc ShowErrorMessage hWnd,dwError
  local lpBuffer:DWORD
    lea eax,[lpBuffer]
    invoke  FormatMessage,FORMAT_MESSAGE_ALLOCATE_BUFFER+FORMAT_MESSAGE_FROM_SYSTEM,0,[dwError],LANG_NEUTRAL,eax,0,0
    invoke  MessageBox,[hWnd],[lpBuffer],NULL,MB_ICONERROR+MB_OK
    invoke  LocalFree,[lpBuffer]
    ret
endp

; VOID ShowLastError(HWND hWnd);

proc ShowLastError hWnd
    invoke  GetLastError
    stdcall ShowErrorMessage,[hWnd],eax
    ret
endp

section '.idata' import data readable writeable

  library kernel,'KERNEL32.DLL',\
      user,'USER32.DLL'

  import kernel,\
     GetLastError,'GetLastError',\
     SetLastError,'SetLastError',\
     FormatMessage,'FormatMessageA',\
     LocalFree,'LocalFree'

  import user,\
     MessageBox,'MessageBoxA'

section '.edata' export data readable

  export 'ERRORMSG.DLL',\
     ShowErrorMessage,'ShowErrorMessage',\
     ShowLastError,'ShowLastError'

section '.reloc' fixups data readable discardable
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

# DDRAW.ASM

!Fasm
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

; DirectDraw programming example

format PE GUI 4.0
entry start

include 'win32a.inc'

include 'ddraw.inc'

section '.text' code readable executable

  start:

    invoke  GetModuleHandleA,NULL
    mov [hinstance],eax

    invoke  LoadIconA,NULL,IDI_APPLICATION
    mov [wc.hIcon],eax

    invoke  LoadCursorA,NULL,IDC_ARROW
    mov [wc.hCursor],eax

    mov [wc.style],0
    mov [wc.lpfnWndProc],WindowProc
    mov [wc.cbClsExtra],0
    mov [wc.cbWndExtra],0
    mov eax,[hinstance]
    mov [wc.hInstance],eax
    mov [wc.hbrBackground],0
    mov dword [wc.lpszMenuName],NULL
    mov dword [wc.lpszClassName],_class
    invoke  RegisterClassA,wc
    test    eax,eax
    jz  startup_error

    invoke  CreateWindowExA,\
        0,_class,_title,WS_POPUP+WS_VISIBLE,0,0,0,0,NULL,NULL,[hinstance],NULL
    test    eax,eax
    jz  startup_error
    mov [hwnd],eax

    invoke  DirectDrawCreate,NULL,DDraw,NULL
    or  eax,eax
    jnz ddraw_error

    cominvk DDraw,SetCooperativeLevel,\
        [hwnd],DDSCL_EXCLUSIVE+DDSCL_FULLSCREEN
    or  eax,eax
    jnz ddraw_error

    cominvk DDraw,SetDisplayMode,\
        640,480,8
    or  eax,eax
    jnz ddraw_error

    mov [ddsd.dwSize],sizeof.DDSURFACEDESC
    mov [ddsd.dwFlags],DDSD_CAPS+DDSD_BACKBUFFERCOUNT
    mov [ddsd.ddsCaps.dwCaps],DDSCAPS_PRIMARYSURFACE+DDSCAPS_FLIP+DDSCAPS_COMPLEX
    mov [ddsd.dwBackBufferCount],1
    cominvk DDraw,CreateSurface,\
        ddsd,DDSPrimary,NULL
    or  eax,eax
    jnz ddraw_error

    mov [ddscaps.dwCaps],DDSCAPS_BACKBUFFER
    cominvk DDSPrimary,GetAttachedSurface,\
        ddscaps,DDSBack
    or  eax,eax
    jnz ddraw_error

    mov esi,picture
    call    load_picture
    jc  open_error

    mov esi,picture
    call    load_palette
    jc  open_error

    invoke  GetTickCount
    mov [last_tick],eax

    jmp paint

main_loop:

    invoke  PeekMessageA,msg,NULL,0,0,PM_NOREMOVE
    or  eax,eax
    jz  no_message
    invoke  GetMessageA,msg,NULL,0,0
    or  eax,eax
    jz  end_loop
    invoke  TranslateMessage,msg
    invoke  DispatchMessageA,msg

    jmp main_loop

    no_message:
    cmp [active],0
    je  sleep

    cominvk DDSPrimary,IsLost
    or  eax,eax
    jz  paint
    cmp eax,DDERR_SURFACELOST
    jne end_loop

    cominvk DDSPrimary,Restore

paint:

    mov [rect.top],0
    mov [rect.bottom],480
    mov [rect.left],0
    mov [rect.right],640

    cominvk DDSBack,BltFast,\
        0,0,[DDSPicture],rect,DDBLTFAST_SRCCOLORKEY
    or  eax,eax
    jnz paint_done

    movzx   eax,[frame]
    xor edx,edx
    mov ebx,10
    div ebx

    sal eax,6
    add eax,480
    mov [rect.top],eax
    add eax,64
    mov [rect.bottom],eax
    sal edx,6
    mov [rect.left],edx
    add edx,64
    mov [rect.right],edx

    cominvk DDSBack,BltFast,\
        [x],[y],[DDSPicture],rect,DDBLTFAST_SRCCOLORKEY

    cominvk DDSPrimary,SetPalette,[DDPalette]

    cominvk DDSPrimary,Flip,0,0

    paint_done:

    invoke  GetTickCount
    mov ebx,eax
    sub ebx,[last_tick]
    cmp ebx,20
    jb  main_loop
    add [last_tick],20

    inc [frame]
    cmp [frame],60
    jb  main_loop
    mov [frame],0
    jmp main_loop

sleep:
    invoke  WaitMessage
    jmp main_loop

ddraw_error:
    mov eax,_ddraw_error
    jmp error
open_error:
    mov eax,_open_error
    error:
    invoke  MessageBoxA,[hwnd],eax,_error,MB_OK+MB_ICONERROR
    invoke  DestroyWindow,[hwnd]
    invoke  PostQuitMessage,1
    jmp main_loop
startup_error:
    invoke  MessageBoxA,[hwnd],_startup_error,_error,MB_OK+MB_ICONERROR
end_loop:
    invoke  ExitProcess,[msg.wParam]

include 'gif87a.inc'

proc WindowProc hwnd,wmsg,wparam,lparam
    push    ebx esi edi
    mov eax,[wmsg]
    cmp eax,WM_CREATE
    je  .wmcreate
    cmp eax,WM_DESTROY
    je  .wmdestroy
    cmp eax,WM_ACTIVATE
    je  .wmactivate
    cmp eax,WM_SETCURSOR
    je  .wmsetcursor
    cmp eax,WM_MOUSEMOVE
    je  .wmmousemove
    cmp eax,WM_KEYDOWN
    je  .wmkeydown
    .defwindowproc:
    invoke  DefWindowProcA,[hwnd],[wmsg],[wparam],[lparam]
    jmp .finish
    .wmcreate:
    xor eax,eax
    jmp .finish
    .wmkeydown:
    cmp [wparam],VK_ESCAPE
    jne .finish
    .wmdestroy:
    cominvk DDraw,RestoreDisplayMode
    cominvk DDraw,Release
    invoke  PostQuitMessage,0
    xor eax,eax
    jmp .finish
    .wmactivate:
    mov eax,[wparam]
    mov [active],al
    jmp .finish
    .wmsetcursor:
    invoke  SetCursor,0
    xor eax,eax
    jmp .finish
    .wmmousemove:
    movsx   eax,word [lparam]
    mov [x],eax
    movsx   eax,word [lparam+2]
    mov [y],eax
    .finish:
    pop edi esi ebx
    ret
endp

section '.data' data readable writeable

  _title db 'flat assembler DirectDraw application',0
  _class db 'FDDRAW32',0

  _error db 'Error',0
  _startup_error db 'Startup failed.',0
  _ddraw_error db 'Direct Draw initialization failed.',0
  _open_error db 'Failed opening data file.',0

  picture db 'DDRAW.GIF',0

section '.bss' readable writeable

  hinstance dd ?
  hwnd dd ?
  wc WNDCLASS
  msg MSG

  ddsd DDSURFACEDESC
  ddscaps DDSCAPS

  DDraw DirectDraw
  DDSPrimary DirectDrawSurface
  DDSBack DirectDrawSurface

  DDSPicture DirectDrawSurface
  DDPalette DirectDrawPalette

  bytes_count dd ?
  last_tick dd ?
  frame db ?
  active db ?
  LZW_bits db ?
  LZW_table rd (0F00h-2)*2
  buffer rb 40000h
  rect RECT
  x dd ?
  y dd ?

section '.idata' import data readable

  library kernel,'KERNEL32.DLL',\
      user,'USER32.DLL',\
      ddraw,'DDRAW.DLL'

  import kernel,\
     GetModuleHandleA,'GetModuleHandleA',\
     CreateFileA,'CreateFileA',\
     ReadFile,'ReadFile',\
     CloseHandle,'CloseHandle',\
     GetTickCount,'GetTickCount',\
     ExitProcess,'ExitProcess'

  import user,\
     RegisterClassA,'RegisterClassA',\
     CreateWindowExA,'CreateWindowExA',\
     DestroyWindow,'DestroyWindow',\
     DefWindowProcA,'DefWindowProcA',\
     GetMessageA,'GetMessageA',\
     PeekMessageA,'PeekMessageA',\
     TranslateMessage,'TranslateMessage',\
     DispatchMessageA,'DispatchMessageA',\
     LoadCursorA,'LoadCursorA',\
     LoadIconA,'LoadIconA',\
     SetCursor,'SetCursor',\
     MessageBoxA,'MessageBoxA',\
     PostQuitMessage,'PostQuitMessage',\
     WaitMessage,'WaitMessage'

  import ddraw,\
     DirectDrawCreate,'DirectDrawCreate'
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

# BEER.ASM

!Fasm
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

; Beer - example of tiny (one section) Win32 program

format PE GUI 4.0

include 'win32a.inc'

; no section defined - fasm will automatically create .flat section for both
; code and data, and set entry point at the beginning of this section

    invoke  MessageBoxA,0,_message,_caption,MB_ICONQUESTION+MB_YESNO
    cmp eax,IDYES
    jne exit

    invoke  mciSendString,_cmd_open,0,0,0
    invoke  mciSendString,_cmd_eject,0,0,0
    invoke  mciSendString,_cmd_close,0,0,0

exit:
    invoke  ExitProcess,0

_message db 'Do you need additional place for the beer?',0
_caption db 'Desktop configuration',0

_cmd_open db 'open cdaudio',0
_cmd_eject db 'set cdaudio door open',0
_cmd_close db 'close cdaudio',0

; import data in the same section

data import

 library kernel32,'KERNEL32.DLL',\
     user32,'USER32.DLL',\
     winmm,'WINMM.DLL'

 import kernel32,\
    ExitProcess,'ExitProcess'

 import user32,\
    MessageBoxA,'MessageBoxA'

 import winmm,\
    mciSendString,'mciSendStringA'

end data
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

# PE64DEMO.ASM

!Fasm
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

; Example of 64-bit PE program

format PE64 GUI
entry start

section '.text' code readable executable

  start:
    sub rsp,8*5     ; reserve stack for API use and make stack dqword aligned

    mov r9d,0
    lea r8,[_caption]
    lea rdx,[_message]
    mov rcx,0
    call    [MessageBoxA]

    mov ecx,eax
    call    [ExitProcess]

section '.data' data readable writeable

  _caption db 'Win64 assembly program',0
  _message db 'Hello World!',0

section '.idata' import data readable writeable

  dd 0,0,0,RVA kernel_name,RVA kernel_table
  dd 0,0,0,RVA user_name,RVA user_table
  dd 0,0,0,0,0

  kernel_table:
    ExitProcess dq RVA _ExitProcess
    dq 0
  user_table:
    MessageBoxA dq RVA _MessageBoxA
    dq 0

  kernel_name db 'KERNEL32.DLL',0
  user_name db 'USER32.DLL',0

  _ExitProcess dw 0
    db 'ExitProcess',0
  _MessageBoxA dw 0
    db 'MessageBoxA',0
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
