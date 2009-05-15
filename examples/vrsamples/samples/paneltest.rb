require "vr/vruby"
require "vr/vrcontrol"

frm=VRLocalScreen.newform

def frm.construct
  self.extend VRResizeSensitive
  self._init

  self.caption="PanelTest"
  addControl(VRStatic,  "label1","�T�C�Y�ύX��messagebox�o�܂�",200,10,250,40)

  addControl(VRGroupbox,"group1","�킭",80,50,300,100)
  addControl(VRButton,"btn1","����",5,20,80,30)
  addControl(VRButton,"btn2","�E��",85,20,80,30)

  @rad1=@group1.addControl(VRRadiobutton,  "rad01","���W�I1",5,20,80,40)
  @rad2=@group1.addControl(VRRadiobutton,  "rad02","���W�I2",150,20,80,40)
end

def frm.btn1_clicked
  @group1.move @group1.x-20,@group1.y, @group1.w, @group1.h
end

def frm.btn2_clicked
  @group1.move @group1.x+20,@group1.y, @group1.w, @group1.h
end

def frm.self_resize(x,y)
  messageBox "(#{x},#{y})","resized",0
end



frm.create.show
VRLocalScreen.messageloop
exit