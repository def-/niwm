 {.deadCodeElim: on.}
const 
  libX11* = "libX11.so"


const 
  XlibSpecificationRelease* = 6


type 
  XID* = culong
  Time* = culong
  Atom* = culong
  Pixmap* = XID
  Font* = XID
  GContext* = XID
  VisualID* = XID
  Window* = XID
  Colormap* = XID
  Cursor* = XID
  Drawable* = XID
  KeySym* = XID
  KeyCode* = cuchar
  XPrivDisplay* = object 
  

when defined(ISC) and defined(USE_XMBTOWC): 
  template wctomb*(a, b: expr): expr = 
    Xwctomb(a, b)

  template mblen*(a, b: expr): expr = 
    Xmblen(a, b)

  when not defined(USE_XWCHAR_STRING): 
    template mbtowc*(a, b, c: expr): expr = 
      Xmbtowc(a, b, c)

proc Xmblen*(str: cstring; len: cint): cint {.cdecl, importc: "_Xmblen", 
    dynlib: libX11.}

const 
  X_HAVE_UTF8_STRING* = 1


type 
  XPointer* = cstring


type 
  Bool* = cint
  Status* = cint

const 
  True* = 1
  False* = 0
  QueuedAlready* = 0
  QueuedAfterReading* = 1
  QueuedAfterFlush* = 2

template ConnectionNumber*(dpy: expr): expr = 
  ((cast[XPrivDisplay](dpy)).fd)

template RootWindow*(dpy, scr: expr): expr = 
  (ScreenOfDisplay(dpy, scr).root)

template DefaultScreen*(dpy: expr): expr = 
  ((cast[XPrivDisplay](dpy)).default_screen)

template DefaultRootWindow*(dpy: expr): expr = 
  (ScreenOfDisplay(dpy, DefaultScreen(dpy)).root)

template DefaultVisual*(dpy, scr: expr): expr = 
  (ScreenOfDisplay(dpy, scr).root_visual)

template DefaultGC*(dpy, scr: expr): expr = 
  (ScreenOfDisplay(dpy, scr).default_gc)

template BlackPixel*(dpy, scr: expr): expr = 
  (ScreenOfDisplay(dpy, scr).black_pixel)

template WhitePixel*(dpy, scr: expr): expr = 
  (ScreenOfDisplay(dpy, scr).white_pixel)


template QLength*(dpy: expr): expr = 
  ((cast[XPrivDisplay](dpy)).qlen)

template DisplayWidth*(dpy, scr: expr): expr = 
  (ScreenOfDisplay(dpy, scr).width)

template DisplayHeight*(dpy, scr: expr): expr = 
  (ScreenOfDisplay(dpy, scr).height)

template DisplayWidthMM*(dpy, scr: expr): expr = 
  (ScreenOfDisplay(dpy, scr).mwidth)

template DisplayHeightMM*(dpy, scr: expr): expr = 
  (ScreenOfDisplay(dpy, scr).mheight)

template DisplayPlanes*(dpy, scr: expr): expr = 
  (ScreenOfDisplay(dpy, scr).root_depth)

template DisplayCells*(dpy, scr: expr): expr = 
  (DefaultVisual(dpy, scr).map_entries)

template ScreenCount*(dpy: expr): expr = 
  ((cast[XPrivDisplay](dpy)).nscreens)

template ServerVendor*(dpy: expr): expr = 
  ((cast[XPrivDisplay](dpy)).vendor)

template ProtocolVersion*(dpy: expr): expr = 
  ((cast[XPrivDisplay](dpy)).proto_major_version)

template ProtocolRevision*(dpy: expr): expr = 
  ((cast[XPrivDisplay](dpy)).proto_minor_version)

template VendorRelease*(dpy: expr): expr = 
  ((cast[XPrivDisplay](dpy)).release)

template DisplayString*(dpy: expr): expr = 
  ((cast[XPrivDisplay](dpy)).display_name)

template DefaultDepth*(dpy, scr: expr): expr = 
  (ScreenOfDisplay(dpy, scr).root_depth)

template DefaultColormap*(dpy, scr: expr): expr = 
  (ScreenOfDisplay(dpy, scr).cmap)

template BitmapUnit*(dpy: expr): expr = 
  ((cast[XPrivDisplay](dpy)).bitmap_unit)

template BitmapBitOrder*(dpy: expr): expr = 
  ((cast[XPrivDisplay](dpy)).bitmap_bit_order)

template BitmapPad*(dpy: expr): expr = 
  ((cast[XPrivDisplay](dpy)).bitmap_pad)

template ImageByteOrder*(dpy: expr): expr = 
  ((cast[XPrivDisplay](dpy)).byte_order)

template NextRequest*(dpy: expr): expr = 
  ((cast[XPrivDisplay](dpy)).request + 1)

template LastKnownRequestProcessed*(dpy: expr): expr = 
  ((cast[XPrivDisplay](dpy)).last_request_read)


template ScreenOfDisplay*(dpy, scr: expr): expr = 
  (addr((cast[XPrivDisplay](dpy)).screens[scr]))

template DefaultScreenOfDisplay*(dpy: expr): expr = 
  ScreenOfDisplay(dpy, DefaultScreen(dpy))

template DisplayOfScreen*(s: expr): expr = 
  ((s).display)

template RootWindowOfScreen*(s: expr): expr = 
  ((s).root)

template BlackPixelOfScreen*(s: expr): expr = 
  ((s).black_pixel)

template WhitePixelOfScreen*(s: expr): expr = 
  ((s).white_pixel)

template DefaultColormapOfScreen*(s: expr): expr = 
  ((s).cmap)

template DefaultDepthOfScreen*(s: expr): expr = 
  ((s).root_depth)

template DefaultGCOfScreen*(s: expr): expr = 
  ((s).default_gc)

template DefaultVisualOfScreen*(s: expr): expr = 
  ((s).root_visual)

template WidthOfScreen*(s: expr): expr = 
  ((s).width)

template HeightOfScreen*(s: expr): expr = 
  ((s).height)

template WidthMMOfScreen*(s: expr): expr = 
  ((s).mwidth)

template HeightMMOfScreen*(s: expr): expr = 
  ((s).mheight)

template PlanesOfScreen*(s: expr): expr = 
  ((s).root_depth)

template CellsOfScreen*(s: expr): expr = 
  (DefaultVisualOfScreen((s)).map_entries)

template MinCmapsOfScreen*(s: expr): expr = 
  ((s).min_maps)

template MaxCmapsOfScreen*(s: expr): expr = 
  ((s).max_maps)

template DoesSaveUnders*(s: expr): expr = 
  ((s).save_unders)

template DoesBackingStore*(s: expr): expr = 
  ((s).backing_store)

template EventMaskOfScreen*(s: expr): expr = 
  ((s).root_input_mask)


type 
  XExtData* = object 
    number*: cint
    next*: ptr XExtData
    free_private*: proc (extension: ptr XExtData): cint {.cdecl.}
    private_data*: XPointer



type 
  XExtCodes* = object 
    extension*: cint
    major_opcode*: cint
    first_event*: cint
    first_error*: cint



type 
  XPixmapFormatValues* = object 
    depth*: cint
    bits_per_pixel*: cint
    scanline_pad*: cint



type 
  XGCValues* = object 
    function*: cint
    plane_mask*: culong
    foreground*: culong
    background*: culong
    line_width*: cint
    line_style*: cint
    cap_style*: cint
    join_style*: cint
    fill_style*: cint
    fill_rule*: cint
    arc_mode*: cint
    tile*: Pixmap
    stipple*: Pixmap
    ts_x_origin*: cint
    ts_y_origin*: cint
    font*: Font
    subwindow_mode*: cint
    graphics_exposures*: Bool
    clip_x_origin*: cint
    clip_y_origin*: cint
    clip_mask*: Pixmap
    dash_offset*: cint
    dashes*: char



type 
  GC* = object 
    ext_data*: ptr XExtData
    gid*: GContext



type 
  Visual* = object 
    ext_data*: ptr XExtData
    visualid*: VisualID
    class*: cint
    red_mask*: culong
    green_mask*: culong
    blue_mask*: culong
    bits_per_rgb*: cint
    map_entries*: cint



type 
  Depth* = object 
    depth*: cint
    nvisuals*: cint
    visuals*: ptr Visual



type 
  XDisplay* = object 
  


type 
  Screen* = object 
    ext_data*: ptr XExtData
    display*: ptr XDisplay
    root*: Window
    width*: cint
    height*: cint
    mwidth*: cint
    mheight*: cint
    ndepths*: cint
    depths*: ptr Depth
    root_depth*: cint
    root_visual*: ptr Visual
    default_gc*: GC
    cmap*: Colormap
    white_pixel*: culong
    black_pixel*: culong
    max_maps*: cint
    min_maps*: cint
    backing_store*: cint
    save_unders*: Bool
    root_input_mask*: clong



type 
  ScreenFormat* = object 
    ext_data*: ptr XExtData
    depth*: cint
    bits_per_pixel*: cint
    scanline_pad*: cint



type 
  XSetWindowAttributes* = object 
    background_pixmap*: Pixmap
    background_pixel*: culong
    border_pixmap*: Pixmap
    border_pixel*: culong
    bit_gravity*: cint
    win_gravity*: cint
    backing_store*: cint
    backing_planes*: culong
    backing_pixel*: culong
    save_under*: Bool
    event_mask*: clong
    do_not_propagate_mask*: clong
    override_redirect*: Bool
    colormap*: Colormap
    cursor*: Cursor

  XWindowAttributes* = object 
    x*: cint
    y*: cint
    width*: cint
    height*: cint
    border_width*: cint
    depth*: cint
    visual*: ptr Visual
    root*: Window
    class*: cint
    bit_gravity*: cint
    win_gravity*: cint
    backing_store*: cint
    backing_planes*: culong
    backing_pixel*: culong
    save_under*: Bool
    colormap*: Colormap
    map_installed*: Bool
    map_state*: cint
    all_event_masks*: clong
    your_event_mask*: clong
    do_not_propagate_mask*: clong
    override_redirect*: Bool
    screen*: ptr Screen



type 
  XHostAddress* = object 
    family*: cint
    length*: cint
    address*: cstring



type 
  XServerInterpretedAddress* = object 
    typelength*: cint
    valuelength*: cint
    `type`*: cstring
    value*: cstring



type 
  funcs_1770328818753709264* = object 
    create_image*: proc (a2: ptr XDisplay; a3: ptr Visual; a4: cuint; a5: cint; 
                         a6: cint; a7: cstring; a8: cuint; a9: cuint; a10: cint; 
                         a11: cint): ptr XImage {.cdecl.}
    destroy_image*: proc (a2: ptr XImage): cint {.cdecl.}
    get_pixel*: proc (a2: ptr XImage; a3: cint; a4: cint): culong {.cdecl.}
    put_pixel*: proc (a2: ptr XImage; a3: cint; a4: cint; a5: culong): cint {.
        cdecl.}
    sub_image*: proc (a2: ptr XImage; a3: cint; a4: cint; a5: cuint; a6: cuint): ptr XImage {.
        cdecl.}
    add_pixel*: proc (a2: ptr XImage; a3: clong): cint {.cdecl.}

  XImage* = object 
    width*: cint
    height*: cint
    xoffset*: cint
    format*: cint
    data*: cstring
    byte_order*: cint
    bitmap_unit*: cint
    bitmap_bit_order*: cint
    bitmap_pad*: cint
    depth*: cint
    bytes_per_line*: cint
    bits_per_pixel*: cint
    red_mask*: culong
    green_mask*: culong
    blue_mask*: culong
    obdata*: XPointer
    f*: funcs_1770328818753709264



type 
  XWindowChanges* = object 
    x*: cint
    y*: cint
    width*: cint
    height*: cint
    border_width*: cint
    sibling*: Window
    stack_mode*: cint



type 
  XColor* = object 
    pixel*: culong
    red*: cushort
    green*: cushort
    blue*: cushort
    flags*: char
    pad*: char



type 
  XSegment* = object 
    x1*: cshort
    y1*: cshort
    x2*: cshort
    y2*: cshort

  XPoint* = object 
    x*: cshort
    y*: cshort

  XRectangle* = object 
    x*: cshort
    y*: cshort
    width*: cushort
    height*: cushort

  XArc* = object 
    x*: cshort
    y*: cshort
    width*: cushort
    height*: cushort
    angle1*: cshort
    angle2*: cshort



type 
  XKeyboardControl* = object 
    key_click_percent*: cint
    bell_percent*: cint
    bell_pitch*: cint
    bell_duration*: cint
    led*: cint
    led_mode*: cint
    key*: cint
    auto_repeat_mode*: cint



type 
  XKeyboardState* = object 
    key_click_percent*: cint
    bell_percent*: cint
    bell_pitch*: cuint
    bell_duration*: cuint
    led_mask*: culong
    global_auto_repeat*: cint
    auto_repeats*: array[32, char]



type 
  XTimeCoord* = object 
    time*: Time
    x*: cshort
    y*: cshort



type 
  XModifierKeymap* = object 
    max_keypermod*: cint
    modifiermap*: ptr KeyCode



type 
  XPrivate* = object 
  


type 
  XrmHashBucketRec* = object 
  
  Display* = object 
    ext_data*: ptr XExtData
    private1*: ptr XPrivate
    fd*: cint
    private2*: cint
    proto_major_version*: cint
    proto_minor_version*: cint
    vendor*: cstring
    private3*: XID
    private4*: XID
    private5*: XID
    private6*: cint
    resource_alloc*: proc (a2: ptr XDisplay): XID {.cdecl.}
    byte_order*: cint
    bitmap_unit*: cint
    bitmap_pad*: cint
    bitmap_bit_order*: cint
    nformats*: cint
    pixmap_format*: ptr ScreenFormat
    private8*: cint
    release*: cint
    private9*: ptr XPrivate
    private10*: ptr XPrivate
    qlen*: cint
    last_request_read*: culong
    request*: culong
    private11*: XPointer
    private12*: XPointer
    private13*: XPointer
    private14*: XPointer
    max_request_size*: cuint
    db*: ptr XrmHashBucketRec
    private15*: proc (a2: ptr XDisplay): cint {.cdecl.}
    display_name*: cstring
    default_screen*: cint
    nscreens*: cint
    screens*: ptr Screen
    motion_buffer*: culong
    private16*: culong
    min_keycode*: cint
    max_keycode*: cint
    private17*: XPointer
    private18*: XPointer
    private19*: cint
    xdefaults*: cstring



type 
  XKeyEvent* = object 
    `type`*: cint
    serial*: culong
    send_event*: Bool
    display*: ptr Display
    window*: Window
    root*: Window
    subwindow*: Window
    time*: Time
    x*: cint
    y*: cint
    x_root*: cint
    y_root*: cint
    state*: cuint
    keycode*: cuint
    same_screen*: Bool

  XKeyPressedEvent* = XKeyEvent
  XKeyReleasedEvent* = XKeyEvent
  XButtonEvent* = object 
    `type`*: cint
    serial*: culong
    send_event*: Bool
    display*: ptr Display
    window*: Window
    root*: Window
    subwindow*: Window
    time*: Time
    x*: cint
    y*: cint
    x_root*: cint
    y_root*: cint
    state*: cuint
    button*: cuint
    same_screen*: Bool

  XButtonPressedEvent* = XButtonEvent
  XButtonReleasedEvent* = XButtonEvent
  XMotionEvent* = object 
    `type`*: cint
    serial*: culong
    send_event*: Bool
    display*: ptr Display
    window*: Window
    root*: Window
    subwindow*: Window
    time*: Time
    x*: cint
    y*: cint
    x_root*: cint
    y_root*: cint
    state*: cuint
    is_hint*: char
    same_screen*: Bool

  XPointerMovedEvent* = XMotionEvent
  XCrossingEvent* = object 
    `type`*: cint
    serial*: culong
    send_event*: Bool
    display*: ptr Display
    window*: Window
    root*: Window
    subwindow*: Window
    time*: Time
    x*: cint
    y*: cint
    x_root*: cint
    y_root*: cint
    mode*: cint
    detail*: cint
    same_screen*: Bool
    focus*: Bool
    state*: cuint

  XEnterWindowEvent* = XCrossingEvent
  XLeaveWindowEvent* = XCrossingEvent
  XFocusChangeEvent* = object 
    `type`*: cint
    serial*: culong
    send_event*: Bool
    display*: ptr Display
    window*: Window
    mode*: cint
    detail*: cint

  XFocusInEvent* = XFocusChangeEvent
  XFocusOutEvent* = XFocusChangeEvent


type 
  INNER_C_UNION_8753261598117319242* = object  {.union.}
    b*: array[20, char]
    s*: array[10, cshort]
    l*: array[5, clong]

  XKeymapEvent* = object 
    `type`*: cint
    serial*: culong
    send_event*: Bool
    display*: ptr Display
    window*: Window
    key_vector*: array[32, char]

  XExposeEvent* = object 
    `type`*: cint
    serial*: culong
    send_event*: Bool
    display*: ptr Display
    window*: Window
    x*: cint
    y*: cint
    width*: cint
    height*: cint
    count*: cint

  XGraphicsExposeEvent* = object 
    `type`*: cint
    serial*: culong
    send_event*: Bool
    display*: ptr Display
    drawable*: Drawable
    x*: cint
    y*: cint
    width*: cint
    height*: cint
    count*: cint
    major_code*: cint
    minor_code*: cint

  XNoExposeEvent* = object 
    `type`*: cint
    serial*: culong
    send_event*: Bool
    display*: ptr Display
    drawable*: Drawable
    major_code*: cint
    minor_code*: cint

  XVisibilityEvent* = object 
    `type`*: cint
    serial*: culong
    send_event*: Bool
    display*: ptr Display
    window*: Window
    state*: cint

  XCreateWindowEvent* = object 
    `type`*: cint
    serial*: culong
    send_event*: Bool
    display*: ptr Display
    parent*: Window
    window*: Window
    x*: cint
    y*: cint
    width*: cint
    height*: cint
    border_width*: cint
    override_redirect*: Bool

  XDestroyWindowEvent* = object 
    `type`*: cint
    serial*: culong
    send_event*: Bool
    display*: ptr Display
    event*: Window
    window*: Window

  XUnmapEvent* = object 
    `type`*: cint
    serial*: culong
    send_event*: Bool
    display*: ptr Display
    event*: Window
    window*: Window
    from_configure*: Bool

  XMapEvent* = object 
    `type`*: cint
    serial*: culong
    send_event*: Bool
    display*: ptr Display
    event*: Window
    window*: Window
    override_redirect*: Bool

  XMapRequestEvent* = object 
    `type`*: cint
    serial*: culong
    send_event*: Bool
    display*: ptr Display
    parent*: Window
    window*: Window

  XReparentEvent* = object 
    `type`*: cint
    serial*: culong
    send_event*: Bool
    display*: ptr Display
    event*: Window
    window*: Window
    parent*: Window
    x*: cint
    y*: cint
    override_redirect*: Bool

  XConfigureEvent* = object 
    `type`*: cint
    serial*: culong
    send_event*: Bool
    display*: ptr Display
    event*: Window
    window*: Window
    x*: cint
    y*: cint
    width*: cint
    height*: cint
    border_width*: cint
    above*: Window
    override_redirect*: Bool

  XGravityEvent* = object 
    `type`*: cint
    serial*: culong
    send_event*: Bool
    display*: ptr Display
    event*: Window
    window*: Window
    x*: cint
    y*: cint

  XResizeRequestEvent* = object 
    `type`*: cint
    serial*: culong
    send_event*: Bool
    display*: ptr Display
    window*: Window
    width*: cint
    height*: cint

  XConfigureRequestEvent* = object 
    `type`*: cint
    serial*: culong
    send_event*: Bool
    display*: ptr Display
    parent*: Window
    window*: Window
    x*: cint
    y*: cint
    width*: cint
    height*: cint
    border_width*: cint
    above*: Window
    detail*: cint
    value_mask*: culong

  XCirculateEvent* = object 
    `type`*: cint
    serial*: culong
    send_event*: Bool
    display*: ptr Display
    event*: Window
    window*: Window
    place*: cint

  XCirculateRequestEvent* = object 
    `type`*: cint
    serial*: culong
    send_event*: Bool
    display*: ptr Display
    parent*: Window
    window*: Window
    place*: cint

  XPropertyEvent* = object 
    `type`*: cint
    serial*: culong
    send_event*: Bool
    display*: ptr Display
    window*: Window
    atom*: Atom
    time*: Time
    state*: cint

  XSelectionClearEvent* = object 
    `type`*: cint
    serial*: culong
    send_event*: Bool
    display*: ptr Display
    window*: Window
    selection*: Atom
    time*: Time

  XSelectionRequestEvent* = object 
    `type`*: cint
    serial*: culong
    send_event*: Bool
    display*: ptr Display
    owner*: Window
    requestor*: Window
    selection*: Atom
    target*: Atom
    property*: Atom
    time*: Time

  XSelectionEvent* = object 
    `type`*: cint
    serial*: culong
    send_event*: Bool
    display*: ptr Display
    requestor*: Window
    selection*: Atom
    target*: Atom
    property*: Atom
    time*: Time

  XColormapEvent* = object 
    `type`*: cint
    serial*: culong
    send_event*: Bool
    display*: ptr Display
    window*: Window
    colormap*: Colormap
    new*: Bool
    state*: cint

  XClientMessageEvent* = object 
    `type`*: cint
    serial*: culong
    send_event*: Bool
    display*: ptr Display
    window*: Window
    message_type*: Atom
    format*: cint
    data*: INNER_C_UNION_8753261598117319242

  XMappingEvent* = object 
    `type`*: cint
    serial*: culong
    send_event*: Bool
    display*: ptr Display
    window*: Window
    request*: cint
    first_keycode*: cint
    count*: cint

  XErrorEvent* = object 
    `type`*: cint
    display*: ptr Display
    resourceid*: XID
    serial*: culong
    error_code*: cuchar
    request_code*: cuchar
    minor_code*: cuchar

  XAnyEvent* = object 
    `type`*: cint
    serial*: culong
    send_event*: Bool
    display*: ptr Display
    window*: Window



type 
  XGenericEvent* = object 
    `type`*: cint
    serial*: culong
    send_event*: Bool
    display*: ptr Display
    extension*: cint
    evtype*: cint

  XGenericEventCookie* = object 
    `type`*: cint
    serial*: culong
    send_event*: Bool
    display*: ptr Display
    extension*: cint
    evtype*: cint
    cookie*: cuint
    data*: pointer



type 
  XEvent* = object  {.union.}
    `type`*: cint
    xany*: XAnyEvent
    xkey*: XKeyEvent
    xbutton*: XButtonEvent
    xmotion*: XMotionEvent
    xcrossing*: XCrossingEvent
    xfocus*: XFocusChangeEvent
    xexpose*: XExposeEvent
    xgraphicsexpose*: XGraphicsExposeEvent
    xnoexpose*: XNoExposeEvent
    xvisibility*: XVisibilityEvent
    xcreatewindow*: XCreateWindowEvent
    xdestroywindow*: XDestroyWindowEvent
    xunmap*: XUnmapEvent
    xmap*: XMapEvent
    xmaprequest*: XMapRequestEvent
    xreparent*: XReparentEvent
    xconfigure*: XConfigureEvent
    xgravity*: XGravityEvent
    xresizerequest*: XResizeRequestEvent
    xconfigurerequest*: XConfigureRequestEvent
    xcirculate*: XCirculateEvent
    xcirculaterequest*: XCirculateRequestEvent
    xproperty*: XPropertyEvent
    xselectionclear*: XSelectionClearEvent
    xselectionrequest*: XSelectionRequestEvent
    xselection*: XSelectionEvent
    xcolormap*: XColormapEvent
    xclient*: XClientMessageEvent
    xmapping*: XMappingEvent
    xerror*: XErrorEvent
    xkeymap*: XKeymapEvent
    xgeneric*: XGenericEvent
    xcookie*: XGenericEventCookie
    pad*: array[24, clong]


template XAllocID*(dpy: expr): expr = 
  (((cast[XPrivDisplay](dpy)).resource_alloc[])((dpy)))


type 
  XCharStruct* = object 
    lbearing*: cshort
    rbearing*: cshort
    width*: cshort
    ascent*: cshort
    descent*: cshort
    attributes*: cushort



type 
  XFontProp* = object 
    name*: Atom
    card32*: culong

  XFontStruct* = object 
    ext_data*: ptr XExtData
    fid*: Font
    direction*: cuint
    min_char_or_byte2*: cuint
    max_char_or_byte2*: cuint
    min_byte1*: cuint
    max_byte1*: cuint
    all_chars_exist*: Bool
    default_char*: cuint
    n_properties*: cint
    properties*: ptr XFontProp
    min_bounds*: XCharStruct
    max_bounds*: XCharStruct
    per_char*: ptr XCharStruct
    ascent*: cint
    descent*: cint



type 
  XTextItem* = object 
    chars*: cstring
    nchars*: cint
    delta*: cint
    font*: Font

  XChar2b* = object 
    byte1*: cuchar
    byte2*: cuchar

  XTextItem16* = object 
    chars*: ptr XChar2b
    nchars*: cint
    delta*: cint
    font*: Font

  XEDataObject* = object  {.union.}
    display*: ptr Display
    gc*: GC
    visual*: ptr Visual
    screen*: ptr Screen
    pixmap_format*: ptr ScreenFormat
    font*: ptr XFontStruct

  XFontSetExtents* = object 
    max_ink_extent*: XRectangle
    max_logical_extent*: XRectangle



type 
  XOM* = object 
  
  XOC* = object 
  
  XFontSet* = ptr XOC
  XmbTextItem* = object 
    chars*: cstring
    nchars*: cint
    delta*: cint
    font_set*: XFontSet

  XwcTextItem* = object 
    chars*: cstring
    nchars*: cint
    delta*: cint
    font_set*: XFontSet


const 
  XNRequiredCharSet* = "requiredCharSet"
  XNQueryOrientation* = "queryOrientation"
  XNBaseFontName* = "baseFontName"
  XNOMAutomatic* = "omAutomatic"
  XNMissingCharSet* = "missingCharSet"
  XNDefaultString* = "defaultString"
  XNOrientation* = "orientation"
  XNDirectionalDependentDrawing* = "directionalDependentDrawing"
  XNContextualDrawing* = "contextualDrawing"
  XNFontInfo* = "fontInfo"

type 
  XOMCharSetList* = object 
    charset_count*: cint
    charset_list*: cstringArray

  XOrientation* {.size: sizeof(cint).} = enum 
    XOMOrientation_LTR_TTB, XOMOrientation_RTL_TTB, XOMOrientation_TTB_LTR, 
    XOMOrientation_TTB_RTL, XOMOrientation_Context
  XOMOrientation* = object 
    num_orientation*: cint
    orientation*: ptr XOrientation

  XOMFontInfo* = object 
    num_font*: cint
    font_struct_list*: ptr ptr XFontStruct
    font_name_list*: cstringArray




type 
  XIM* = object 
  
  XIC* = object 
  
  XIMProc* = proc (a2: XIM; a3: XPointer; a4: XPointer) {.cdecl.}
  XICProc* = proc (a2: XIC; a3: XPointer; a4: XPointer): Bool {.cdecl.}
  XIDProc* = proc (a2: ptr Display; a3: XPointer; a4: XPointer) {.cdecl.}
  XIMStyle* = culong
  XIMStyles* = object 
    count_styles*: cushort
    supported_styles*: ptr XIMStyle


const 
  XIMPreeditArea* = 0x00000001
  XIMPreeditCallbacks* = 0x00000002
  XIMPreeditPosition* = 0x00000004
  XIMPreeditNothing* = 0x00000008
  XIMPreeditNone* = 0x00000010
  XIMStatusArea* = 0x00000100
  XIMStatusCallbacks* = 0x00000200
  XIMStatusNothing* = 0x00000400
  XIMStatusNone* = 0x00000800
  XNVaNestedList* = "XNVaNestedList"
  XNQueryInputStyle* = "queryInputStyle"
  XNClientWindow* = "clientWindow"
  XNInputStyle* = "inputStyle"
  XNFocusWindow* = "focusWindow"
  XNResourceName* = "resourceName"
  XNResourceClass* = "resourceClass"
  XNGeometryCallback* = "geometryCallback"
  XNDestroyCallback* = "destroyCallback"
  XNFilterEvents* = "filterEvents"
  XNPreeditStartCallback* = "preeditStartCallback"
  XNPreeditDoneCallback* = "preeditDoneCallback"
  XNPreeditDrawCallback* = "preeditDrawCallback"
  XNPreeditCaretCallback* = "preeditCaretCallback"
  XNPreeditStateNotifyCallback* = "preeditStateNotifyCallback"
  XNPreeditAttributes* = "preeditAttributes"
  XNStatusStartCallback* = "statusStartCallback"
  XNStatusDoneCallback* = "statusDoneCallback"
  XNStatusDrawCallback* = "statusDrawCallback"
  XNStatusAttributes* = "statusAttributes"
  XNArea* = "area"
  XNAreaNeeded* = "areaNeeded"
  XNSpotLocation* = "spotLocation"
  XNColormap* = "colorMap"
  XNStdColormap* = "stdColorMap"
  XNForeground* = "foreground"
  XNBackground* = "background"
  XNBackgroundPixmap* = "backgroundPixmap"
  XNFontSet* = "fontSet"
  XNLineSpace* = "lineSpace"
  XNCursor* = "cursor"
  XNQueryIMValuesList* = "queryIMValuesList"
  XNQueryICValuesList* = "queryICValuesList"
  XNVisiblePosition* = "visiblePosition"
  XNR6PreeditCallback* = "r6PreeditCallback"
  XNStringConversionCallback* = "stringConversionCallback"
  XNStringConversion* = "stringConversion"
  XNResetState* = "resetState"
  XNHotKey* = "hotKey"
  XNHotKeyState* = "hotKeyState"
  XNPreeditState* = "preeditState"
  XNSeparatorofNestedList* = "separatorofNestedList"
  XBufferOverflow* = - 1
  XLookupNone* = 1
  XLookupChars* = 2
  XXLookupKeySym* = 3
  XLookupBoth* = 4

type 
  XVaNestedList* = pointer
  XIMCallback* = object 
    client_data*: XPointer
    callback*: XIMProc

  XICCallback* = object 
    client_data*: XPointer
    callback*: XICProc

  XIMFeedback* = culong

const 
  XIMReverse* = 1
  XIMUnderline* = (1 shl 1)
  XIMHighlight* = (1 shl 2)
  XIMPrimary* = (1 shl 5)
  XIMSecondary* = (1 shl 6)
  XIMTertiary* = (1 shl 7)
  XIMVisibleToForward* = (1 shl 8)
  XIMVisibleToBackword* = (1 shl 9)
  XIMVisibleToCenter* = (1 shl 10)

type 
  INNER_C_UNION_14444843517302524627* = object  {.union.}
    multi_byte*: cstring
    wide_char*: cstring

  XIMText* = object 
    length*: cushort
    feedback*: ptr XIMFeedback
    encoding_is_wchar*: Bool
    string*: INNER_C_UNION_14444843517302524627

  XIMPreeditState* = culong

const 
  XIMPreeditUnKnown* = 0
  XIMPreeditEnable* = 1
  XIMPreeditDisable* = (1 shl 1)

type 
  XIMPreeditStateNotifyCallbackStruct* = object 
    state*: XIMPreeditState

  XIMResetState* = culong

const 
  XIMInitialState* = 1
  XIMPreserveState* = (1 shl 1)

type 
  XIMStringConversionFeedback* = culong

const 
  XIMStringConversionLeftEdge* = (0x00000001)
  XIMStringConversionRightEdge* = (0x00000002)
  XIMStringConversionTopEdge* = (0x00000004)
  XIMStringConversionBottomEdge* = (0x00000008)
  XIMStringConversionConcealed* = (0x00000010)
  XIMStringConversionWrapped* = (0x00000020)

type 
  INNER_C_UNION_1247244991416548516* = object  {.union.}
    mbs*: cstring
    wcs*: cstring

  XIMStringConversionText* = object 
    length*: cushort
    feedback*: ptr XIMStringConversionFeedback
    encoding_is_wchar*: Bool
    string*: INNER_C_UNION_1247244991416548516

  XIMStringConversionPosition* = cushort
  XIMStringConversionType* = cushort

const 
  XIMStringConversionBuffer* = (0x00000001)
  XIMStringConversionLine* = (0x00000002)
  XIMStringConversionWord* = (0x00000003)
  XIMStringConversionChar* = (0x00000004)

type 
  XIMStringConversionOperation* = cushort

const 
  XIMStringConversionSubstitution* = (0x00000001)
  XIMStringConversionRetrieval* = (0x00000002)

type 
  INNER_C_UNION_6064744601235878808* = object  {.union.}
    text*: ptr XIMText
    bitmap*: Pixmap

  XIMCaretDirection* {.size: sizeof(cint).} = enum 
    XIMForwardChar, XIMBackwardChar, XIMForwardWord, XIMBackwardWord, 
    XIMCaretUp, XIMCaretDown, XIMNextLine, XIMPreviousLine, XIMLineStart, 
    XIMLineEnd, XIMAbsolutePosition, XIMDontChange
  XIMStringConversionCallbackStruct* = object 
    position*: XIMStringConversionPosition
    direction*: XIMCaretDirection
    operation*: XIMStringConversionOperation
    factor*: cushort
    text*: ptr XIMStringConversionText

  XIMPreeditDrawCallbackStruct* = object 
    caret*: cint
    chg_first*: cint
    chg_length*: cint
    text*: ptr XIMText

  XIMCaretStyle* {.size: sizeof(cint).} = enum 
    XIMIsInvisible, XIMIsPrimary, XIMIsSecondary
  XIMPreeditCaretCallbackStruct* = object 
    position*: cint
    direction*: XIMCaretDirection
    style*: XIMCaretStyle

  XIMStatusDataType* {.size: sizeof(cint).} = enum 
    XIMTextType, XIMBitmapType
  XIMStatusDrawCallbackStruct* = object 
    `type`*: XIMStatusDataType
    data*: INNER_C_UNION_6064744601235878808

  XIMHotKeyTrigger* = object 
    keysym*: KeySym
    modifier*: cint
    modifier_mask*: cint

  XIMHotKeyTriggers* = object 
    num_hot_key*: cint
    key*: ptr XIMHotKeyTrigger

  XIMHotKeyState* = culong




const 
  XIMHotKeyStateON* = (0x00000001)
  XIMHotKeyStateOFF* = (0x00000002)

type 
  XIMValuesList* = object 
    count_values*: cushort
    supported_values*: cstringArray


var Xdebug* {.importc: "_Xdebug", dynlib: libX11.}: cint

proc XLoadQueryFont*(a2: ptr Display; a3: cstring): ptr XFontStruct {.cdecl, 
    importc: "XLoadQueryFont", dynlib: libX11.}
proc XQueryFont*(a2: ptr Display; a3: XID): ptr XFontStruct {.cdecl, 
    importc: "XQueryFont", dynlib: libX11.}
proc XGetMotionEvents*(a2: ptr Display; a3: Window; a4: Time; a5: Time; 
                       a6: ptr cint): ptr XTimeCoord {.cdecl, 
    importc: "XGetMotionEvents", dynlib: libX11.}
proc XDeleteModifiermapEntry*(a2: ptr XModifierKeymap; a3: KeyCode; a4: cint): ptr XModifierKeymap {.
    cdecl, importc: "XDeleteModifiermapEntry", dynlib: libX11.}
proc XGetModifierMapping*(a2: ptr Display): ptr XModifierKeymap {.cdecl, 
    importc: "XGetModifierMapping", dynlib: libX11.}
proc XInsertModifiermapEntry*(a2: ptr XModifierKeymap; a3: KeyCode; a4: cint): ptr XModifierKeymap {.
    cdecl, importc: "XInsertModifiermapEntry", dynlib: libX11.}
proc XNewModifiermap*(a2: cint): ptr XModifierKeymap {.cdecl, 
    importc: "XNewModifiermap", dynlib: libX11.}
proc XCreateImage*(a2: ptr Display; a3: ptr Visual; a4: cuint; a5: cint; 
                   a6: cint; a7: cstring; a8: cuint; a9: cuint; a10: cint; 
                   a11: cint): ptr XImage {.cdecl, importc: "XCreateImage", 
    dynlib: libX11.}
proc XInitImage*(a2: ptr XImage): Status {.cdecl, importc: "XInitImage", 
    dynlib: libX11.}
proc XGetImage*(a2: ptr Display; a3: Drawable; a4: cint; a5: cint; a6: cuint; 
                a7: cuint; a8: culong; a9: cint): ptr XImage {.cdecl, 
    importc: "XGetImage", dynlib: libX11.}
proc XGetSubImage*(a2: ptr Display; a3: Drawable; a4: cint; a5: cint; a6: cuint; 
                   a7: cuint; a8: culong; a9: cint; a10: ptr XImage; a11: cint; 
                   a12: cint): ptr XImage {.cdecl, importc: "XGetSubImage", 
    dynlib: libX11.}

proc XOpenDisplay*(a2: cstring): ptr Display {.cdecl, importc: "XOpenDisplay", 
    dynlib: libX11.}
proc XrmInitialize*() {.cdecl, importc: "XrmInitialize", dynlib: libX11.}
proc XFetchBytes*(a2: ptr Display; a3: ptr cint): cstring {.cdecl, 
    importc: "XFetchBytes", dynlib: libX11.}
proc XFetchBuffer*(a2: ptr Display; a3: ptr cint; a4: cint): cstring {.cdecl, 
    importc: "XFetchBuffer", dynlib: libX11.}
proc XGetAtomName*(a2: ptr Display; a3: Atom): cstring {.cdecl, 
    importc: "XGetAtomName", dynlib: libX11.}
proc XGetAtomNames*(a2: ptr Display; a3: ptr Atom; a4: cint; a5: cstringArray): Status {.
    cdecl, importc: "XGetAtomNames", dynlib: libX11.}
proc XGetDefault*(a2: ptr Display; a3: cstring; a4: cstring): cstring {.cdecl, 
    importc: "XGetDefault", dynlib: libX11.}
proc XDisplayName*(a2: cstring): cstring {.cdecl, importc: "XDisplayName", 
    dynlib: libX11.}
proc XKeysymToString*(a2: KeySym): cstring {.cdecl, importc: "XKeysymToString", 
    dynlib: libX11.}

proc XInternAtom*(a2: ptr Display; a3: cstring; a4: Bool): Atom {.cdecl, 
    importc: "XInternAtom", dynlib: libX11.}
proc XInternAtoms*(a2: ptr Display; a3: cstringArray; a4: cint; a5: Bool; 
                   a6: ptr Atom): Status {.cdecl, importc: "XInternAtoms", 
    dynlib: libX11.}
proc XCopyColormapAndFree*(a2: ptr Display; a3: Colormap): Colormap {.cdecl, 
    importc: "XCopyColormapAndFree", dynlib: libX11.}
proc XCreateColormap*(a2: ptr Display; a3: Window; a4: ptr Visual; a5: cint): Colormap {.
    cdecl, importc: "XCreateColormap", dynlib: libX11.}
proc XCreatePixmapCursor*(a2: ptr Display; a3: Pixmap; a4: Pixmap; 
                          a5: ptr XColor; a6: ptr XColor; a7: cuint; a8: cuint): Cursor {.
    cdecl, importc: "XCreatePixmapCursor", dynlib: libX11.}
proc XCreateGlyphCursor*(a2: ptr Display; a3: Font; a4: Font; a5: cuint; 
                         a6: cuint; a7: ptr XColor; a8: ptr XColor): Cursor {.
    cdecl, importc: "XCreateGlyphCursor", dynlib: libX11.}
proc XCreateFontCursor*(a2: ptr Display; a3: cuint): Cursor {.cdecl, 
    importc: "XCreateFontCursor", dynlib: libX11.}
proc XLoadFont*(a2: ptr Display; a3: cstring): Font {.cdecl, 
    importc: "XLoadFont", dynlib: libX11.}
proc XCreateGC*(a2: ptr Display; a3: Drawable; a4: culong; a5: ptr XGCValues): GC {.
    cdecl, importc: "XCreateGC", dynlib: libX11.}
proc XGContextFromGC*(a2: GC): GContext {.cdecl, importc: "XGContextFromGC", 
    dynlib: libX11.}
proc XFlushGC*(a2: ptr Display; a3: GC) {.cdecl, importc: "XFlushGC", 
    dynlib: libX11.}
proc XCreatePixmap*(a2: ptr Display; a3: Drawable; a4: cuint; a5: cuint; 
                    a6: cuint): Pixmap {.cdecl, importc: "XCreatePixmap", 
    dynlib: libX11.}
proc XCreateBitmapFromData*(a2: ptr Display; a3: Drawable; a4: cstring; 
                            a5: cuint; a6: cuint): Pixmap {.cdecl, 
    importc: "XCreateBitmapFromData", dynlib: libX11.}
proc XCreatePixmapFromBitmapData*(a2: ptr Display; a3: Drawable; a4: cstring; 
                                  a5: cuint; a6: cuint; a7: culong; a8: culong; 
                                  a9: cuint): Pixmap {.cdecl, 
    importc: "XCreatePixmapFromBitmapData", dynlib: libX11.}
proc XCreateSimpleWindow*(a2: ptr Display; a3: Window; a4: cint; a5: cint; 
                          a6: cuint; a7: cuint; a8: cuint; a9: culong; 
                          a10: culong): Window {.cdecl, 
    importc: "XCreateSimpleWindow", dynlib: libX11.}
proc XGetSelectionOwner*(a2: ptr Display; a3: Atom): Window {.cdecl, 
    importc: "XGetSelectionOwner", dynlib: libX11.}
proc XCreateWindow*(a2: ptr Display; a3: Window; a4: cint; a5: cint; a6: cuint; 
                    a7: cuint; a8: cuint; a9: cint; a10: cuint; a11: ptr Visual; 
                    a12: culong; a13: ptr XSetWindowAttributes): Window {.cdecl, 
    importc: "XCreateWindow", dynlib: libX11.}
proc XListInstalledColormaps*(a2: ptr Display; a3: Window; a4: ptr cint): ptr Colormap {.
    cdecl, importc: "XListInstalledColormaps", dynlib: libX11.}
proc XListFonts*(a2: ptr Display; a3: cstring; a4: cint; a5: ptr cint): cstringArray {.
    cdecl, importc: "XListFonts", dynlib: libX11.}
proc XListFontsWithInfo*(a2: ptr Display; a3: cstring; a4: cint; a5: ptr cint; 
                         a6: ptr ptr XFontStruct): cstringArray {.cdecl, 
    importc: "XListFontsWithInfo", dynlib: libX11.}
proc XGetFontPath*(a2: ptr Display; a3: ptr cint): cstringArray {.cdecl, 
    importc: "XGetFontPath", dynlib: libX11.}
proc XListExtensions*(a2: ptr Display; a3: ptr cint): cstringArray {.cdecl, 
    importc: "XListExtensions", dynlib: libX11.}
proc XListProperties*(a2: ptr Display; a3: Window; a4: ptr cint): ptr Atom {.
    cdecl, importc: "XListProperties", dynlib: libX11.}
proc XListHosts*(a2: ptr Display; a3: ptr cint; a4: ptr Bool): ptr XHostAddress {.
    cdecl, importc: "XListHosts", dynlib: libX11.}
proc XKeycodeToKeysym*(a2: ptr Display; a3: KeyCode; a4: cint): KeySym {.cdecl, 
    importc: "XKeycodeToKeysym", dynlib: libX11.}
proc XLookupKeysym*(a2: ptr XKeyEvent; a3: cint): KeySym {.cdecl, 
    importc: "XLookupKeysym", dynlib: libX11.}
proc XGetKeyboardMapping*(a2: ptr Display; a3: KeyCode; a4: cint; a5: ptr cint): ptr KeySym {.
    cdecl, importc: "XGetKeyboardMapping", dynlib: libX11.}
proc XStringToKeysym*(a2: cstring): KeySym {.cdecl, importc: "XStringToKeysym", 
    dynlib: libX11.}
proc XMaxRequestSize*(a2: ptr Display): clong {.cdecl, 
    importc: "XMaxRequestSize", dynlib: libX11.}
proc XExtendedMaxRequestSize*(a2: ptr Display): clong {.cdecl, 
    importc: "XExtendedMaxRequestSize", dynlib: libX11.}
proc XResourceManagerString*(a2: ptr Display): cstring {.cdecl, 
    importc: "XResourceManagerString", dynlib: libX11.}
proc XScreenResourceString*(a2: ptr Screen): cstring {.cdecl, 
    importc: "XScreenResourceString", dynlib: libX11.}
proc XDisplayMotionBufferSize*(a2: ptr Display): culong {.cdecl, 
    importc: "XDisplayMotionBufferSize", dynlib: libX11.}
proc XVisualIDFromVisual*(a2: ptr Visual): VisualID {.cdecl, 
    importc: "XVisualIDFromVisual", dynlib: libX11.}

proc XInitThreads*(): Status {.cdecl, importc: "XInitThreads", dynlib: libX11.}
proc XLockDisplay*(a2: ptr Display) {.cdecl, importc: "XLockDisplay", 
                                      dynlib: libX11.}
proc XUnlockDisplay*(a2: ptr Display) {.cdecl, importc: "XUnlockDisplay", 
                                        dynlib: libX11.}

proc XInitExtension*(a2: ptr Display; a3: cstring): ptr XExtCodes {.cdecl, 
    importc: "XInitExtension", dynlib: libX11.}
proc XAddExtension*(a2: ptr Display): ptr XExtCodes {.cdecl, 
    importc: "XAddExtension", dynlib: libX11.}
proc XFindOnExtensionList*(a2: ptr ptr XExtData; a3: cint): ptr XExtData {.
    cdecl, importc: "XFindOnExtensionList", dynlib: libX11.}
proc XEHeadOfExtensionList*(a2: XEDataObject): ptr ptr XExtData {.cdecl, 
    importc: "XEHeadOfExtensionList", dynlib: libX11.}

proc XRootWindow*(a2: ptr Display; a3: cint): Window {.cdecl, 
    importc: "XRootWindow", dynlib: libX11.}
proc XDefaultRootWindow*(a2: ptr Display): Window {.cdecl, 
    importc: "XDefaultRootWindow", dynlib: libX11.}
proc XRootWindowOfScreen*(a2: ptr Screen): Window {.cdecl, 
    importc: "XRootWindowOfScreen", dynlib: libX11.}
proc XDefaultVisual*(a2: ptr Display; a3: cint): ptr Visual {.cdecl, 
    importc: "XDefaultVisual", dynlib: libX11.}
proc XDefaultVisualOfScreen*(a2: ptr Screen): ptr Visual {.cdecl, 
    importc: "XDefaultVisualOfScreen", dynlib: libX11.}
proc XDefaultGC*(a2: ptr Display; a3: cint): GC {.cdecl, importc: "XDefaultGC", 
    dynlib: libX11.}
proc XDefaultGCOfScreen*(a2: ptr Screen): GC {.cdecl, 
    importc: "XDefaultGCOfScreen", dynlib: libX11.}
proc XBlackPixel*(a2: ptr Display; a3: cint): culong {.cdecl, 
    importc: "XBlackPixel", dynlib: libX11.}
proc XWhitePixel*(a2: ptr Display; a3: cint): culong {.cdecl, 
    importc: "XWhitePixel", dynlib: libX11.}
proc XAllPlanes*(): culong {.cdecl, importc: "XAllPlanes", dynlib: libX11.}
proc XBlackPixelOfScreen*(a2: ptr Screen): culong {.cdecl, 
    importc: "XBlackPixelOfScreen", dynlib: libX11.}
proc XWhitePixelOfScreen*(a2: ptr Screen): culong {.cdecl, 
    importc: "XWhitePixelOfScreen", dynlib: libX11.}
proc XNextRequest*(a2: ptr Display): culong {.cdecl, importc: "XNextRequest", 
    dynlib: libX11.}
proc XLastKnownRequestProcessed*(a2: ptr Display): culong {.cdecl, 
    importc: "XLastKnownRequestProcessed", dynlib: libX11.}
proc XServerVendor*(a2: ptr Display): cstring {.cdecl, importc: "XServerVendor", 
    dynlib: libX11.}
proc XDisplayString*(a2: ptr Display): cstring {.cdecl, 
    importc: "XDisplayString", dynlib: libX11.}
proc XDefaultColormap*(a2: ptr Display; a3: cint): Colormap {.cdecl, 
    importc: "XDefaultColormap", dynlib: libX11.}
proc XDefaultColormapOfScreen*(a2: ptr Screen): Colormap {.cdecl, 
    importc: "XDefaultColormapOfScreen", dynlib: libX11.}
proc XDisplayOfScreen*(a2: ptr Screen): ptr Display {.cdecl, 
    importc: "XDisplayOfScreen", dynlib: libX11.}
proc XScreenOfDisplay*(a2: ptr Display; a3: cint): ptr Screen {.cdecl, 
    importc: "XScreenOfDisplay", dynlib: libX11.}
proc XDefaultScreenOfDisplay*(a2: ptr Display): ptr Screen {.cdecl, 
    importc: "XDefaultScreenOfDisplay", dynlib: libX11.}
proc XEventMaskOfScreen*(a2: ptr Screen): clong {.cdecl, 
    importc: "XEventMaskOfScreen", dynlib: libX11.}
proc XScreenNumberOfScreen*(a2: ptr Screen): cint {.cdecl, 
    importc: "XScreenNumberOfScreen", dynlib: libX11.}
type 
  XErrorHandler* = proc (a2: ptr Display; a3: ptr XErrorEvent): cint {.cdecl.}

proc XSetErrorHandler*(a2: XErrorHandler): XErrorHandler {.cdecl, 
    importc: "XSetErrorHandler", dynlib: libX11.}
type 
  XIOErrorHandler* = proc (a2: ptr Display): cint {.cdecl.}

proc XSetIOErrorHandler*(a2: XIOErrorHandler): XIOErrorHandler {.cdecl, 
    importc: "XSetIOErrorHandler", dynlib: libX11.}
proc XListPixmapFormats*(a2: ptr Display; a3: ptr cint): ptr XPixmapFormatValues {.
    cdecl, importc: "XListPixmapFormats", dynlib: libX11.}
proc XListDepths*(a2: ptr Display; a3: cint; a4: ptr cint): ptr cint {.cdecl, 
    importc: "XListDepths", dynlib: libX11.}

proc XReconfigureWMWindow*(a2: ptr Display; a3: Window; a4: cint; a5: cuint; 
                           a6: ptr XWindowChanges): Status {.cdecl, 
    importc: "XReconfigureWMWindow", dynlib: libX11.}
proc XGetWMProtocols*(a2: ptr Display; a3: Window; a4: ptr ptr Atom; 
                      a5: ptr cint): Status {.cdecl, importc: "XGetWMProtocols", 
    dynlib: libX11.}
proc XSetWMProtocols*(a2: ptr Display; a3: Window; a4: ptr Atom; a5: cint): Status {.
    cdecl, importc: "XSetWMProtocols", dynlib: libX11.}
proc XIconifyWindow*(a2: ptr Display; a3: Window; a4: cint): Status {.cdecl, 
    importc: "XIconifyWindow", dynlib: libX11.}
proc XWithdrawWindow*(a2: ptr Display; a3: Window; a4: cint): Status {.cdecl, 
    importc: "XWithdrawWindow", dynlib: libX11.}
proc XGetCommand*(a2: ptr Display; a3: Window; a4: ptr cstringArray; 
                  a5: ptr cint): Status {.cdecl, importc: "XGetCommand", 
    dynlib: libX11.}
proc XGetWMColormapWindows*(a2: ptr Display; a3: Window; a4: ptr ptr Window; 
                            a5: ptr cint): Status {.cdecl, 
    importc: "XGetWMColormapWindows", dynlib: libX11.}
proc XSetWMColormapWindows*(a2: ptr Display; a3: Window; a4: ptr Window; 
                            a5: cint): Status {.cdecl, 
    importc: "XSetWMColormapWindows", dynlib: libX11.}
proc XFreeStringList*(a2: cstringArray) {.cdecl, importc: "XFreeStringList", 
    dynlib: libX11.}
proc XSetTransientForHint*(a2: ptr Display; a3: Window; a4: Window): cint {.
    cdecl, importc: "XSetTransientForHint", dynlib: libX11.}

proc XActivateScreenSaver*(a2: ptr Display): cint {.cdecl, 
    importc: "XActivateScreenSaver", dynlib: libX11.}
proc XAddHost*(a2: ptr Display; a3: ptr XHostAddress): cint {.cdecl, 
    importc: "XAddHost", dynlib: libX11.}
proc XAddHosts*(a2: ptr Display; a3: ptr XHostAddress; a4: cint): cint {.cdecl, 
    importc: "XAddHosts", dynlib: libX11.}
proc XAddToExtensionList*(a2: ptr ptr XExtData; a3: ptr XExtData): cint {.cdecl, 
    importc: "XAddToExtensionList", dynlib: libX11.}
proc XAddToSaveSet*(a2: ptr Display; a3: Window): cint {.cdecl, 
    importc: "XAddToSaveSet", dynlib: libX11.}
proc XAllocColor*(a2: ptr Display; a3: Colormap; a4: ptr XColor): Status {.
    cdecl, importc: "XAllocColor", dynlib: libX11.}
proc XAllocColorCells*(a2: ptr Display; a3: Colormap; a4: Bool; a5: ptr culong; 
                       a6: cuint; a7: ptr culong; a8: cuint): Status {.cdecl, 
    importc: "XAllocColorCells", dynlib: libX11.}
proc XAllocColorPlanes*(a2: ptr Display; a3: Colormap; a4: Bool; a5: ptr culong; 
                        a6: cint; a7: cint; a8: cint; a9: cint; a10: ptr culong; 
                        a11: ptr culong; a12: ptr culong): Status {.cdecl, 
    importc: "XAllocColorPlanes", dynlib: libX11.}
proc XAllocNamedColor*(a2: ptr Display; a3: Colormap; a4: cstring; 
                       a5: ptr XColor; a6: ptr XColor): Status {.cdecl, 
    importc: "XAllocNamedColor", dynlib: libX11.}
proc XAllowEvents*(a2: ptr Display; a3: cint; a4: Time): cint {.cdecl, 
    importc: "XAllowEvents", dynlib: libX11.}
proc XAutoRepeatOff*(a2: ptr Display): cint {.cdecl, importc: "XAutoRepeatOff", 
    dynlib: libX11.}
proc XAutoRepeatOn*(a2: ptr Display): cint {.cdecl, importc: "XAutoRepeatOn", 
    dynlib: libX11.}
proc XBell*(a2: ptr Display; a3: cint): cint {.cdecl, importc: "XBell", 
    dynlib: libX11.}
proc XBitmapBitOrder*(a2: ptr Display): cint {.cdecl, 
    importc: "XBitmapBitOrder", dynlib: libX11.}
proc XBitmapPad*(a2: ptr Display): cint {.cdecl, importc: "XBitmapPad", 
    dynlib: libX11.}
proc XBitmapUnit*(a2: ptr Display): cint {.cdecl, importc: "XBitmapUnit", 
    dynlib: libX11.}
proc XCellsOfScreen*(a2: ptr Screen): cint {.cdecl, importc: "XCellsOfScreen", 
    dynlib: libX11.}
proc XChangeActivePointerGrab*(a2: ptr Display; a3: cuint; a4: Cursor; a5: Time): cint {.
    cdecl, importc: "XChangeActivePointerGrab", dynlib: libX11.}
proc XChangeGC*(a2: ptr Display; a3: GC; a4: culong; a5: ptr XGCValues): cint {.
    cdecl, importc: "XChangeGC", dynlib: libX11.}
proc XChangeKeyboardControl*(a2: ptr Display; a3: culong; 
                             a4: ptr XKeyboardControl): cint {.cdecl, 
    importc: "XChangeKeyboardControl", dynlib: libX11.}
proc XChangeKeyboardMapping*(a2: ptr Display; a3: cint; a4: cint; 
                             a5: ptr KeySym; a6: cint): cint {.cdecl, 
    importc: "XChangeKeyboardMapping", dynlib: libX11.}
proc XChangePointerControl*(a2: ptr Display; a3: Bool; a4: Bool; a5: cint; 
                            a6: cint; a7: cint): cint {.cdecl, 
    importc: "XChangePointerControl", dynlib: libX11.}
proc XChangeProperty*(a2: ptr Display; a3: Window; a4: Atom; a5: Atom; a6: cint; 
                      a7: cint; a8: ptr cuchar; a9: cint): cint {.cdecl, 
    importc: "XChangeProperty", dynlib: libX11.}
proc XChangeSaveSet*(a2: ptr Display; a3: Window; a4: cint): cint {.cdecl, 
    importc: "XChangeSaveSet", dynlib: libX11.}
proc XChangeWindowAttributes*(a2: ptr Display; a3: Window; a4: culong; 
                              a5: ptr XSetWindowAttributes): cint {.cdecl, 
    importc: "XChangeWindowAttributes", dynlib: libX11.}
proc XCheckIfEvent*(a2: ptr Display; a3: ptr XEvent; a4: proc (a2: ptr Display; 
    a3: ptr XEvent; a4: XPointer): Bool {.cdecl.}; a5: XPointer): Bool {.cdecl, 
    importc: "XCheckIfEvent", dynlib: libX11.}
proc XCheckMaskEvent*(a2: ptr Display; a3: clong; a4: ptr XEvent): Bool {.cdecl, 
    importc: "XCheckMaskEvent", dynlib: libX11.}
proc XCheckTypedEvent*(a2: ptr Display; a3: cint; a4: ptr XEvent): Bool {.cdecl, 
    importc: "XCheckTypedEvent", dynlib: libX11.}
proc XCheckTypedWindowEvent*(a2: ptr Display; a3: Window; a4: cint; 
                             a5: ptr XEvent): Bool {.cdecl, 
    importc: "XCheckTypedWindowEvent", dynlib: libX11.}
proc XCheckWindowEvent*(a2: ptr Display; a3: Window; a4: clong; a5: ptr XEvent): Bool {.
    cdecl, importc: "XCheckWindowEvent", dynlib: libX11.}
proc XCirculateSubwindows*(a2: ptr Display; a3: Window; a4: cint): cint {.cdecl, 
    importc: "XCirculateSubwindows", dynlib: libX11.}
proc XCirculateSubwindowsDown*(a2: ptr Display; a3: Window): cint {.cdecl, 
    importc: "XCirculateSubwindowsDown", dynlib: libX11.}
proc XCirculateSubwindowsUp*(a2: ptr Display; a3: Window): cint {.cdecl, 
    importc: "XCirculateSubwindowsUp", dynlib: libX11.}
proc XClearArea*(a2: ptr Display; a3: Window; a4: cint; a5: cint; a6: cuint; 
                 a7: cuint; a8: Bool): cint {.cdecl, importc: "XClearArea", 
    dynlib: libX11.}
proc XClearWindow*(a2: ptr Display; a3: Window): cint {.cdecl, 
    importc: "XClearWindow", dynlib: libX11.}
proc XCloseDisplay*(a2: ptr Display): cint {.cdecl, importc: "XCloseDisplay", 
    dynlib: libX11.}
proc XConfigureWindow*(a2: ptr Display; a3: Window; a4: cuint; 
                       a5: ptr XWindowChanges): cint {.cdecl, 
    importc: "XConfigureWindow", dynlib: libX11.}
proc XConnectionNumber*(a2: ptr Display): cint {.cdecl, 
    importc: "XConnectionNumber", dynlib: libX11.}
proc XConvertSelection*(a2: ptr Display; a3: Atom; a4: Atom; a5: Atom; 
                        a6: Window; a7: Time): cint {.cdecl, 
    importc: "XConvertSelection", dynlib: libX11.}
proc XCopyArea*(a2: ptr Display; a3: Drawable; a4: Drawable; a5: GC; a6: cint; 
                a7: cint; a8: cuint; a9: cuint; a10: cint; a11: cint): cint {.
    cdecl, importc: "XCopyArea", dynlib: libX11.}
proc XCopyGC*(a2: ptr Display; a3: GC; a4: culong; a5: GC): cint {.cdecl, 
    importc: "XCopyGC", dynlib: libX11.}
proc XCopyPlane*(a2: ptr Display; a3: Drawable; a4: Drawable; a5: GC; a6: cint; 
                 a7: cint; a8: cuint; a9: cuint; a10: cint; a11: cint; 
                 a12: culong): cint {.cdecl, importc: "XCopyPlane", 
                                      dynlib: libX11.}
proc XDefaultDepth*(a2: ptr Display; a3: cint): cint {.cdecl, 
    importc: "XDefaultDepth", dynlib: libX11.}
proc XDefaultDepthOfScreen*(a2: ptr Screen): cint {.cdecl, 
    importc: "XDefaultDepthOfScreen", dynlib: libX11.}
proc XDefaultScreen*(a2: ptr Display): cint {.cdecl, importc: "XDefaultScreen", 
    dynlib: libX11.}
proc XDefineCursor*(a2: ptr Display; a3: Window; a4: Cursor): cint {.cdecl, 
    importc: "XDefineCursor", dynlib: libX11.}
proc XDeleteProperty*(a2: ptr Display; a3: Window; a4: Atom): cint {.cdecl, 
    importc: "XDeleteProperty", dynlib: libX11.}
proc XDestroyWindow*(a2: ptr Display; a3: Window): cint {.cdecl, 
    importc: "XDestroyWindow", dynlib: libX11.}
proc XDestroySubwindows*(a2: ptr Display; a3: Window): cint {.cdecl, 
    importc: "XDestroySubwindows", dynlib: libX11.}
proc XDoesBackingStore*(a2: ptr Screen): cint {.cdecl, 
    importc: "XDoesBackingStore", dynlib: libX11.}
proc XDoesSaveUnders*(a2: ptr Screen): Bool {.cdecl, importc: "XDoesSaveUnders", 
    dynlib: libX11.}
proc XDisableAccessControl*(a2: ptr Display): cint {.cdecl, 
    importc: "XDisableAccessControl", dynlib: libX11.}
proc XDisplayCells*(a2: ptr Display; a3: cint): cint {.cdecl, 
    importc: "XDisplayCells", dynlib: libX11.}
proc XDisplayHeight*(a2: ptr Display; a3: cint): cint {.cdecl, 
    importc: "XDisplayHeight", dynlib: libX11.}
proc XDisplayHeightMM*(a2: ptr Display; a3: cint): cint {.cdecl, 
    importc: "XDisplayHeightMM", dynlib: libX11.}
proc XDisplayKeycodes*(a2: ptr Display; a3: ptr cint; a4: ptr cint): cint {.
    cdecl, importc: "XDisplayKeycodes", dynlib: libX11.}
proc XDisplayPlanes*(a2: ptr Display; a3: cint): cint {.cdecl, 
    importc: "XDisplayPlanes", dynlib: libX11.}
proc XDisplayWidth*(a2: ptr Display; a3: cint): cint {.cdecl, 
    importc: "XDisplayWidth", dynlib: libX11.}
proc XDisplayWidthMM*(a2: ptr Display; a3: cint): cint {.cdecl, 
    importc: "XDisplayWidthMM", dynlib: libX11.}
proc XDrawArc*(a2: ptr Display; a3: Drawable; a4: GC; a5: cint; a6: cint; 
               a7: cuint; a8: cuint; a9: cint; a10: cint): cint {.cdecl, 
    importc: "XDrawArc", dynlib: libX11.}
proc XDrawArcs*(a2: ptr Display; a3: Drawable; a4: GC; a5: ptr XArc; a6: cint): cint {.
    cdecl, importc: "XDrawArcs", dynlib: libX11.}
proc XDrawImageString*(a2: ptr Display; a3: Drawable; a4: GC; a5: cint; 
                       a6: cint; a7: cstring; a8: cint): cint {.cdecl, 
    importc: "XDrawImageString", dynlib: libX11.}
proc XDrawImageString16*(a2: ptr Display; a3: Drawable; a4: GC; a5: cint; 
                         a6: cint; a7: ptr XChar2b; a8: cint): cint {.cdecl, 
    importc: "XDrawImageString16", dynlib: libX11.}
proc XDrawLine*(a2: ptr Display; a3: Drawable; a4: GC; a5: cint; a6: cint; 
                a7: cint; a8: cint): cint {.cdecl, importc: "XDrawLine", 
    dynlib: libX11.}
proc XDrawLines*(a2: ptr Display; a3: Drawable; a4: GC; a5: ptr XPoint; 
                 a6: cint; a7: cint): cint {.cdecl, importc: "XDrawLines", 
    dynlib: libX11.}
proc XDrawPoint*(a2: ptr Display; a3: Drawable; a4: GC; a5: cint; a6: cint): cint {.
    cdecl, importc: "XDrawPoint", dynlib: libX11.}
proc XDrawPoints*(a2: ptr Display; a3: Drawable; a4: GC; a5: ptr XPoint; 
                  a6: cint; a7: cint): cint {.cdecl, importc: "XDrawPoints", 
    dynlib: libX11.}
proc XDrawRectangle*(a2: ptr Display; a3: Drawable; a4: GC; a5: cint; a6: cint; 
                     a7: cuint; a8: cuint): cint {.cdecl, 
    importc: "XDrawRectangle", dynlib: libX11.}
proc XDrawRectangles*(a2: ptr Display; a3: Drawable; a4: GC; a5: ptr XRectangle; 
                      a6: cint): cint {.cdecl, importc: "XDrawRectangles", 
                                        dynlib: libX11.}
proc XDrawSegments*(a2: ptr Display; a3: Drawable; a4: GC; a5: ptr XSegment; 
                    a6: cint): cint {.cdecl, importc: "XDrawSegments", 
                                      dynlib: libX11.}
proc XDrawString*(a2: ptr Display; a3: Drawable; a4: GC; a5: cint; a6: cint; 
                  a7: cstring; a8: cint): cint {.cdecl, importc: "XDrawString", 
    dynlib: libX11.}
proc XDrawString16*(a2: ptr Display; a3: Drawable; a4: GC; a5: cint; a6: cint; 
                    a7: ptr XChar2b; a8: cint): cint {.cdecl, 
    importc: "XDrawString16", dynlib: libX11.}
proc XDrawText*(a2: ptr Display; a3: Drawable; a4: GC; a5: cint; a6: cint; 
                a7: ptr XTextItem; a8: cint): cint {.cdecl, 
    importc: "XDrawText", dynlib: libX11.}
proc XDrawText16*(a2: ptr Display; a3: Drawable; a4: GC; a5: cint; a6: cint; 
                  a7: ptr XTextItem16; a8: cint): cint {.cdecl, 
    importc: "XDrawText16", dynlib: libX11.}
proc XEnableAccessControl*(a2: ptr Display): cint {.cdecl, 
    importc: "XEnableAccessControl", dynlib: libX11.}
proc XEventsQueued*(a2: ptr Display; a3: cint): cint {.cdecl, 
    importc: "XEventsQueued", dynlib: libX11.}
proc XFetchName*(a2: ptr Display; a3: Window; a4: cstringArray): Status {.cdecl, 
    importc: "XFetchName", dynlib: libX11.}
proc XFillArc*(a2: ptr Display; a3: Drawable; a4: GC; a5: cint; a6: cint; 
               a7: cuint; a8: cuint; a9: cint; a10: cint): cint {.cdecl, 
    importc: "XFillArc", dynlib: libX11.}
proc XFillArcs*(a2: ptr Display; a3: Drawable; a4: GC; a5: ptr XArc; a6: cint): cint {.
    cdecl, importc: "XFillArcs", dynlib: libX11.}
proc XFillPolygon*(a2: ptr Display; a3: Drawable; a4: GC; a5: ptr XPoint; 
                   a6: cint; a7: cint; a8: cint): cint {.cdecl, 
    importc: "XFillPolygon", dynlib: libX11.}
proc XFillRectangle*(a2: ptr Display; a3: Drawable; a4: GC; a5: cint; a6: cint; 
                     a7: cuint; a8: cuint): cint {.cdecl, 
    importc: "XFillRectangle", dynlib: libX11.}
proc XFillRectangles*(a2: ptr Display; a3: Drawable; a4: GC; a5: ptr XRectangle; 
                      a6: cint): cint {.cdecl, importc: "XFillRectangles", 
                                        dynlib: libX11.}
proc XFlush*(a2: ptr Display): cint {.cdecl, importc: "XFlush", dynlib: libX11.}
proc XForceScreenSaver*(a2: ptr Display; a3: cint): cint {.cdecl, 
    importc: "XForceScreenSaver", dynlib: libX11.}
proc XFree*(a2: pointer): cint {.cdecl, importc: "XFree", dynlib: libX11.}
proc XFreeColormap*(a2: ptr Display; a3: Colormap): cint {.cdecl, 
    importc: "XFreeColormap", dynlib: libX11.}
proc XFreeColors*(a2: ptr Display; a3: Colormap; a4: ptr culong; a5: cint; 
                  a6: culong): cint {.cdecl, importc: "XFreeColors", 
                                      dynlib: libX11.}
proc XFreeCursor*(a2: ptr Display; a3: Cursor): cint {.cdecl, 
    importc: "XFreeCursor", dynlib: libX11.}
proc XFreeExtensionList*(a2: cstringArray): cint {.cdecl, 
    importc: "XFreeExtensionList", dynlib: libX11.}
proc XFreeFont*(a2: ptr Display; a3: ptr XFontStruct): cint {.cdecl, 
    importc: "XFreeFont", dynlib: libX11.}
proc XFreeFontInfo*(a2: cstringArray; a3: ptr XFontStruct; a4: cint): cint {.
    cdecl, importc: "XFreeFontInfo", dynlib: libX11.}
proc XFreeFontNames*(a2: cstringArray): cint {.cdecl, importc: "XFreeFontNames", 
    dynlib: libX11.}
proc XFreeFontPath*(a2: cstringArray): cint {.cdecl, importc: "XFreeFontPath", 
    dynlib: libX11.}
proc XFreeGC*(a2: ptr Display; a3: GC): cint {.cdecl, importc: "XFreeGC", 
    dynlib: libX11.}
proc XFreeModifiermap*(a2: ptr XModifierKeymap): cint {.cdecl, 
    importc: "XFreeModifiermap", dynlib: libX11.}
proc XFreePixmap*(a2: ptr Display; a3: Pixmap): cint {.cdecl, 
    importc: "XFreePixmap", dynlib: libX11.}
proc XGeometry*(a2: ptr Display; a3: cint; a4: cstring; a5: cstring; a6: cuint; 
                a7: cuint; a8: cuint; a9: cint; a10: cint; a11: ptr cint; 
                a12: ptr cint; a13: ptr cint; a14: ptr cint): cint {.cdecl, 
    importc: "XGeometry", dynlib: libX11.}
proc XGetErrorDatabaseText*(a2: ptr Display; a3: cstring; a4: cstring; 
                            a5: cstring; a6: cstring; a7: cint): cint {.cdecl, 
    importc: "XGetErrorDatabaseText", dynlib: libX11.}
proc XGetErrorText*(a2: ptr Display; a3: cint; a4: cstring; a5: cint): cint {.
    cdecl, importc: "XGetErrorText", dynlib: libX11.}
proc XGetFontProperty*(a2: ptr XFontStruct; a3: Atom; a4: ptr culong): Bool {.
    cdecl, importc: "XGetFontProperty", dynlib: libX11.}
proc XGetGCValues*(a2: ptr Display; a3: GC; a4: culong; a5: ptr XGCValues): Status {.
    cdecl, importc: "XGetGCValues", dynlib: libX11.}
proc XGetGeometry*(a2: ptr Display; a3: Drawable; a4: ptr Window; a5: ptr cint; 
                   a6: ptr cint; a7: ptr cuint; a8: ptr cuint; a9: ptr cuint; 
                   a10: ptr cuint): Status {.cdecl, importc: "XGetGeometry", 
    dynlib: libX11.}
proc XGetIconName*(a2: ptr Display; a3: Window; a4: cstringArray): Status {.
    cdecl, importc: "XGetIconName", dynlib: libX11.}
proc XGetInputFocus*(a2: ptr Display; a3: ptr Window; a4: ptr cint): cint {.
    cdecl, importc: "XGetInputFocus", dynlib: libX11.}
proc XGetKeyboardControl*(a2: ptr Display; a3: ptr XKeyboardState): cint {.
    cdecl, importc: "XGetKeyboardControl", dynlib: libX11.}
proc XGetPointerControl*(a2: ptr Display; a3: ptr cint; a4: ptr cint; 
                         a5: ptr cint): cint {.cdecl, 
    importc: "XGetPointerControl", dynlib: libX11.}
proc XGetPointerMapping*(a2: ptr Display; a3: ptr cuchar; a4: cint): cint {.
    cdecl, importc: "XGetPointerMapping", dynlib: libX11.}
proc XGetScreenSaver*(a2: ptr Display; a3: ptr cint; a4: ptr cint; a5: ptr cint; 
                      a6: ptr cint): cint {.cdecl, importc: "XGetScreenSaver", 
    dynlib: libX11.}
proc XGetTransientForHint*(a2: ptr Display; a3: Window; a4: ptr Window): Status {.
    cdecl, importc: "XGetTransientForHint", dynlib: libX11.}
proc XGetWindowProperty*(a2: ptr Display; a3: Window; a4: Atom; a5: clong; 
                         a6: clong; a7: Bool; a8: Atom; a9: ptr Atom; 
                         a10: ptr cint; a11: ptr culong; a12: ptr culong; 
                         a13: ptr ptr cuchar): cint {.cdecl, 
    importc: "XGetWindowProperty", dynlib: libX11.}
proc XGetWindowAttributes*(a2: ptr Display; a3: Window; 
                           a4: ptr XWindowAttributes): Status {.cdecl, 
    importc: "XGetWindowAttributes", dynlib: libX11.}
proc XGrabButton*(a2: ptr Display; a3: cuint; a4: cuint; a5: Window; a6: Bool; 
                  a7: cuint; a8: cint; a9: cint; a10: Window; a11: Cursor): cint {.
    cdecl, importc: "XGrabButton", dynlib: libX11.}
proc XGrabKey*(a2: ptr Display; a3: cint; a4: cuint; a5: Window; a6: Bool; 
               a7: cint; a8: cint): cint {.cdecl, importc: "XGrabKey", 
    dynlib: libX11.}
proc XGrabKeyboard*(a2: ptr Display; a3: Window; a4: Bool; a5: cint; a6: cint; 
                    a7: Time): cint {.cdecl, importc: "XGrabKeyboard", 
                                      dynlib: libX11.}
proc XGrabPointer*(a2: ptr Display; a3: Window; a4: Bool; a5: cuint; a6: cint; 
                   a7: cint; a8: Window; a9: Cursor; a10: Time): cint {.cdecl, 
    importc: "XGrabPointer", dynlib: libX11.}
proc XGrabServer*(a2: ptr Display): cint {.cdecl, importc: "XGrabServer", 
    dynlib: libX11.}
proc XHeightMMOfScreen*(a2: ptr Screen): cint {.cdecl, 
    importc: "XHeightMMOfScreen", dynlib: libX11.}
proc XHeightOfScreen*(a2: ptr Screen): cint {.cdecl, importc: "XHeightOfScreen", 
    dynlib: libX11.}
proc XIfEvent*(a2: ptr Display; a3: ptr XEvent; a4: proc (a2: ptr Display; 
    a3: ptr XEvent; a4: XPointer): Bool {.cdecl.}; a5: XPointer): cint {.cdecl, 
    importc: "XIfEvent", dynlib: libX11.}
proc XImageByteOrder*(a2: ptr Display): cint {.cdecl, 
    importc: "XImageByteOrder", dynlib: libX11.}
proc XInstallColormap*(a2: ptr Display; a3: Colormap): cint {.cdecl, 
    importc: "XInstallColormap", dynlib: libX11.}
proc XKeysymToKeycode*(a2: ptr Display; a3: KeySym): KeyCode {.cdecl, 
    importc: "XKeysymToKeycode", dynlib: libX11.}
proc XKillClient*(a2: ptr Display; a3: XID): cint {.cdecl, 
    importc: "XKillClient", dynlib: libX11.}
proc XLookupColor*(a2: ptr Display; a3: Colormap; a4: cstring; a5: ptr XColor; 
                   a6: ptr XColor): Status {.cdecl, importc: "XLookupColor", 
    dynlib: libX11.}
proc XLowerWindow*(a2: ptr Display; a3: Window): cint {.cdecl, 
    importc: "XLowerWindow", dynlib: libX11.}
proc XMapRaised*(a2: ptr Display; a3: Window): cint {.cdecl, 
    importc: "XMapRaised", dynlib: libX11.}
proc XMapSubwindows*(a2: ptr Display; a3: Window): cint {.cdecl, 
    importc: "XMapSubwindows", dynlib: libX11.}
proc XMapWindow*(a2: ptr Display; a3: Window): cint {.cdecl, 
    importc: "XMapWindow", dynlib: libX11.}
proc XMaskEvent*(a2: ptr Display; a3: clong; a4: ptr XEvent): cint {.cdecl, 
    importc: "XMaskEvent", dynlib: libX11.}
proc XMaxCmapsOfScreen*(a2: ptr Screen): cint {.cdecl, 
    importc: "XMaxCmapsOfScreen", dynlib: libX11.}
proc XMinCmapsOfScreen*(a2: ptr Screen): cint {.cdecl, 
    importc: "XMinCmapsOfScreen", dynlib: libX11.}
proc XMoveResizeWindow*(a2: ptr Display; a3: Window; a4: cint; a5: cint; 
                        a6: cuint; a7: cuint): cint {.cdecl, 
    importc: "XMoveResizeWindow", dynlib: libX11.}
proc XMoveWindow*(a2: ptr Display; a3: Window; a4: cint; a5: cint): cint {.
    cdecl, importc: "XMoveWindow", dynlib: libX11.}
proc XNextEvent*(a2: ptr Display; a3: ptr XEvent): cint {.cdecl, 
    importc: "XNextEvent", dynlib: libX11.}
proc XNoOp*(a2: ptr Display): cint {.cdecl, importc: "XNoOp", dynlib: libX11.}
proc XParseColor*(a2: ptr Display; a3: Colormap; a4: cstring; a5: ptr XColor): Status {.
    cdecl, importc: "XParseColor", dynlib: libX11.}
proc XParseGeometry*(a2: cstring; a3: ptr cint; a4: ptr cint; a5: ptr cuint; 
                     a6: ptr cuint): cint {.cdecl, importc: "XParseGeometry", 
    dynlib: libX11.}
proc XPeekEvent*(a2: ptr Display; a3: ptr XEvent): cint {.cdecl, 
    importc: "XPeekEvent", dynlib: libX11.}
proc XPeekIfEvent*(a2: ptr Display; a3: ptr XEvent; a4: proc (a2: ptr Display; 
    a3: ptr XEvent; a4: XPointer): Bool {.cdecl.}; a5: XPointer): cint {.cdecl, 
    importc: "XPeekIfEvent", dynlib: libX11.}
proc XPending*(a2: ptr Display): cint {.cdecl, importc: "XPending", 
                                        dynlib: libX11.}
proc XPlanesOfScreen*(a2: ptr Screen): cint {.cdecl, importc: "XPlanesOfScreen", 
    dynlib: libX11.}
proc XProtocolRevision*(a2: ptr Display): cint {.cdecl, 
    importc: "XProtocolRevision", dynlib: libX11.}
proc XProtocolVersion*(a2: ptr Display): cint {.cdecl, 
    importc: "XProtocolVersion", dynlib: libX11.}
proc XPutBackEvent*(a2: ptr Display; a3: ptr XEvent): cint {.cdecl, 
    importc: "XPutBackEvent", dynlib: libX11.}
proc XPutImage*(a2: ptr Display; a3: Drawable; a4: GC; a5: ptr XImage; a6: cint; 
                a7: cint; a8: cint; a9: cint; a10: cuint; a11: cuint): cint {.
    cdecl, importc: "XPutImage", dynlib: libX11.}
proc XQLength*(a2: ptr Display): cint {.cdecl, importc: "XQLength", 
                                        dynlib: libX11.}
proc XQueryBestCursor*(a2: ptr Display; a3: Drawable; a4: cuint; a5: cuint; 
                       a6: ptr cuint; a7: ptr cuint): Status {.cdecl, 
    importc: "XQueryBestCursor", dynlib: libX11.}
proc XQueryBestSize*(a2: ptr Display; a3: cint; a4: Drawable; a5: cuint; 
                     a6: cuint; a7: ptr cuint; a8: ptr cuint): Status {.cdecl, 
    importc: "XQueryBestSize", dynlib: libX11.}
proc XQueryBestStipple*(a2: ptr Display; a3: Drawable; a4: cuint; a5: cuint; 
                        a6: ptr cuint; a7: ptr cuint): Status {.cdecl, 
    importc: "XQueryBestStipple", dynlib: libX11.}
proc XQueryBestTile*(a2: ptr Display; a3: Drawable; a4: cuint; a5: cuint; 
                     a6: ptr cuint; a7: ptr cuint): Status {.cdecl, 
    importc: "XQueryBestTile", dynlib: libX11.}
proc XQueryColor*(a2: ptr Display; a3: Colormap; a4: ptr XColor): cint {.cdecl, 
    importc: "XQueryColor", dynlib: libX11.}
proc XQueryColors*(a2: ptr Display; a3: Colormap; a4: ptr XColor; a5: cint): cint {.
    cdecl, importc: "XQueryColors", dynlib: libX11.}
proc XQueryExtension*(a2: ptr Display; a3: cstring; a4: ptr cint; a5: ptr cint; 
                      a6: ptr cint): Bool {.cdecl, importc: "XQueryExtension", 
    dynlib: libX11.}
proc XQueryKeymap*(a2: ptr Display; a3: array[32, char]): cint {.cdecl, 
    importc: "XQueryKeymap", dynlib: libX11.}
proc XQueryPointer*(a2: ptr Display; a3: Window; a4: ptr Window; a5: ptr Window; 
                    a6: ptr cint; a7: ptr cint; a8: ptr cint; a9: ptr cint; 
                    a10: ptr cuint): Bool {.cdecl, importc: "XQueryPointer", 
    dynlib: libX11.}
proc XQueryTextExtents*(a2: ptr Display; a3: XID; a4: cstring; a5: cint; 
                        a6: ptr cint; a7: ptr cint; a8: ptr cint; 
                        a9: ptr XCharStruct): cint {.cdecl, 
    importc: "XQueryTextExtents", dynlib: libX11.}
proc XQueryTextExtents16*(a2: ptr Display; a3: XID; a4: ptr XChar2b; a5: cint; 
                          a6: ptr cint; a7: ptr cint; a8: ptr cint; 
                          a9: ptr XCharStruct): cint {.cdecl, 
    importc: "XQueryTextExtents16", dynlib: libX11.}
proc XQueryTree*(a2: ptr Display; a3: Window; a4: ptr Window; a5: ptr Window; 
                 a6: ptr ptr Window; a7: ptr cuint): Status {.cdecl, 
    importc: "XQueryTree", dynlib: libX11.}
proc XRaiseWindow*(a2: ptr Display; a3: Window): cint {.cdecl, 
    importc: "XRaiseWindow", dynlib: libX11.}
proc XReadBitmapFile*(a2: ptr Display; a3: Drawable; a4: cstring; a5: ptr cuint; 
                      a6: ptr cuint; a7: ptr Pixmap; a8: ptr cint; a9: ptr cint): cint {.
    cdecl, importc: "XReadBitmapFile", dynlib: libX11.}
proc XReadBitmapFileData*(a2: cstring; a3: ptr cuint; a4: ptr cuint; 
                          a5: ptr ptr cuchar; a6: ptr cint; a7: ptr cint): cint {.
    cdecl, importc: "XReadBitmapFileData", dynlib: libX11.}
proc XRebindKeysym*(a2: ptr Display; a3: KeySym; a4: ptr KeySym; a5: cint; 
                    a6: ptr cuchar; a7: cint): cint {.cdecl, 
    importc: "XRebindKeysym", dynlib: libX11.}
proc XRecolorCursor*(a2: ptr Display; a3: Cursor; a4: ptr XColor; a5: ptr XColor): cint {.
    cdecl, importc: "XRecolorCursor", dynlib: libX11.}
proc XRefreshKeyboardMapping*(a2: ptr XMappingEvent): cint {.cdecl, 
    importc: "XRefreshKeyboardMapping", dynlib: libX11.}
proc XRemoveFromSaveSet*(a2: ptr Display; a3: Window): cint {.cdecl, 
    importc: "XRemoveFromSaveSet", dynlib: libX11.}
proc XRemoveHost*(a2: ptr Display; a3: ptr XHostAddress): cint {.cdecl, 
    importc: "XRemoveHost", dynlib: libX11.}
proc XRemoveHosts*(a2: ptr Display; a3: ptr XHostAddress; a4: cint): cint {.
    cdecl, importc: "XRemoveHosts", dynlib: libX11.}
proc XReparentWindow*(a2: ptr Display; a3: Window; a4: Window; a5: cint; 
                      a6: cint): cint {.cdecl, importc: "XReparentWindow", 
                                        dynlib: libX11.}
proc XResetScreenSaver*(a2: ptr Display): cint {.cdecl, 
    importc: "XResetScreenSaver", dynlib: libX11.}
proc XResizeWindow*(a2: ptr Display; a3: Window; a4: cuint; a5: cuint): cint {.
    cdecl, importc: "XResizeWindow", dynlib: libX11.}
proc XRestackWindows*(a2: ptr Display; a3: ptr Window; a4: cint): cint {.cdecl, 
    importc: "XRestackWindows", dynlib: libX11.}
proc XRotateBuffers*(a2: ptr Display; a3: cint): cint {.cdecl, 
    importc: "XRotateBuffers", dynlib: libX11.}
proc XRotateWindowProperties*(a2: ptr Display; a3: Window; a4: ptr Atom; 
                              a5: cint; a6: cint): cint {.cdecl, 
    importc: "XRotateWindowProperties", dynlib: libX11.}
proc XScreenCount*(a2: ptr Display): cint {.cdecl, importc: "XScreenCount", 
    dynlib: libX11.}
proc XSelectInput*(a2: ptr Display; a3: Window; a4: clong): cint {.cdecl, 
    importc: "XSelectInput", dynlib: libX11.}
proc XSendEvent*(a2: ptr Display; a3: Window; a4: Bool; a5: clong; 
                 a6: ptr XEvent): Status {.cdecl, importc: "XSendEvent", 
    dynlib: libX11.}
proc XSetAccessControl*(a2: ptr Display; a3: cint): cint {.cdecl, 
    importc: "XSetAccessControl", dynlib: libX11.}
proc XSetArcMode*(a2: ptr Display; a3: GC; a4: cint): cint {.cdecl, 
    importc: "XSetArcMode", dynlib: libX11.}
proc XSetBackground*(a2: ptr Display; a3: GC; a4: culong): cint {.cdecl, 
    importc: "XSetBackground", dynlib: libX11.}
proc XSetClipMask*(a2: ptr Display; a3: GC; a4: Pixmap): cint {.cdecl, 
    importc: "XSetClipMask", dynlib: libX11.}
proc XSetClipOrigin*(a2: ptr Display; a3: GC; a4: cint; a5: cint): cint {.cdecl, 
    importc: "XSetClipOrigin", dynlib: libX11.}
proc XSetClipRectangles*(a2: ptr Display; a3: GC; a4: cint; a5: cint; 
                         a6: ptr XRectangle; a7: cint; a8: cint): cint {.cdecl, 
    importc: "XSetClipRectangles", dynlib: libX11.}
proc XSetCloseDownMode*(a2: ptr Display; a3: cint): cint {.cdecl, 
    importc: "XSetCloseDownMode", dynlib: libX11.}
proc XSetCommand*(a2: ptr Display; a3: Window; a4: cstringArray; a5: cint): cint {.
    cdecl, importc: "XSetCommand", dynlib: libX11.}
proc XSetDashes*(a2: ptr Display; a3: GC; a4: cint; a5: cstring; a6: cint): cint {.
    cdecl, importc: "XSetDashes", dynlib: libX11.}
proc XSetFillRule*(a2: ptr Display; a3: GC; a4: cint): cint {.cdecl, 
    importc: "XSetFillRule", dynlib: libX11.}
proc XSetFillStyle*(a2: ptr Display; a3: GC; a4: cint): cint {.cdecl, 
    importc: "XSetFillStyle", dynlib: libX11.}
proc XSetFont*(a2: ptr Display; a3: GC; a4: Font): cint {.cdecl, 
    importc: "XSetFont", dynlib: libX11.}
proc XSetFontPath*(a2: ptr Display; a3: cstringArray; a4: cint): cint {.cdecl, 
    importc: "XSetFontPath", dynlib: libX11.}
proc XSetForeground*(a2: ptr Display; a3: GC; a4: culong): cint {.cdecl, 
    importc: "XSetForeground", dynlib: libX11.}
proc XSetFunction*(a2: ptr Display; a3: GC; a4: cint): cint {.cdecl, 
    importc: "XSetFunction", dynlib: libX11.}
proc XSetGraphicsExposures*(a2: ptr Display; a3: GC; a4: Bool): cint {.cdecl, 
    importc: "XSetGraphicsExposures", dynlib: libX11.}
proc XSetIconName*(a2: ptr Display; a3: Window; a4: cstring): cint {.cdecl, 
    importc: "XSetIconName", dynlib: libX11.}
proc XSetInputFocus*(a2: ptr Display; a3: Window; a4: cint; a5: Time): cint {.
    cdecl, importc: "XSetInputFocus", dynlib: libX11.}
proc XSetLineAttributes*(a2: ptr Display; a3: GC; a4: cuint; a5: cint; a6: cint; 
                         a7: cint): cint {.cdecl, importc: "XSetLineAttributes", 
    dynlib: libX11.}
proc XSetModifierMapping*(a2: ptr Display; a3: ptr XModifierKeymap): cint {.
    cdecl, importc: "XSetModifierMapping", dynlib: libX11.}
proc XSetPlaneMask*(a2: ptr Display; a3: GC; a4: culong): cint {.cdecl, 
    importc: "XSetPlaneMask", dynlib: libX11.}
proc XSetPointerMapping*(a2: ptr Display; a3: ptr cuchar; a4: cint): cint {.
    cdecl, importc: "XSetPointerMapping", dynlib: libX11.}
proc XSetScreenSaver*(a2: ptr Display; a3: cint; a4: cint; a5: cint; a6: cint): cint {.
    cdecl, importc: "XSetScreenSaver", dynlib: libX11.}
proc XSetSelectionOwner*(a2: ptr Display; a3: Atom; a4: Window; a5: Time): cint {.
    cdecl, importc: "XSetSelectionOwner", dynlib: libX11.}
proc XSetState*(a2: ptr Display; a3: GC; a4: culong; a5: culong; a6: cint; 
                a7: culong): cint {.cdecl, importc: "XSetState", dynlib: libX11.}
proc XSetStipple*(a2: ptr Display; a3: GC; a4: Pixmap): cint {.cdecl, 
    importc: "XSetStipple", dynlib: libX11.}
proc XSetSubwindowMode*(a2: ptr Display; a3: GC; a4: cint): cint {.cdecl, 
    importc: "XSetSubwindowMode", dynlib: libX11.}
proc XSetTSOrigin*(a2: ptr Display; a3: GC; a4: cint; a5: cint): cint {.cdecl, 
    importc: "XSetTSOrigin", dynlib: libX11.}
proc XSetTile*(a2: ptr Display; a3: GC; a4: Pixmap): cint {.cdecl, 
    importc: "XSetTile", dynlib: libX11.}
proc XSetWindowBackground*(a2: ptr Display; a3: Window; a4: culong): cint {.
    cdecl, importc: "XSetWindowBackground", dynlib: libX11.}
proc XSetWindowBackgroundPixmap*(a2: ptr Display; a3: Window; a4: Pixmap): cint {.
    cdecl, importc: "XSetWindowBackgroundPixmap", dynlib: libX11.}
proc XSetWindowBorder*(a2: ptr Display; a3: Window; a4: culong): cint {.cdecl, 
    importc: "XSetWindowBorder", dynlib: libX11.}
proc XSetWindowBorderPixmap*(a2: ptr Display; a3: Window; a4: Pixmap): cint {.
    cdecl, importc: "XSetWindowBorderPixmap", dynlib: libX11.}
proc XSetWindowBorderWidth*(a2: ptr Display; a3: Window; a4: cuint): cint {.
    cdecl, importc: "XSetWindowBorderWidth", dynlib: libX11.}
proc XSetWindowColormap*(a2: ptr Display; a3: Window; a4: Colormap): cint {.
    cdecl, importc: "XSetWindowColormap", dynlib: libX11.}
proc XStoreBuffer*(a2: ptr Display; a3: cstring; a4: cint; a5: cint): cint {.
    cdecl, importc: "XStoreBuffer", dynlib: libX11.}
proc XStoreBytes*(a2: ptr Display; a3: cstring; a4: cint): cint {.cdecl, 
    importc: "XStoreBytes", dynlib: libX11.}
proc XStoreColor*(a2: ptr Display; a3: Colormap; a4: ptr XColor): cint {.cdecl, 
    importc: "XStoreColor", dynlib: libX11.}
proc XStoreColors*(a2: ptr Display; a3: Colormap; a4: ptr XColor; a5: cint): cint {.
    cdecl, importc: "XStoreColors", dynlib: libX11.}
proc XStoreName*(a2: ptr Display; a3: Window; a4: cstring): cint {.cdecl, 
    importc: "XStoreName", dynlib: libX11.}
proc XStoreNamedColor*(a2: ptr Display; a3: Colormap; a4: cstring; a5: culong; 
                       a6: cint): cint {.cdecl, importc: "XStoreNamedColor", 
    dynlib: libX11.}
proc XSync*(a2: ptr Display; a3: Bool): cint {.cdecl, importc: "XSync", 
    dynlib: libX11.}
proc XTextExtents*(a2: ptr XFontStruct; a3: cstring; a4: cint; a5: ptr cint; 
                   a6: ptr cint; a7: ptr cint; a8: ptr XCharStruct): cint {.
    cdecl, importc: "XTextExtents", dynlib: libX11.}
proc XTextExtents16*(a2: ptr XFontStruct; a3: ptr XChar2b; a4: cint; 
                     a5: ptr cint; a6: ptr cint; a7: ptr cint; 
                     a8: ptr XCharStruct): cint {.cdecl, 
    importc: "XTextExtents16", dynlib: libX11.}
proc XTextWidth*(a2: ptr XFontStruct; a3: cstring; a4: cint): cint {.cdecl, 
    importc: "XTextWidth", dynlib: libX11.}
proc XTextWidth16*(a2: ptr XFontStruct; a3: ptr XChar2b; a4: cint): cint {.
    cdecl, importc: "XTextWidth16", dynlib: libX11.}
proc XTranslateCoordinates*(a2: ptr Display; a3: Window; a4: Window; a5: cint; 
                            a6: cint; a7: ptr cint; a8: ptr cint; a9: ptr Window): Bool {.
    cdecl, importc: "XTranslateCoordinates", dynlib: libX11.}
proc XUndefineCursor*(a2: ptr Display; a3: Window): cint {.cdecl, 
    importc: "XUndefineCursor", dynlib: libX11.}
proc XUngrabButton*(a2: ptr Display; a3: cuint; a4: cuint; a5: Window): cint {.
    cdecl, importc: "XUngrabButton", dynlib: libX11.}
proc XUngrabKey*(a2: ptr Display; a3: cint; a4: cuint; a5: Window): cint {.
    cdecl, importc: "XUngrabKey", dynlib: libX11.}
proc XUngrabKeyboard*(a2: ptr Display; a3: Time): cint {.cdecl, 
    importc: "XUngrabKeyboard", dynlib: libX11.}
proc XUngrabPointer*(a2: ptr Display; a3: Time): cint {.cdecl, 
    importc: "XUngrabPointer", dynlib: libX11.}
proc XUngrabServer*(a2: ptr Display): cint {.cdecl, importc: "XUngrabServer", 
    dynlib: libX11.}
proc XUninstallColormap*(a2: ptr Display; a3: Colormap): cint {.cdecl, 
    importc: "XUninstallColormap", dynlib: libX11.}
proc XUnloadFont*(a2: ptr Display; a3: Font): cint {.cdecl, 
    importc: "XUnloadFont", dynlib: libX11.}
proc XUnmapSubwindows*(a2: ptr Display; a3: Window): cint {.cdecl, 
    importc: "XUnmapSubwindows", dynlib: libX11.}
proc XUnmapWindow*(a2: ptr Display; a3: Window): cint {.cdecl, 
    importc: "XUnmapWindow", dynlib: libX11.}
proc XVendorRelease*(a2: ptr Display): cint {.cdecl, importc: "XVendorRelease", 
    dynlib: libX11.}
proc XWarpPointer*(a2: ptr Display; a3: Window; a4: Window; a5: cint; a6: cint; 
                   a7: cuint; a8: cuint; a9: cint; a10: cint): cint {.cdecl, 
    importc: "XWarpPointer", dynlib: libX11.}
proc XWidthMMOfScreen*(a2: ptr Screen): cint {.cdecl, 
    importc: "XWidthMMOfScreen", dynlib: libX11.}
proc XWidthOfScreen*(a2: ptr Screen): cint {.cdecl, importc: "XWidthOfScreen", 
    dynlib: libX11.}
proc XWindowEvent*(a2: ptr Display; a3: Window; a4: clong; a5: ptr XEvent): cint {.
    cdecl, importc: "XWindowEvent", dynlib: libX11.}
proc XWriteBitmapFile*(a2: ptr Display; a3: cstring; a4: Pixmap; a5: cuint; 
                       a6: cuint; a7: cint; a8: cint): cint {.cdecl, 
    importc: "XWriteBitmapFile", dynlib: libX11.}
proc XSupportsLocale*(): Bool {.cdecl, importc: "XSupportsLocale", 
                                dynlib: libX11.}
proc XSetLocaleModifiers*(a2: cstring): cstring {.cdecl, 
    importc: "XSetLocaleModifiers", dynlib: libX11.}
proc XOpenOM*(a2: ptr Display; a3: ptr XrmHashBucketRec; a4: cstring; 
              a5: cstring): XOM {.cdecl, importc: "XOpenOM", dynlib: libX11.}
proc XCloseOM*(a2: XOM): Status {.cdecl, importc: "XCloseOM", dynlib: libX11.}

proc XSetOMValues*(a2: XOM): cstring {.varargs, cdecl, importc: "XSetOMValues", 
                                       dynlib: libX11.}

proc XGetOMValues*(a2: XOM): cstring {.varargs, cdecl, importc: "XGetOMValues", 
                                       dynlib: libX11.}
proc XDisplayOfOM*(a2: XOM): ptr Display {.cdecl, importc: "XDisplayOfOM", 
    dynlib: libX11.}
proc XLocaleOfOM*(a2: XOM): cstring {.cdecl, importc: "XLocaleOfOM", 
                                      dynlib: libX11.}

proc XCreateOC*(a2: XOM): XOC {.varargs, cdecl, importc: "XCreateOC", 
                                dynlib: libX11.}
proc XDestroyOC*(a2: XOC) {.cdecl, importc: "XDestroyOC", dynlib: libX11.}
proc XOMOfOC*(a2: XOC): XOM {.cdecl, importc: "XOMOfOC", dynlib: libX11.}

proc XSetOCValues*(a2: XOC): cstring {.varargs, cdecl, importc: "XSetOCValues", 
                                       dynlib: libX11.}

proc XGetOCValues*(a2: XOC): cstring {.varargs, cdecl, importc: "XGetOCValues", 
                                       dynlib: libX11.}
proc XCreateFontSet*(a2: ptr Display; a3: cstring; a4: ptr cstringArray; 
                     a5: ptr cint; a6: cstringArray): XFontSet {.cdecl, 
    importc: "XCreateFontSet", dynlib: libX11.}
proc XFreeFontSet*(a2: ptr Display; a3: XFontSet) {.cdecl, 
    importc: "XFreeFontSet", dynlib: libX11.}
proc XFontsOfFontSet*(a2: XFontSet; a3: ptr ptr ptr XFontStruct; 
                      a4: ptr cstringArray): cint {.cdecl, 
    importc: "XFontsOfFontSet", dynlib: libX11.}
proc XBaseFontNameListOfFontSet*(a2: XFontSet): cstring {.cdecl, 
    importc: "XBaseFontNameListOfFontSet", dynlib: libX11.}
proc XLocaleOfFontSet*(a2: XFontSet): cstring {.cdecl, 
    importc: "XLocaleOfFontSet", dynlib: libX11.}
proc XContextDependentDrawing*(a2: XFontSet): Bool {.cdecl, 
    importc: "XContextDependentDrawing", dynlib: libX11.}
proc XDirectionalDependentDrawing*(a2: XFontSet): Bool {.cdecl, 
    importc: "XDirectionalDependentDrawing", dynlib: libX11.}
proc XContextualDrawing*(a2: XFontSet): Bool {.cdecl, 
    importc: "XContextualDrawing", dynlib: libX11.}
proc XExtentsOfFontSet*(a2: XFontSet): ptr XFontSetExtents {.cdecl, 
    importc: "XExtentsOfFontSet", dynlib: libX11.}
proc XmbTextEscapement*(a2: XFontSet; a3: cstring; a4: cint): cint {.cdecl, 
    importc: "XmbTextEscapement", dynlib: libX11.}
proc XwcTextEscapement*(a2: XFontSet; a3: cstring; a4: cint): cint {.cdecl, 
    importc: "XwcTextEscapement", dynlib: libX11.}
proc Xutf8TextEscapement*(a2: XFontSet; a3: cstring; a4: cint): cint {.cdecl, 
    importc: "Xutf8TextEscapement", dynlib: libX11.}
proc XmbTextExtents*(a2: XFontSet; a3: cstring; a4: cint; a5: ptr XRectangle; 
                     a6: ptr XRectangle): cint {.cdecl, 
    importc: "XmbTextExtents", dynlib: libX11.}
proc XwcTextExtents*(a2: XFontSet; a3: cstring; a4: cint; a5: ptr XRectangle; 
                     a6: ptr XRectangle): cint {.cdecl, 
    importc: "XwcTextExtents", dynlib: libX11.}
proc Xutf8TextExtents*(a2: XFontSet; a3: cstring; a4: cint; a5: ptr XRectangle; 
                       a6: ptr XRectangle): cint {.cdecl, 
    importc: "Xutf8TextExtents", dynlib: libX11.}
proc XmbTextPerCharExtents*(a2: XFontSet; a3: cstring; a4: cint; 
                            a5: ptr XRectangle; a6: ptr XRectangle; a7: cint; 
                            a8: ptr cint; a9: ptr XRectangle; 
                            a10: ptr XRectangle): Status {.cdecl, 
    importc: "XmbTextPerCharExtents", dynlib: libX11.}
proc XwcTextPerCharExtents*(a2: XFontSet; a3: cstring; a4: cint; 
                            a5: ptr XRectangle; a6: ptr XRectangle; a7: cint; 
                            a8: ptr cint; a9: ptr XRectangle; 
                            a10: ptr XRectangle): Status {.cdecl, 
    importc: "XwcTextPerCharExtents", dynlib: libX11.}
proc Xutf8TextPerCharExtents*(a2: XFontSet; a3: cstring; a4: cint; 
                              a5: ptr XRectangle; a6: ptr XRectangle; a7: cint; 
                              a8: ptr cint; a9: ptr XRectangle; 
                              a10: ptr XRectangle): Status {.cdecl, 
    importc: "Xutf8TextPerCharExtents", dynlib: libX11.}
proc XmbDrawText*(a2: ptr Display; a3: Drawable; a4: GC; a5: cint; a6: cint; 
                  a7: ptr XmbTextItem; a8: cint) {.cdecl, 
    importc: "XmbDrawText", dynlib: libX11.}
proc XwcDrawText*(a2: ptr Display; a3: Drawable; a4: GC; a5: cint; a6: cint; 
                  a7: ptr XwcTextItem; a8: cint) {.cdecl, 
    importc: "XwcDrawText", dynlib: libX11.}
proc Xutf8DrawText*(a2: ptr Display; a3: Drawable; a4: GC; a5: cint; a6: cint; 
                    a7: ptr XmbTextItem; a8: cint) {.cdecl, 
    importc: "Xutf8DrawText", dynlib: libX11.}
proc XmbDrawString*(a2: ptr Display; a3: Drawable; a4: XFontSet; a5: GC; 
                    a6: cint; a7: cint; a8: cstring; a9: cint) {.cdecl, 
    importc: "XmbDrawString", dynlib: libX11.}
proc XwcDrawString*(a2: ptr Display; a3: Drawable; a4: XFontSet; a5: GC; 
                    a6: cint; a7: cint; a8: cstring; a9: cint) {.cdecl, 
    importc: "XwcDrawString", dynlib: libX11.}
proc Xutf8DrawString*(a2: ptr Display; a3: Drawable; a4: XFontSet; a5: GC; 
                      a6: cint; a7: cint; a8: cstring; a9: cint) {.cdecl, 
    importc: "Xutf8DrawString", dynlib: libX11.}
proc XmbDrawImageString*(a2: ptr Display; a3: Drawable; a4: XFontSet; a5: GC; 
                         a6: cint; a7: cint; a8: cstring; a9: cint) {.cdecl, 
    importc: "XmbDrawImageString", dynlib: libX11.}
proc XwcDrawImageString*(a2: ptr Display; a3: Drawable; a4: XFontSet; a5: GC; 
                         a6: cint; a7: cint; a8: cstring; a9: cint) {.cdecl, 
    importc: "XwcDrawImageString", dynlib: libX11.}
proc Xutf8DrawImageString*(a2: ptr Display; a3: Drawable; a4: XFontSet; a5: GC; 
                           a6: cint; a7: cint; a8: cstring; a9: cint) {.cdecl, 
    importc: "Xutf8DrawImageString", dynlib: libX11.}
proc XOpenIM*(a2: ptr Display; a3: ptr XrmHashBucketRec; a4: cstring; 
              a5: cstring): XIM {.cdecl, importc: "XOpenIM", dynlib: libX11.}
proc XCloseIM*(a2: XIM): Status {.cdecl, importc: "XCloseIM", dynlib: libX11.}
proc XGetIMValues*(a2: XIM): cstring {.varargs, cdecl, importc: "XGetIMValues", 
                                       dynlib: libX11.}
proc XSetIMValues*(a2: XIM): cstring {.varargs, cdecl, importc: "XSetIMValues", 
                                       dynlib: libX11.}
proc XDisplayOfIM*(a2: XIM): ptr Display {.cdecl, importc: "XDisplayOfIM", 
    dynlib: libX11.}
proc XLocaleOfIM*(a2: XIM): cstring {.cdecl, importc: "XLocaleOfIM", 
                                      dynlib: libX11.}
proc XCreateIC*(a2: XIM): XIC {.varargs, cdecl, importc: "XCreateIC", 
                                dynlib: libX11.}
proc XDestroyIC*(a2: XIC) {.cdecl, importc: "XDestroyIC", dynlib: libX11.}
proc XSetICFocus*(a2: XIC) {.cdecl, importc: "XSetICFocus", dynlib: libX11.}
proc XUnsetICFocus*(a2: XIC) {.cdecl, importc: "XUnsetICFocus", dynlib: libX11.}
proc XwcResetIC*(a2: XIC): cstring {.cdecl, importc: "XwcResetIC", 
                                     dynlib: libX11.}
proc XmbResetIC*(a2: XIC): cstring {.cdecl, importc: "XmbResetIC", 
                                     dynlib: libX11.}
proc Xutf8ResetIC*(a2: XIC): cstring {.cdecl, importc: "Xutf8ResetIC", 
                                       dynlib: libX11.}
proc XSetICValues*(a2: XIC): cstring {.varargs, cdecl, importc: "XSetICValues", 
                                       dynlib: libX11.}
proc XGetICValues*(a2: XIC): cstring {.varargs, cdecl, importc: "XGetICValues", 
                                       dynlib: libX11.}
proc XIMOfIC*(a2: XIC): XIM {.cdecl, importc: "XIMOfIC", dynlib: libX11.}
proc XFilterEvent*(a2: ptr XEvent; a3: Window): Bool {.cdecl, 
    importc: "XFilterEvent", dynlib: libX11.}
proc XmbLookupString*(a2: XIC; a3: ptr XKeyPressedEvent; a4: cstring; a5: cint; 
                      a6: ptr KeySym; a7: ptr Status): cint {.cdecl, 
    importc: "XmbLookupString", dynlib: libX11.}
proc XwcLookupString*(a2: XIC; a3: ptr XKeyPressedEvent; a4: cstring; a5: cint; 
                      a6: ptr KeySym; a7: ptr Status): cint {.cdecl, 
    importc: "XwcLookupString", dynlib: libX11.}
proc Xutf8LookupString*(a2: XIC; a3: ptr XKeyPressedEvent; a4: cstring; 
                        a5: cint; a6: ptr KeySym; a7: ptr Status): cint {.cdecl, 
    importc: "Xutf8LookupString", dynlib: libX11.}
proc XVaCreateNestedList*(a2: cint): XVaNestedList {.varargs, cdecl, 
    importc: "XVaCreateNestedList", dynlib: libX11.}

proc XRegisterIMInstantiateCallback*(a2: ptr Display; a3: ptr XrmHashBucketRec; 
                                     a4: cstring; a5: cstring; a6: XIDProc; 
                                     a7: XPointer): Bool {.cdecl, 
    importc: "XRegisterIMInstantiateCallback", dynlib: libX11.}
proc XUnregisterIMInstantiateCallback*(a2: ptr Display; 
                                       a3: ptr XrmHashBucketRec; a4: cstring; 
                                       a5: cstring; a6: XIDProc; a7: XPointer): Bool {.
    cdecl, importc: "XUnregisterIMInstantiateCallback", dynlib: libX11.}
type 
  XConnectionWatchProc* = proc (a2: ptr Display; a3: XPointer; a4: cint; 
                                a5: Bool; a6: ptr XPointer) {.cdecl.}

proc XInternalConnectionNumbers*(a2: ptr Display; a3: ptr ptr cint; a4: ptr cint): Status {.
    cdecl, importc: "XInternalConnectionNumbers", dynlib: libX11.}
proc XProcessInternalConnection*(a2: ptr Display; a3: cint) {.cdecl, 
    importc: "XProcessInternalConnection", dynlib: libX11.}
proc XAddConnectionWatch*(a2: ptr Display; a3: XConnectionWatchProc; 
                          a4: XPointer): Status {.cdecl, 
    importc: "XAddConnectionWatch", dynlib: libX11.}
proc XRemoveConnectionWatch*(a2: ptr Display; a3: XConnectionWatchProc; 
                             a4: XPointer) {.cdecl, 
    importc: "XRemoveConnectionWatch", dynlib: libX11.}
proc XSetAuthorization*(a2: cstring; a3: cint; a4: cstring; a5: cint) {.cdecl, 
    importc: "XSetAuthorization", dynlib: libX11.}
proc Xmbtowc*(a2: cstring; a3: cstring; a4: cint): cint {.cdecl, 
    importc: "_Xmbtowc", dynlib: libX11.}
proc Xwctomb*(a2: cstring; a3: char): cint {.cdecl, importc: "_Xwctomb", 
    dynlib: libX11.}
proc XGetEventData*(a2: ptr Display; a3: ptr XGenericEventCookie): Bool {.cdecl, 
    importc: "XGetEventData", dynlib: libX11.}
proc XFreeEventData*(a2: ptr Display; a3: ptr XGenericEventCookie) {.cdecl, 
    importc: "XFreeEventData", dynlib: libX11.}