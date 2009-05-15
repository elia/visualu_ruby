
require 'vr/vrcomctl'
require 'vr/vrtwopane'

module MyForm
  include VRHorizTwoPane

  def construct
    addPanedControl(VRTreeview,"tv1","TEST1")
    addPanedControl(VRListview,"lv1","TEST2")

    @lv1.insertColumn(0,"���O",100)
    @lv1.insertColumn(1,"�ǂ�",100)
    @lv1.insertItem(0,["�D�c�M��","�����̂ԂȂ�"])
    @lv1.insertItem(1,["�H�ďG�g","�͂��΂Ђł悵"])

    @tv1.insertItem(WConst::TVI_ROOT,WConst::TVI_LAST,"�^�񒆂̋�؂�ڂ͈ړ��ł��܂�",128,0)

    p=@tv1.insertItem(WConst::TVI_ROOT,WConst::TVI_LAST,"���悤�Ȃ��̂ł���",128,0)
    @tv1.insertItem( p              ,WConst::TVI_LAST,"���悤",128,2)
    @tv1.insertItem( p              ,WConst::TVI_LAST,"�����ł͂������",128,1)
  end
end

VRLocalScreen.showForm(MyForm)
VRLocalScreen.messageloop

