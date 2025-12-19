//
// This file was auto-generated using the following command:
//
// jai ./generate.jai
//



RENDERDOC_ShaderDebugMagicValue_truncated :: 0x48656670eab25520;

//////////////////////////////////////////////////////////////////////////////////////////////////
// RenderDoc capture options
//
RENDERDOC_CaptureOption :: enum u32 {
    AllowVSync                       :: 0;

    AllowFullscreen                  :: 1;

    APIValidation                    :: 2;
    DebugDeviceMode                  :: 2;

    CaptureCallstacks                :: 3;

    CaptureCallstacksOnlyDraws       :: 4;
    CaptureCallstacksOnlyActions     :: 4;

    DelayForDebugger                 :: 5;

    VerifyBufferAccess               :: 6;

    VerifyMapWrites                  :: 6;

    HookIntoChildren                 :: 7;

    RefAllResources                  :: 8;

    SaveAllInitials                  :: 9;

    CaptureAllCmdLists               :: 10;

    DebugOutputMute                  :: 11;

    AllowUnsupportedVendorExtensions :: 12;

    SoftMemoryLimit                  :: 13;

    eRENDERDOC_Option_AllowVSync                       :: AllowVSync;

    eRENDERDOC_Option_AllowFullscreen                  :: AllowFullscreen;

    eRENDERDOC_Option_APIValidation                    :: APIValidation;
    eRENDERDOC_Option_DebugDeviceMode                  :: DebugDeviceMode;

    eRENDERDOC_Option_CaptureCallstacks                :: CaptureCallstacks;

    eRENDERDOC_Option_CaptureCallstacksOnlyDraws       :: CaptureCallstacksOnlyDraws;
    eRENDERDOC_Option_CaptureCallstacksOnlyActions     :: CaptureCallstacksOnlyActions;

    eRENDERDOC_Option_DelayForDebugger                 :: DelayForDebugger;

    eRENDERDOC_Option_VerifyBufferAccess               :: VerifyBufferAccess;

    eRENDERDOC_Option_VerifyMapWrites                  :: VerifyMapWrites;

    eRENDERDOC_Option_HookIntoChildren                 :: HookIntoChildren;

    eRENDERDOC_Option_RefAllResources                  :: RefAllResources;

    eRENDERDOC_Option_SaveAllInitials                  :: SaveAllInitials;

    eRENDERDOC_Option_CaptureAllCmdLists               :: CaptureAllCmdLists;

    eRENDERDOC_Option_DebugOutputMute                  :: DebugOutputMute;

    eRENDERDOC_Option_AllowUnsupportedVendorExtensions :: AllowUnsupportedVendorExtensions;

    eRENDERDOC_Option_SoftMemoryLimit                  :: SoftMemoryLimit;
}

// Sets an option that controls how RenderDoc behaves on capture.
//
// Returns 1 if the option and value are valid
// Returns 0 if either is invalid and the option is unchanged
pRENDERDOC_SetCaptureOptionU32 :: #type (opt: RENDERDOC_CaptureOption, val: u32) -> s32 #c_call;
pRENDERDOC_SetCaptureOptionF32 :: #type (opt: RENDERDOC_CaptureOption, val: float) -> s32 #c_call;

// Gets the current value of an option as a uint32_t
//
// If the option is invalid, 0xffffffff is returned
pRENDERDOC_GetCaptureOptionU32 :: #type (opt: RENDERDOC_CaptureOption) -> u32 #c_call;

// Gets the current value of an option as a float
//
// If the option is invalid, -FLT_MAX is returned
pRENDERDOC_GetCaptureOptionF32 :: #type (opt: RENDERDOC_CaptureOption) -> float #c_call;

RENDERDOC_InputButton :: enum u32 {
    _0           :: 48;
    _1           :: 49;
    _2           :: 50;
    _3           :: 51;
    _4           :: 52;
    _5           :: 53;
    _6           :: 54;
    _7           :: 55;
    _8           :: 56;
    _9           :: 57;

    A            :: 65;
    B            :: 66;
    C            :: 67;
    D            :: 68;
    E            :: 69;
    F            :: 70;
    G            :: 71;
    H            :: 72;
    I            :: 73;
    J            :: 74;
    K            :: 75;
    L            :: 76;
    M            :: 77;
    N            :: 78;
    O            :: 79;
    P            :: 80;
    Q            :: 81;
    R            :: 82;
    S            :: 83;
    T            :: 84;
    U            :: 85;
    V            :: 86;
    W            :: 87;
    X            :: 88;
    Y            :: 89;
    Z            :: 90;

    NonPrintable :: 256;

    Divide       :: 257;
    Multiply     :: 258;
    Subtract     :: 259;
    Plus         :: 260;

    F1           :: 261;
    F2           :: 262;
    F3           :: 263;
    F4           :: 264;
    F5           :: 265;
    F6           :: 266;
    F7           :: 267;
    F8           :: 268;
    F9           :: 269;
    F10          :: 270;
    F11          :: 271;
    F12          :: 272;

    Home         :: 273;
    End          :: 274;
    Insert       :: 275;
    Delete       :: 276;
    PageUp       :: 277;
    PageDn       :: 278;

    Backspace    :: 279;
    Tab          :: 280;
    PrtScrn      :: 281;
    Pause        :: 282;

    Max          :: 283;

    eRENDERDOC_Key_0            :: _0;
    eRENDERDOC_Key_1            :: _1;
    eRENDERDOC_Key_2            :: _2;
    eRENDERDOC_Key_3            :: _3;
    eRENDERDOC_Key_4            :: _4;
    eRENDERDOC_Key_5            :: _5;
    eRENDERDOC_Key_6            :: _6;
    eRENDERDOC_Key_7            :: _7;
    eRENDERDOC_Key_8            :: _8;
    eRENDERDOC_Key_9            :: _9;

    eRENDERDOC_Key_A            :: A;
    eRENDERDOC_Key_B            :: B;
    eRENDERDOC_Key_C            :: C;
    eRENDERDOC_Key_D            :: D;
    eRENDERDOC_Key_E            :: E;
    eRENDERDOC_Key_F            :: F;
    eRENDERDOC_Key_G            :: G;
    eRENDERDOC_Key_H            :: H;
    eRENDERDOC_Key_I            :: I;
    eRENDERDOC_Key_J            :: J;
    eRENDERDOC_Key_K            :: K;
    eRENDERDOC_Key_L            :: L;
    eRENDERDOC_Key_M            :: M;
    eRENDERDOC_Key_N            :: N;
    eRENDERDOC_Key_O            :: O;
    eRENDERDOC_Key_P            :: P;
    eRENDERDOC_Key_Q            :: Q;
    eRENDERDOC_Key_R            :: R;
    eRENDERDOC_Key_S            :: S;
    eRENDERDOC_Key_T            :: T;
    eRENDERDOC_Key_U            :: U;
    eRENDERDOC_Key_V            :: V;
    eRENDERDOC_Key_W            :: W;
    eRENDERDOC_Key_X            :: X;
    eRENDERDOC_Key_Y            :: Y;
    eRENDERDOC_Key_Z            :: Z;

    eRENDERDOC_Key_NonPrintable :: NonPrintable;

    eRENDERDOC_Key_Divide       :: Divide;
    eRENDERDOC_Key_Multiply     :: Multiply;
    eRENDERDOC_Key_Subtract     :: Subtract;
    eRENDERDOC_Key_Plus         :: Plus;

    eRENDERDOC_Key_F1           :: F1;
    eRENDERDOC_Key_F2           :: F2;
    eRENDERDOC_Key_F3           :: F3;
    eRENDERDOC_Key_F4           :: F4;
    eRENDERDOC_Key_F5           :: F5;
    eRENDERDOC_Key_F6           :: F6;
    eRENDERDOC_Key_F7           :: F7;
    eRENDERDOC_Key_F8           :: F8;
    eRENDERDOC_Key_F9           :: F9;
    eRENDERDOC_Key_F10          :: F10;
    eRENDERDOC_Key_F11          :: F11;
    eRENDERDOC_Key_F12          :: F12;

    eRENDERDOC_Key_Home         :: Home;
    eRENDERDOC_Key_End          :: End;
    eRENDERDOC_Key_Insert       :: Insert;
    eRENDERDOC_Key_Delete       :: Delete;
    eRENDERDOC_Key_PageUp       :: PageUp;
    eRENDERDOC_Key_PageDn       :: PageDn;

    eRENDERDOC_Key_Backspace    :: Backspace;
    eRENDERDOC_Key_Tab          :: Tab;
    eRENDERDOC_Key_PrtScrn      :: PrtScrn;
    eRENDERDOC_Key_Pause        :: Pause;

    eRENDERDOC_Key_Max          :: Max;
}

// Sets which key or keys can be used to toggle focus between multiple windows
//
// If keys is NULL or num is 0, toggle keys will be disabled
pRENDERDOC_SetFocusToggleKeys :: #type (keys: *RENDERDOC_InputButton, num: s32) -> void #c_call;

// Sets which key or keys can be used to capture the next frame
//
// If keys is NULL or num is 0, captures keys will be disabled
pRENDERDOC_SetCaptureKeys :: #type (keys: *RENDERDOC_InputButton, num: s32) -> void #c_call;

RENDERDOC_OverlayBits :: enum u32 {
    Enabled     :: 1;

    FrameRate   :: 2;

    FrameNumber :: 4;

    CaptureList :: 8;

    Default     :: 15;

    All         :: 134217727;

    None        :: 0;

    eRENDERDOC_Overlay_Enabled     :: Enabled;

    eRENDERDOC_Overlay_FrameRate   :: FrameRate;

    eRENDERDOC_Overlay_FrameNumber :: FrameNumber;

    eRENDERDOC_Overlay_CaptureList :: CaptureList;

    eRENDERDOC_Overlay_Default     :: Default;

    eRENDERDOC_Overlay_All         :: All;

    eRENDERDOC_Overlay_None        :: None;
}

// returns the overlay bits that have been set
pRENDERDOC_GetOverlayBits :: #type () -> u32 #c_call;

// sets the overlay bits with an and & or mask
pRENDERDOC_MaskOverlayBits :: #type (And: u32, Or: u32) -> void #c_call;

// this function will attempt to remove RenderDoc's hooks in the application.
//
// Note: that this can only work correctly if done immediately after
// the module is loaded, before any API work happens. RenderDoc will remove its
// injected hooks and shut down. Behaviour is undefined if this is called
// after any API functions have been called, and there is still no guarantee of
// success.
pRENDERDOC_RemoveHooks :: #type () -> void #c_call;

// DEPRECATED: compatibility for code compiled against pre-1.4.1 headers.
pRENDERDOC_Shutdown :: pRENDERDOC_RemoveHooks;

// This function will unload RenderDoc's crash handler.
//
// If you use your own crash handler and don't want RenderDoc's handler to
// intercede, you can call this function to unload it and any unhandled
// exceptions will pass to the next handler.
pRENDERDOC_UnloadCrashHandler :: #type () -> void #c_call;

// Sets the capture file path template
//
// pathtemplate is a UTF-8 string that gives a template for how captures will be named
// and where they will be saved.
//
// Any extension is stripped off the path, and captures are saved in the directory
// specified, and named with the filename and the frame number appended. If the
// directory does not exist it will be created, including any parent directories.
//
// If pathtemplate is NULL, the template will remain unchanged
//
// Example:
//
// SetCaptureFilePathTemplate("my_captures/example");
//
// Capture #1 -> my_captures/example_frame123.rdc
// Capture #2 -> my_captures/example_frame456.rdc
pRENDERDOC_SetCaptureFilePathTemplate :: #type (pathtemplate: *u8) -> void #c_call;

// returns the current capture path template, see SetCaptureFileTemplate above, as a UTF-8 string
pRENDERDOC_GetCaptureFilePathTemplate :: #type () -> *u8 #c_call;

// DEPRECATED: compatibility for code compiled against pre-1.1.2 headers.
pRENDERDOC_SetLogFilePathTemplate :: pRENDERDOC_SetCaptureFilePathTemplate;
pRENDERDOC_GetLogFilePathTemplate :: pRENDERDOC_GetCaptureFilePathTemplate;

// returns the number of captures that have been made
pRENDERDOC_GetNumCaptures :: #type () -> u32 #c_call;

// This function returns the details of a capture, by index. New captures are added
// to the end of the list.
//
// filename will be filled with the absolute path to the capture file, as a UTF-8 string
// pathlength will be written with the length in bytes of the filename string
// timestamp will be written with the time of the capture, in seconds since the Unix epoch
//
// Any of the parameters can be NULL and they'll be skipped.
//
// The function will return 1 if the capture index is valid, or 0 if the index is invalid
// If the index is invalid, the values will be unchanged
//
// Note: when captures are deleted in the UI they will remain in this list, so the
// capture path may not exist anymore.
pRENDERDOC_GetCapture :: #type (idx: u32, filename: *u8, pathlength: *u32, timestamp: *u64) -> u32 #c_call;

// Sets the comments associated with a capture file. These comments are displayed in the
// UI program when opening.
//
// filePath should be a path to the capture file to add comments to. If set to NULL or ""
// the most recent capture file created made will be used instead.
// comments should be a NULL-terminated UTF-8 string to add as comments.
//
// Any existing comments will be overwritten.
pRENDERDOC_SetCaptureFileComments :: #type (filePath: *u8, comments: *u8) -> void #c_call;

// returns 1 if the RenderDoc UI is connected to this application, 0 otherwise
pRENDERDOC_IsTargetControlConnected :: #type () -> u32 #c_call;

// DEPRECATED: compatibility for code compiled against pre-1.1.1 headers.
// This was renamed to IsTargetControlConnected in API 1.1.1, the old typedef is kept here for
// backwards compatibility with old code, it is castable either way since it's ABI compatible
// as the same function pointer type.
pRENDERDOC_IsRemoteAccessConnected :: pRENDERDOC_IsTargetControlConnected;

// This function will launch the Replay UI associated with the RenderDoc library injected
// into the running application.
//
// if connectTargetControl is 1, the Replay UI will be launched with a command line parameter
// to connect to this application
// cmdline is the rest of the command line, as a UTF-8 string. E.g. a captures to open
// if cmdline is NULL, the command line will be empty.
//
// returns the PID of the replay UI if successful, 0 if not successful.
pRENDERDOC_LaunchReplayUI :: #type (connectTargetControl: u32, cmdline: *u8) -> u32 #c_call;

// RenderDoc can return a higher version than requested if it's backwards compatible,
// this function returns the actual version returned. If a parameter is NULL, it will be
// ignored and the others will be filled out.
pRENDERDOC_GetAPIVersion :: #type (major: *s32, minor: *s32, patch: *s32) -> void #c_call;

// Requests that the replay UI show itself (if hidden or not the current top window). This can be
// used in conjunction with IsTargetControlConnected and LaunchReplayUI to intelligently handle
// showing the UI after making a capture.
//
// This will return 1 if the request was successfully passed on, though it's not guaranteed that
// the UI will be on top in all cases depending on OS rules. It will return 0 if there is no current
// target control connection to make such a request, or if there was another error
pRENDERDOC_ShowReplayUI :: #type () -> u32 #c_call;

// A device pointer is a pointer to the API's root handle.
//
// This would be an ID3D11Device, HGLRC/GLXContext, ID3D12Device, etc
RENDERDOC_DevicePointer :: *void;

// A window handle is the OS's native window handle
//
// This would be an HWND, GLXDrawable, etc
RENDERDOC_WindowHandle :: *void;

// This sets the RenderDoc in-app overlay in the API/window pair as 'active' and it will
// respond to keypresses. Neither parameter can be NULL
pRENDERDOC_SetActiveWindow :: #type (device: RENDERDOC_DevicePointer, wndHandle: RENDERDOC_WindowHandle) -> void #c_call;

// capture the next frame on whichever window and API is currently considered active
pRENDERDOC_TriggerCapture :: #type () -> void #c_call;

// capture the next N frames on whichever window and API is currently considered active
pRENDERDOC_TriggerMultiFrameCapture :: #type (numFrames: u32) -> void #c_call;

// Immediately starts capturing API calls on the specified device pointer and window handle.
//
// If there is no matching thing to capture (e.g. no supported API has been initialised),
// this will do nothing.
//
// The results are undefined (including crashes) if two captures are started overlapping,
// even on separate devices and/oror windows.
pRENDERDOC_StartFrameCapture :: #type (device: RENDERDOC_DevicePointer, wndHandle: RENDERDOC_WindowHandle) -> void #c_call;

// Returns whether or not a frame capture is currently ongoing anywhere.
//
// This will return 1 if a capture is ongoing, and 0 if there is no capture running
pRENDERDOC_IsFrameCapturing :: #type () -> u32 #c_call;

// Ends capturing immediately.
//
// This will return 1 if the capture succeeded, and 0 if there was an error capturing.
pRENDERDOC_EndFrameCapture :: #type (device: RENDERDOC_DevicePointer, wndHandle: RENDERDOC_WindowHandle) -> u32 #c_call;

// Ends capturing immediately and discard any data stored without saving to disk.
//
// This will return 1 if the capture was discarded, and 0 if there was an error or no capture
// was in progress
pRENDERDOC_DiscardFrameCapture :: #type (device: RENDERDOC_DevicePointer, wndHandle: RENDERDOC_WindowHandle) -> u32 #c_call;

// Only valid to be called between a call to StartFrameCapture and EndFrameCapture. Gives a custom
// title to the capture produced which will be displayed in the UI.
//
// If multiple captures are ongoing, this title will be applied to the first capture to end after
// this call. The second capture to end will have no title, unless this function is called again.
//
// Calling this function has no effect if no capture is currently running, and if it is called
// multiple times only the last title will be used.
pRENDERDOC_SetCaptureTitle :: #type (title: *u8) -> void #c_call;

// RenderDoc uses semantic versioning (http://semver.org/).
//
// MAJOR version is incremented when incompatible API changes happen.
// MINOR version is incremented when functionality is added in a backwards-compatible manner.
// PATCH version is incremented when backwards-compatible bug fixes happen.
//
// Note that this means the API returned can be higher than the one you might have requested.
// e.g. if you are running against a newer RenderDoc that supports 1.0.1, it will be returned
// instead of 1.0.0. You can check this with the GetAPIVersion entry point
RENDERDOC_Version :: enum u32 {
    _0_0 :: 10000;
    _0_1 :: 10001;
    _0_2 :: 10002;
    _1_0 :: 10100;
    _1_1 :: 10101;
    _1_2 :: 10102;
    _2_0 :: 10200;
    _3_0 :: 10300;
    _4_0 :: 10400;
    _4_1 :: 10401;
    _4_2 :: 10402;
    _5_0 :: 10500;
    _6_0 :: 10600;

    eRENDERDOC_API_Version_1_0_0 :: _0_0;
    eRENDERDOC_API_Version_1_0_1 :: _0_1;
    eRENDERDOC_API_Version_1_0_2 :: _0_2;
    eRENDERDOC_API_Version_1_1_0 :: _1_0;
    eRENDERDOC_API_Version_1_1_1 :: _1_1;
    eRENDERDOC_API_Version_1_1_2 :: _1_2;
    eRENDERDOC_API_Version_1_2_0 :: _2_0;
    eRENDERDOC_API_Version_1_3_0 :: _3_0;
    eRENDERDOC_API_Version_1_4_0 :: _4_0;
    eRENDERDOC_API_Version_1_4_1 :: _4_1;
    eRENDERDOC_API_Version_1_4_2 :: _4_2;
    eRENDERDOC_API_Version_1_5_0 :: _5_0;
    eRENDERDOC_API_Version_1_6_0 :: _6_0;
}

// API version changelog:
//
// 1.0.0 - initial release
// 1.0.1 - Bugfix: IsFrameCapturing() was returning false for captures that were triggered
//         by keypress or TriggerCapture, instead of Start/EndFrameCapture.
// 1.0.2 - Refactor: Renamed eRENDERDOC_Option_DebugDeviceMode to eRENDERDOC_Option_APIValidation
// 1.1.0 - Add feature: TriggerMultiFrameCapture(). Backwards compatible with 1.0.x since the new
//         function pointer is added to the end of the struct, the original layout is identical
// 1.1.1 - Refactor: Renamed remote access to target control (to better disambiguate from remote
//         replay/remote server concept in replay UI)
// 1.1.2 - Refactor: Renamed "log file" in function names to just capture, to clarify that these
//         are captures and not debug logging files. This is the first API version in the v1.0
//         branch.
// 1.2.0 - Added feature: SetCaptureFileComments() to add comments to a capture file that will be
//         displayed in the UI program on load.
// 1.3.0 - Added feature: New capture option eRENDERDOC_Option_AllowUnsupportedVendorExtensions
//         which allows users to opt-in to allowing unsupported vendor extensions to function.
//         Should be used at the user's own risk.
//         Refactor: Renamed eRENDERDOC_Option_VerifyMapWrites to
//         eRENDERDOC_Option_VerifyBufferAccess, which now also controls initialisation to
//         0xdddddddd of uninitialised buffer contents.
// 1.4.0 - Added feature: DiscardFrameCapture() to discard a frame capture in progress and stop
//         capturing without saving anything to disk.
// 1.4.1 - Refactor: Renamed Shutdown to RemoveHooks to better clarify what is happening
// 1.4.2 - Refactor: Renamed 'draws' to 'actions' in callstack capture option.
// 1.5.0 - Added feature: ShowReplayUI() to request that the replay UI show itself if connected
// 1.6.0 - Added feature: SetCaptureTitle() which can be used to set a title for a
//         capture made with StartFrameCapture() or EndFrameCapture()
RENDERDOC_API_1_6_0 :: struct {
    GetAPIVersion:            pRENDERDOC_GetAPIVersion;

    SetCaptureOptionU32:      pRENDERDOC_SetCaptureOptionU32;
    SetCaptureOptionF32:      pRENDERDOC_SetCaptureOptionF32;

    GetCaptureOptionU32:      pRENDERDOC_GetCaptureOptionU32;
    GetCaptureOptionF32:      pRENDERDOC_GetCaptureOptionF32;

    SetFocusToggleKeys:       pRENDERDOC_SetFocusToggleKeys;
    SetCaptureKeys:           pRENDERDOC_SetCaptureKeys;

    GetOverlayBits:           pRENDERDOC_GetOverlayBits;
    MaskOverlayBits:          pRENDERDOC_MaskOverlayBits;

    // Shutdown was renamed to RemoveHooks in 1.4.1.
    // These unions allow old code to continue compiling without changes
    union {
        Shutdown:    pRENDERDOC_Shutdown;
        RemoveHooks: pRENDERDOC_RemoveHooks;
    }

    UnloadCrashHandler:       pRENDERDOC_UnloadCrashHandler;

    // Get/SetLogFilePathTemplate was renamed to Get/SetCaptureFilePathTemplate in 1.1.2.
    // These unions allow old code to continue compiling without changes
    union {
        // deprecated name
        SetLogFilePathTemplate:     pRENDERDOC_SetLogFilePathTemplate;

        // current name
        SetCaptureFilePathTemplate: pRENDERDOC_SetCaptureFilePathTemplate;
    }

    union {
        // deprecated name
        GetLogFilePathTemplate:     pRENDERDOC_GetLogFilePathTemplate;

        // current name
        GetCaptureFilePathTemplate: pRENDERDOC_GetCaptureFilePathTemplate;
    }

    GetNumCaptures:           pRENDERDOC_GetNumCaptures;
    GetCapture:               pRENDERDOC_GetCapture;

    TriggerCapture:           pRENDERDOC_TriggerCapture;

    // IsRemoteAccessConnected was renamed to IsTargetControlConnected in 1.1.1.
    // This union allows old code to continue compiling without changes
    union {
        // deprecated name
        IsRemoteAccessConnected:  pRENDERDOC_IsRemoteAccessConnected;

        // current name
        IsTargetControlConnected: pRENDERDOC_IsTargetControlConnected;
    }

    LaunchReplayUI:           pRENDERDOC_LaunchReplayUI;

    SetActiveWindow:          pRENDERDOC_SetActiveWindow;

    StartFrameCapture:        pRENDERDOC_StartFrameCapture;
    IsFrameCapturing:         pRENDERDOC_IsFrameCapturing;
    EndFrameCapture:          pRENDERDOC_EndFrameCapture;

    // new function in 1.1.0
    TriggerMultiFrameCapture: pRENDERDOC_TriggerMultiFrameCapture;

    // new function in 1.2.0
    SetCaptureFileComments:   pRENDERDOC_SetCaptureFileComments;

    // new function in 1.4.0
    DiscardFrameCapture:      pRENDERDOC_DiscardFrameCapture;

    // new function in 1.5.0
    ShowReplayUI:             pRENDERDOC_ShowReplayUI;

    // new function in 1.6.0
    SetCaptureTitle:          pRENDERDOC_SetCaptureTitle;
}

RENDERDOC_API_1_0_0 :: RENDERDOC_API_1_6_0;
RENDERDOC_API_1_0_1 :: RENDERDOC_API_1_6_0;
RENDERDOC_API_1_0_2 :: RENDERDOC_API_1_6_0;
RENDERDOC_API_1_1_0 :: RENDERDOC_API_1_6_0;
RENDERDOC_API_1_1_1 :: RENDERDOC_API_1_6_0;
RENDERDOC_API_1_1_2 :: RENDERDOC_API_1_6_0;
RENDERDOC_API_1_2_0 :: RENDERDOC_API_1_6_0;
RENDERDOC_API_1_3_0 :: RENDERDOC_API_1_6_0;
RENDERDOC_API_1_4_0 :: RENDERDOC_API_1_6_0;
RENDERDOC_API_1_4_1 :: RENDERDOC_API_1_6_0;
RENDERDOC_API_1_4_2 :: RENDERDOC_API_1_6_0;
RENDERDOC_API_1_5_0 :: RENDERDOC_API_1_6_0;

//////////////////////////////////////////////////////////////////////////////////////////////////
// RenderDoc API entry point
//
// This entry point can be obtained via GetProcAddress/dlsym if RenderDoc is available.
//
// The name is the same as the typedef - "RENDERDOC_GetAPI"
//
// This function is not thread safe, and should not be called on multiple threads at once.
// Ideally, call this once as early as possible in your application's startup, before doing
// any API work, since some configuration functionality etc has to be done also before
// initialising any APIs.
//
// Parameters:
//   version is a single value from the RENDERDOC_Version above.
//
//   outAPIPointers will be filled out with a pointer to the corresponding struct of function
//   pointers.
//
// Returns:
//   1 - if the outAPIPointers has been filled with a pointer to the API struct requested
//   0 - if the requested version is not supported or the arguments are invalid.
//
pRENDERDOC_GetAPI :: #type (version: RENDERDOC_Version, outAPIPointers: **void) -> s32 #c_call;

#scope_file

#import "Basic"; // For assert


#run {
    {
        info := type_info(RENDERDOC_API_1_6_0);
        for info.members {
            if it.name == {
                case "GetAPIVersion";
                    assert(it.offset_in_bytes == 0, "RENDERDOC_API_1_6_0.GetAPIVersion has unexpected offset % instead of 0", it.offset_in_bytes);
                    assert(it.type.runtime_size == 8, "RENDERDOC_API_1_6_0.GetAPIVersion has unexpected size % instead of 8", it.type.runtime_size);
                case "SetCaptureOptionU32";
                    assert(it.offset_in_bytes == 8, "RENDERDOC_API_1_6_0.SetCaptureOptionU32 has unexpected offset % instead of 8", it.offset_in_bytes);
                    assert(it.type.runtime_size == 8, "RENDERDOC_API_1_6_0.SetCaptureOptionU32 has unexpected size % instead of 8", it.type.runtime_size);
                case "SetCaptureOptionF32";
                    assert(it.offset_in_bytes == 16, "RENDERDOC_API_1_6_0.SetCaptureOptionF32 has unexpected offset % instead of 16", it.offset_in_bytes);
                    assert(it.type.runtime_size == 8, "RENDERDOC_API_1_6_0.SetCaptureOptionF32 has unexpected size % instead of 8", it.type.runtime_size);
                case "GetCaptureOptionU32";
                    assert(it.offset_in_bytes == 24, "RENDERDOC_API_1_6_0.GetCaptureOptionU32 has unexpected offset % instead of 24", it.offset_in_bytes);
                    assert(it.type.runtime_size == 8, "RENDERDOC_API_1_6_0.GetCaptureOptionU32 has unexpected size % instead of 8", it.type.runtime_size);
                case "GetCaptureOptionF32";
                    assert(it.offset_in_bytes == 32, "RENDERDOC_API_1_6_0.GetCaptureOptionF32 has unexpected offset % instead of 32", it.offset_in_bytes);
                    assert(it.type.runtime_size == 8, "RENDERDOC_API_1_6_0.GetCaptureOptionF32 has unexpected size % instead of 8", it.type.runtime_size);
                case "SetFocusToggleKeys";
                    assert(it.offset_in_bytes == 40, "RENDERDOC_API_1_6_0.SetFocusToggleKeys has unexpected offset % instead of 40", it.offset_in_bytes);
                    assert(it.type.runtime_size == 8, "RENDERDOC_API_1_6_0.SetFocusToggleKeys has unexpected size % instead of 8", it.type.runtime_size);
                case "SetCaptureKeys";
                    assert(it.offset_in_bytes == 48, "RENDERDOC_API_1_6_0.SetCaptureKeys has unexpected offset % instead of 48", it.offset_in_bytes);
                    assert(it.type.runtime_size == 8, "RENDERDOC_API_1_6_0.SetCaptureKeys has unexpected size % instead of 8", it.type.runtime_size);
                case "GetOverlayBits";
                    assert(it.offset_in_bytes == 56, "RENDERDOC_API_1_6_0.GetOverlayBits has unexpected offset % instead of 56", it.offset_in_bytes);
                    assert(it.type.runtime_size == 8, "RENDERDOC_API_1_6_0.GetOverlayBits has unexpected size % instead of 8", it.type.runtime_size);
                case "MaskOverlayBits";
                    assert(it.offset_in_bytes == 64, "RENDERDOC_API_1_6_0.MaskOverlayBits has unexpected offset % instead of 64", it.offset_in_bytes);
                    assert(it.type.runtime_size == 8, "RENDERDOC_API_1_6_0.MaskOverlayBits has unexpected size % instead of 8", it.type.runtime_size);
                case "UnloadCrashHandler";
                    assert(it.offset_in_bytes == 80, "RENDERDOC_API_1_6_0.UnloadCrashHandler has unexpected offset % instead of 80", it.offset_in_bytes);
                    assert(it.type.runtime_size == 8, "RENDERDOC_API_1_6_0.UnloadCrashHandler has unexpected size % instead of 8", it.type.runtime_size);
                case "GetNumCaptures";
                    assert(it.offset_in_bytes == 104, "RENDERDOC_API_1_6_0.GetNumCaptures has unexpected offset % instead of 104", it.offset_in_bytes);
                    assert(it.type.runtime_size == 8, "RENDERDOC_API_1_6_0.GetNumCaptures has unexpected size % instead of 8", it.type.runtime_size);
                case "GetCapture";
                    assert(it.offset_in_bytes == 112, "RENDERDOC_API_1_6_0.GetCapture has unexpected offset % instead of 112", it.offset_in_bytes);
                    assert(it.type.runtime_size == 8, "RENDERDOC_API_1_6_0.GetCapture has unexpected size % instead of 8", it.type.runtime_size);
                case "TriggerCapture";
                    assert(it.offset_in_bytes == 120, "RENDERDOC_API_1_6_0.TriggerCapture has unexpected offset % instead of 120", it.offset_in_bytes);
                    assert(it.type.runtime_size == 8, "RENDERDOC_API_1_6_0.TriggerCapture has unexpected size % instead of 8", it.type.runtime_size);
                case "LaunchReplayUI";
                    assert(it.offset_in_bytes == 136, "RENDERDOC_API_1_6_0.LaunchReplayUI has unexpected offset % instead of 136", it.offset_in_bytes);
                    assert(it.type.runtime_size == 8, "RENDERDOC_API_1_6_0.LaunchReplayUI has unexpected size % instead of 8", it.type.runtime_size);
                case "SetActiveWindow";
                    assert(it.offset_in_bytes == 144, "RENDERDOC_API_1_6_0.SetActiveWindow has unexpected offset % instead of 144", it.offset_in_bytes);
                    assert(it.type.runtime_size == 8, "RENDERDOC_API_1_6_0.SetActiveWindow has unexpected size % instead of 8", it.type.runtime_size);
                case "StartFrameCapture";
                    assert(it.offset_in_bytes == 152, "RENDERDOC_API_1_6_0.StartFrameCapture has unexpected offset % instead of 152", it.offset_in_bytes);
                    assert(it.type.runtime_size == 8, "RENDERDOC_API_1_6_0.StartFrameCapture has unexpected size % instead of 8", it.type.runtime_size);
                case "IsFrameCapturing";
                    assert(it.offset_in_bytes == 160, "RENDERDOC_API_1_6_0.IsFrameCapturing has unexpected offset % instead of 160", it.offset_in_bytes);
                    assert(it.type.runtime_size == 8, "RENDERDOC_API_1_6_0.IsFrameCapturing has unexpected size % instead of 8", it.type.runtime_size);
                case "EndFrameCapture";
                    assert(it.offset_in_bytes == 168, "RENDERDOC_API_1_6_0.EndFrameCapture has unexpected offset % instead of 168", it.offset_in_bytes);
                    assert(it.type.runtime_size == 8, "RENDERDOC_API_1_6_0.EndFrameCapture has unexpected size % instead of 8", it.type.runtime_size);
                case "TriggerMultiFrameCapture";
                    assert(it.offset_in_bytes == 176, "RENDERDOC_API_1_6_0.TriggerMultiFrameCapture has unexpected offset % instead of 176", it.offset_in_bytes);
                    assert(it.type.runtime_size == 8, "RENDERDOC_API_1_6_0.TriggerMultiFrameCapture has unexpected size % instead of 8", it.type.runtime_size);
                case "SetCaptureFileComments";
                    assert(it.offset_in_bytes == 184, "RENDERDOC_API_1_6_0.SetCaptureFileComments has unexpected offset % instead of 184", it.offset_in_bytes);
                    assert(it.type.runtime_size == 8, "RENDERDOC_API_1_6_0.SetCaptureFileComments has unexpected size % instead of 8", it.type.runtime_size);
                case "DiscardFrameCapture";
                    assert(it.offset_in_bytes == 192, "RENDERDOC_API_1_6_0.DiscardFrameCapture has unexpected offset % instead of 192", it.offset_in_bytes);
                    assert(it.type.runtime_size == 8, "RENDERDOC_API_1_6_0.DiscardFrameCapture has unexpected size % instead of 8", it.type.runtime_size);
                case "ShowReplayUI";
                    assert(it.offset_in_bytes == 200, "RENDERDOC_API_1_6_0.ShowReplayUI has unexpected offset % instead of 200", it.offset_in_bytes);
                    assert(it.type.runtime_size == 8, "RENDERDOC_API_1_6_0.ShowReplayUI has unexpected size % instead of 8", it.type.runtime_size);
                case "SetCaptureTitle";
                    assert(it.offset_in_bytes == 208, "RENDERDOC_API_1_6_0.SetCaptureTitle has unexpected offset % instead of 208", it.offset_in_bytes);
                    assert(it.type.runtime_size == 8, "RENDERDOC_API_1_6_0.SetCaptureTitle has unexpected size % instead of 8", it.type.runtime_size);
            }
        }
        assert(size_of(RENDERDOC_API_1_6_0) == 216, "RENDERDOC_API_1_6_0 has size % instead of 216", size_of(RENDERDOC_API_1_6_0));
    }
}

