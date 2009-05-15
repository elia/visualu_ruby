require "vr/vrcontrol"

#
#  Declare customized control
#

class MyCheckbox < VRCheckbox
  def clicked
    if checked? then
      msg="�t�����������"
    else
      msg="�O�����������"
    end

    messageBox msg,"�m�F",0
  end

end


#
#   Use it.

frm=VRLocalScreen.newform
frm.move 100,100,200,100

def frm.construct
  self.caption="MyCheckboxes"
  addControl(MyCheckbox,"mchk1","����",10,10,80,20)
  addControl(MyCheckbox,"mchk2","�����",10,30,80,20)
end

frm.create.show
VRLocalScreen.messageloop
exit
