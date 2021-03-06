###############################
#
# contrib/vrtrayballoon.rb
#
# These modules/classes are contributed by Drew Willcoxon.
# Modified by nyasu <nyasu@osk.3web.ne.jp>
# The original is at http://cs.stanford.edu/people/adw/vrballoon.zip
#

VR_DIR="vr/" unless defined?(::VR_DIR)
require VR_DIR+'vruby'

module VRTrayiconFeasible
  +  NIF_INFO    = 16   # Shell32.dll version 5.0 (Win2000/Me and later)
  # Tooltip balloon icon flags (are these the only possible?)
  # see http://msdn.microsoft.com/en-us/library/bb773352(VS.85).aspx
  NIIF_NONE    = 0
  NIIF_INFO    = 1
  NIIF_WARNING = 2
  NIIF_ERROR   = 3
  NIIF_USER    = 4   # WinXP SP2 and later
  NIIF_NOSOUND = 16  # Shell32.dll version 6.0 (WinXP/Vista)

  # Tooltip balloon messages
  NIN_BALLOONSHOW      = WMsg::WM_USER + 2
  NIN_BALLOONHIDE      = WMsg::WM_USER + 3
  NIN_BALLOONTIMEOUT   = WMsg::WM_USER + 4
  NIN_BALLOONUSERCLICK = WMsg::WM_USER + 5

  # this method allows you to create a tray tip balloon for a tray icon
  # infoicon: appears that tray tip balloons can only have one of a few icons associated (NIIF_xxx)
  # hicon is if you [also] want to change the icon--see modify_trayicon
  # infotimeout--apparently valid is between 10 and 20 (s) [http://www.tech-archive.net/Archive/DotNet/microsoft.public.dotnet.framework/2009-03/msg00160.html]
  # iconid is the [internal] icon number--see vrtray.rb for explanation
  #
  def modify_trayicon5(hicon,infotitle,infotext,infoicon=NIIF_NONE,
                       infotimeout=20000,iconid=0)
    flag = NIF_INFO
    if hicon then
      flag |= NIF_ICON
    end
    size = 4*10 + 128 + 256 + 64
    s = [size, self.hWnd, iconid, flag, 0, hicon.to_i].pack(NOTIFYICONDATA_a) <<
        ['', 0, 0, infotext.to_s[0, 256], infotimeout, infotitle.to_s[0, 64],
         infoicon].pack('a128IIa256Ia64I')
    Shell_NotifyIcon.call(NIM_MODIFY,s)
  end

  def self__vr_traynotify(wparam,lparam)
    case lparam
    when WMsg::WM_MOUSEMOVE
      selfmsg_dispatching("trayrbuttondown",wparam)
    when WMsg::WM_RBUTTONUP
      selfmsg_dispatching("trayrbuttonup",wparam)
    when NIN_BALLOONSHOW
      selfmsg_dispatching("trayballoonshow",wparam)
    when NIN_BALLOONHIDE
      selfmsg_dispatching("trayballoonhide",wparam)
    when NIN_BALLOONTIMEOUT
      selfmsg_dispatching("trayballoontimeout",wparam)
    when NIN_BALLOONUSERCLICK
      selfmsg_dispatching("trayballoonclicked",wparam)
    end
  end
end

