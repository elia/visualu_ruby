#########################################################
require 'vr/vrcontrol'
require 'vr/vrcomctl'
require 'vr/vrtooltip'

module FSImageList1
  Imagelist = VRLocalScreen.factory.newimagelist 13,13

Imagelist.add  SWin::Bitmap.loadString <<EEOOSS
BAN1OgEMU1dpbjo6Qml0bWFwAd5CTd4AAAAAAAAAdgAAACgAAAANAAAADQAA
AAEABAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAACAAACAAAAAgIAA
gAAAAIAAgACAgAAAgICAAMDAwAAAAP8AAP8AAAD//wD/AAAA/wD/AP//AAD/
//8A////////8AD////////wAPAAAAAAAPAACIiIiIiA+l8L+/v7+/DwAA+/
v7+/sPAAC/v7+/vw8AAPv7+/v7DwAAv7+/v78PAAAAAAAAAP8ADwv78P///w
AP8AAP////AA////////8AA=
EEOOSS

Imagelist.add SWin::Bitmap.loadString <<EEOOSS
BAN1OgEMU1dpbjo6Qml0bWFwAd5CTd4AAAAAAAAAdgAAACgAAAANAAAADQAA
AAEABAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAACAAACAAAAAgIAA
gAAAAIAAgACAgAAAgICAAMDAwAAAAP8AAP8AAAD//wD/AAAA/wD/AP//AAD/
//8A////////8ADwAAAAAP/wAACIiIiID/AACA+/v78P+l8IC/v7+/DwAAiA
v7+/sPAACID7+/v7AAAIiAAAAAAAAAiIiIiID/AACIiAAAD/8ADwAA/////w
AP////////AA////////8AA=
EEOOSS

Imagelist.add  SWin::Bitmap.loadString <<EEOOSS
BAN1OgEMU1dpbjo6Qml0bWFwAd5CTd4AAAAAAAAAdgAAACgAAAANAAAADQAA
AAEABAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAACAAACAAAAAgIAA
gAAAAIAAgACAgAAAgICAAMDAwAAAAP8AAP8AAAD//wD/AAAA/wD/AP//AAD/
//8A////////8ADwAAAAAA/wAPD/////D/AA8P////8P+l/w/0RE/w/wAPD/
////D/AA8P9ERP8P8ADw/////w/wAPD/RE8AD/AA8P///wgP8ADw////AP/w
APAAAAAP//AA////////8AA=
EEOOSS

end


$notifies_count=0

class MyForm < VRForm
  include VRMenuUseable
  include VRStatusbarDockable


  def setlisttype1            #Set Listview type 1
    @lv1.insertMultiItems(0,
          [ [["織田信長","おだのぶなが"],   1],
            [["羽柴秀吉","はしばひでよし"], 2],
            [["狸家康","とくがわいえやす"], 3]
          ])
  end

  def setlisttype2           #Set Listview type 2
    @lv1.insertItem(3,["売り子","うりこ"], 4)
    @lv1.insertItem(4,["買い手","かいて"], 5)
  end

  def maketree               #Set Treeview in 2 ways
    @tv1.insertMultiItems(WConst::TVI_ROOT,WConst::TVI_LAST,
        [["さようなものですか",0,
          [["さよう",2],["そうではござらぬ",1]]
         ],
         ["いらっしゃいませ",3,
          [["豚まん下さい",4,
            [["お釣り足りません",4]]
          ]]
         ]
        ])
    p=@tv1.insertItem(WConst::TVI_ROOT,WConst::TVI_LAST,"三都物語",3)
    @tv1.insertItem(p,WConst::TVI_LAST,"京都",10)
    @tv1.insertItem(p,WConst::TVI_LAST,"大阪",10)
    @tv1.insertItem(p,WConst::TVI_LAST,"神戸",10)
    @tv1.insertItem(p,WConst::TVI_LAST,"奈良は？",10)

    @tv1.insertMultiItems(WConst::TVI_ROOT,WConst::TVI_LAST,
        [["てんのう",10,[["めいじ"],["たいしょう"],["しょうわ"]] ]])
  end

  def settoolbar(tt)
    @tb1.setImagelist FSImageList1::Imagelist
    @tb1.addButton "tbtn1"
    @tb1.addButton "tbtn2"
    @tb1.addButton("tt",WConst::TBSTYLE_SEP)
    @tb1.addButton("tbtn3",WConst::TBSTYLE_CHECK)
    @tb1.autoSize

    tt.addTool(@tbtn1,"normal button1")
    tt.addTool(@tbtn2,"normal button2")
    tt.addTool(@tbtn3,"check button")
  end

  def setmenu
    setMenu newMenu.set(
         [ 
           ["&Listview",
             [["&1:Selections","menu1"],["&2:ColumnWidthReset","menu2"]] 
           ],
           ["List &Mode",[["&icon","licon"],["&report","lreport"]] ],
           [ "&Trackbar",[["&1:Value","tbval"]] ],
           ["&Help","help"]
         ])
  end

  def construct
    move 10,40,600,480
    tt = createTooltip

    self.caption="CommonControlsTEST"
    setmenu

    addControl(VRToolbar,"tb1","tb1",0,0,300,20)
    addControl(VRListview,"lv1","Listview",220,30,200,200,WStyle::WS_BORDER)
    addControl(VRTreeview,"tv1","Treeview",10,30,200,200,WStyle::WS_BORDER)

    addControl(VRText,"edit1","log\r\n",10,240,400,130,WStyle::WS_VSCROLL)
    addControl(VRProgressbar,"pbar","progress", 430,30,120,20)
    addControl(VRTrackbar, "tbar",  "track bar",430,50,120,35)
    addControl(VREdit,"udedit","0",450,90,60,20)
    addControl(VRUpdown, "updw","updown",0,0,0,0, WStyle::UDS_INTBUDDYRIGHT)
    addStatusbar "status bar"

    tt.addTool(@lv1,"VRListview")
    tt.addTool(@tv1,"VRTreeview")
    tt.addTool(@edit1,"Log area by VRText")
    tt.addTool(@pbar,"VRProgressbar")
    tt.addTool(@tbar,"VRTrackbar")
    tt.addTool(@updw,"VRUpdown")
    tt.addTool(@statusbar,"VRStatusbar")

    settoolbar(tt)
    maketree

    @lv1.insertColumn(0,"名前",100)
    @lv1.insertColumn(1,"読み",100)
    setlisttype1
    setlisttype2

    @tbar.rangeMin=0; @tbar.rangeMax=100; @tbar.linesize=10
    @updw.setRange(0,1000); @updw.position=0
    
    @statusbar.setparts(3,[100,250,-1])
    @statusbar.setTextOf(1,"part1"); @statusbar.setTextOf(2,"part2")
  end

  def logging(str)
    @edit1.text+=str+"\r\n"
    @edit1.scrollTo(@edit1.countLines,1)
    @pbar.step
  end

  def tbtn1_clicked
    messageBox "ToolbarButton1 Clicked"
  end

  def tbtn2_clicked
    messageBox "ToolbarButton2 Clicked"
  end

  def tbtn3_clicked
    if @tbtn3.checked? then
      msg="Checked"
    else
      msg = "Unchecked"
    end
    
    messageBox "ToolbarButton3 " + msg

  end

  def lv1_columnclick(subitem)
    $notifies_count+=1
    logging $notifies_count.to_s +
            ": ColumnClick(#{@lv1.getColumnTextOf(subitem)})"
  end

  def lv1_itemchanged(item,state)
    $notifies_count+=1
    logging $notifies_count.to_s + 
            ": ItemChange(#{@lv1.getItemTextOf(item,0)}:state=#{state})"
  end

  def lv1_begindrag
    a=[]
    @lv1.eachSelectedItems do |i| 
      a.push @lv1.getItemTextOf(i,1)
    end
    logging"Dragged(#{@lv1.countSelectedItems})=>"+a.join(":")
  end

  def tv1_selchanged(hitem,lparam)
    $notifies_count+=1
    logging $notifies_count.to_s+": SelChanged(#{@tv1.getItemTextOf(hitem)})"
    @lv1.clearItems
    if lparam<3 then setlisttype1 else setlisttype2 end
  end

  def tv1_itemexpanded(hitem,state,lparam)
    $notifies_count+=1
    logging $notifies_count.to_s+": ItemExpanded(#{@tv1.getItemTextOf(hitem)})"
  end

  def tv1_clicked
    logging "TView Clicked"
  end

  def tbar_clicked
    logging "Trackbar Clicked"
  end

  def updw_changed(pos)
    @udedit.text=pos.to_s
  end

  def menu1_clicked
    a=[]
    @lv1.eachSelectedItems do |i| 
      a.push @lv1.getItemTextOf(i,1)
    end
    logging"selected(#{@lv1.countSelectedItems})=>"+a.join(":")
  end

  def menu2_clicked
    @lv1.setColumnWidthOf(0,100)
    @lv1.setColumnWidthOf(1,100)
  end

  def licon_clicked
    @lv1.setViewMode 0
  end
  def lreport_clicked
    @lv1.setViewMode 1
  end

  def tbval_clicked
    logging "Trackbar=#{@tbar.position}"
  end
  
  def help_clicked
    messageBox "COMMONDIALOG TEST","comctltest2.rb",0
  end
end

#################################

VRLocalScreen.showForm(MyForm)
VRLocalScreen.messageloop

