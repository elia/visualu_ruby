require 'vr/vrcontrol'


class MyForm <VRForm
  def construct
    move 200,200,240,200
  self.show
    addControl VRButton,"b1","ボタン小",10,10,200,60
    addControl VRButton,"b2","ボタン大",10,80,200,60
  @b2.show
  sleep 1
    @font = @screen.factory.newfont( "ＭＳ 明朝",50 )
    @b2.setFont @font
  end
end


VRLocalScreen.showForm(MyForm)
VRLocalScreen.messageloop
