import Xlib, unsigned

# from X.h, TODO: Move
const
  ButtonPressMask = 1 shl 2
  ButtonReleaseMask = 1 shl 3
  PointerMotionMask = 1 shl 6

  Mod1Mask = 1 shl 3
  GrabModeAsync = 1

  KeyPress = 2
  ButtonPress = 4
  ButtonRelease = 4
  MotionNotify = 6

  None = 0

var
  dpy = XOpenDisplay(nil)
  start: XButtonEvent
  ev: XEvent
  attr: XWindowAttributes

if dpy == nil: quit 1

discard dpy.XGrabKey(dpy.XKeysymToKeycode(XStringToKeysym("F1")).cint, Mod1Mask, dpy.XDefaultRootWindow, 1, GrabModeAsync, GrabModeAsync)
discard dpy.XGrabButton(1, Mod1Mask, dpy.XDefaultRootWindow, 1, ButtonPressMask or ButtonReleaseMask or PointerMotionMask, GrabModeAsync, GrabModeAsync, None, None)
discard dpy.XGrabButton(3, Mod1Mask, dpy.XDefaultRootWindow, 1, ButtonPressMask or ButtonReleaseMask or PointerMotionMask, GrabModeAsync, GrabModeAsync, None, None)

while true:
  discard dpy.XNextEvent(addr ev)
  echo "Type: ", ev.`type`, ", subwindow: ", ev.xkey.subwindow, " ", ev.xbutton.subwindow, " ", start.subwindow
  if ev.`type` == KeyPress and ev.xkey.subwindow.culong != None:
    discard dpy.XRaiseWindow(ev.xkey.subwindow)
  elif ev.`type` == ButtonPress and ev.xbutton.subwindow.culong != None:
    discard dpy.XGetWindowAttributes(ev.xbutton.subwindow, addr attr)
    start = ev.xbutton
  elif ev.`type` == MotionNotify and start.subwindow.culong != None:
    let
      xdiff = ev.xbutton.x_root - start.x_root
      ydiff = ev.xbutton.y_root - start.y_root
    discard dpy.XMoveResizeWindow(start.subwindow,
      cint(attr.x + (if start.button == 1: xdiff else: 0)),
      cint(attr.y + (if start.button == 1: ydiff else: 0)),
      cuint(max(1, attr.width + (if start.button == 3: xdiff else: 0))),
      cuint(max(1, attr.height + (if start.button == 3: ydiff else: 0))))
  elif ev.`type` == ButtonRelease:
    start.subwindow = None
