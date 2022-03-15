public with sharing class CntrlAllCheckByJs {
    public List<MemberWrapper> memWrapperList { get; set; }

    private class MemberWrapper {
        public boolean isSelected { get; set; }
        public String memName { get; set; }

        public MemberWrapper() {
            isSelected = false;
        }
    }

    public CntrlAllCheckByJs() {
        memWrapperList = new List<MemberWrapper>();

        for (Integer i = 0; i < 10; i++) {
            MemberWrapper memWrapper = new MemberWrapper();
            memWrapper.memName = '홍길동' + i;
            memWrapperList.add(memWrapper);
        }
    }

    public void getSelectedItem() {
        List<String> selMembersNameList = new List<String>();

        for (MemberWrapper memWrap: memWrapperList) {
            if (memWrap.isSelected) {
                selMembersNameList.add(memWrap.memName);
            }
        }

        System.debug('선택된 멤버명: ' + selMembersNameList);
    }
}