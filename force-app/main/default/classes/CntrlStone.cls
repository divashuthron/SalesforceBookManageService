public with sharing class CntrlStone {
    private final Integer       engraving_TotalCount                = 30;
    private final Integer       engraving_Count                     = 10;

    public Integer              engravingProbability                { get; set; }

    public Integer              engravingA_CraftCount               { get; set; }
    public Integer              engravingB_CraftCount               { get; set; }
    public Integer              negativeEngraving_CraftCount        { get; set; }

    public String               engravingType                       { get; set; }

    // 사용자가 선택한 각인명을 저장하는 변수
    public String               engravingA                          { get; set; }
    public String               engravingB                          { get; set; }
    public String               negativeEngraving                   { get; set; }
            
    public List<SelectOption>   engravingList                       { get; set; }
    public List<SelectOption>   negativeEngravingList               { get; set; }
            
    public String               renderEngravingA                    { get; set; }
    public String               renderEngravingB                    { get; set; }
    public String               renderNegativeEngraving             { get; set; }

    public CntrlStone() {
        // 초기 세팅

        /**
         * 1. 세공 확률
         *      >> 최초 75%
         *      >> 변동 확률 (최소 25% ~ 최대 75%)
         *      >> 세공 성공 시 -10%, 세공 실패 시 +10%
         */
            engravingProbability = 75;

         /** 
         * 2. 세공 진행 횟수
         *      >> 최초 0회
         *      >> 세공 시도 시 +1회
         */
            engravingA_CraftCount = 0;
            engravingB_CraftCount = 0;
            negativeEngraving_CraftCount = 0;

        /** 3. 각인 목록
         *      >> Stone__c.engraving__c, Stone__c.negativeEngraving__c 참조
         */
            engravingList = getEngravingList();
            negativeEngravingList = getNegativeEngravingList();

        /** 4. 세공 상태
         *      >> 최초 '◇◇◇◇◇◇◇◇◇◇'
         *      >> 세공 진행 시, 진행 결과는 왼쪽부터 순차적으로 기입
         *      >> 세공 성공 시 ◆, 실패 시 ◎ 입력
         */
            renderEngravingA = '◇◇◇◇◇◇◇◇◇◇';
            renderEngravingB = '◇◇◇◇◇◇◇◇◇◇';
            renderNegativeEngraving = '◇◇◇◇◇◇◇◇◇◇';
    }

    public void craft() {
        // 세공 처리

        /**
         * 1. check() 실행
         * 2. 세공 처리 진행
         * 3. 세공 결과 반영
         * 4. 해당 라인에 세공 카운팅 처리
         * 5. 확률 처리
         */

        if (check()) {
            if (Integer.valueOf(Math.random() * 100) <= engravingProbability) {
                // 세공 성공
    
                /**
                 * 세공 처리 된 칸 수 만큼 잘라낸 앞 부분 
                 *      + 새로 추가할 각인 결과
                 *      + (최대 각인 칸 수 - 세공 처리 된 칸 수) 만큼 남은 각인 붙이기
                 */
                switch on engravingType {
                    when 'A' {
                        if (engravingA_CraftCount != 0) {
                            // 1회 이상
                            /**
                             * 1일 때: (0,1) + ◆ + (1, 9)
                             */
                            renderEngravingA =
                                  renderEngravingA.substring(0, engravingA_CraftCount)
                                + '◆'
                                + renderEngravingA.subString(engravingA_CraftCount + 1, engraving_Count);
                        } else {
                            // 최초 시도
                            renderEngravingA =
                                  '◆'
                                + renderEngravingA.subString(engravingA_CraftCount + 1, engraving_Count);
                        }

                        // 세공 횟수 증가
                        engravingA_CraftCount += 1;
                    }
                    when 'B' {
                        if (engravingB_CraftCount != 0) {
                            // 1회 이상
                            renderEngravingB =
                                  renderEngravingB.substring(0, engravingB_CraftCount)
                                + '◆'
                                + renderEngravingB.subString(engravingB_CraftCount + 1, engraving_Count);
                        } else {
                            // 최초 시도
                            renderEngravingB =
                                  '◆'
                                + renderEngravingB.subString(engravingB_CraftCount + 1, engraving_Count);
                        }

                        // 세공 횟수 증가
                        engravingB_CraftCount += 1;
                    }
                    when 'C' {
                        if (negativeEngraving_CraftCount != 0) {
                            // 1회 이상
                            renderNegativeEngraving =
                                  renderNegativeEngraving.substring(0, negativeEngraving_CraftCount)
                                + '◆'
                                + renderNegativeEngraving.subString(negativeEngraving_CraftCount + 1, engraving_Count);
                        } else {
                            // 최초 시도
                            renderNegativeEngraving =
                                  '◆'
                                + renderNegativeEngraving.subString(negativeEngraving_CraftCount + 1, engraving_Count);
                        }

                        // 세공 횟수 증가
                        negativeEngraving_CraftCount += 1;
                    }
                }

                // 25% 이하가 아니라면 확률 10% 감소
                if (engravingProbability > 25) {
                    engravingProbability -= 10;
                }
            } else {
                // 세공 실패
    
                /**
                 * 세공 처리 된 칸 수 만큼 잘라낸 앞 부분 
                 *      + 새로 추가할 각인 결과
                 *      + (최대 각인 칸 수 - 세공 처리 된 칸 수) 만큼 남은 각인 붙이기
                 */
                switch on engravingType {
                    when 'A' {
                        if (engravingA_CraftCount != 0) {
                            // 1회 이상
                            renderEngravingA =
                                  renderEngravingA.substring(0, engravingA_CraftCount)
                                + '◎'
                                + renderEngravingA.subString(engravingA_CraftCount + 1, engraving_Count);
                        } else {
                            // 최초 시도
                            renderEngravingA =
                                  '◎'
                                + renderEngravingA.subString(engravingA_CraftCount + 1, engraving_Count);
                        }

                        // 세공 횟수 증가
                        engravingA_CraftCount += 1;
                    }
                    when 'B' {
                        if (engravingB_CraftCount != 0) {
                            // 1회 이상
                            renderEngravingB =
                                  renderEngravingB.substring(0, engravingB_CraftCount)
                                + '◎'
                                + renderEngravingB.subString(engravingB_CraftCount + 1, engraving_Count);
                        } else {
                            // 최초 시도
                            renderEngravingB =
                                  '◎'
                                + renderEngravingB.subString(engravingB_CraftCount + 1, engraving_Count);
                        }

                        // 세공 횟수 증가
                        engravingB_CraftCount += 1;
                    }
                    when 'C' {
                        if (negativeEngraving_CraftCount != 0) {
                            // 1회 이상
                            renderNegativeEngraving =
                                  renderNegativeEngraving.substring(0, negativeEngraving_CraftCount)
                                + '◎'
                                + renderNegativeEngraving.subString(negativeEngraving_CraftCount + 1, engraving_Count);
                        } else {
                            // 최초 시도
                            renderNegativeEngraving =
                                  '◎'
                                + renderNegativeEngraving.subString(negativeEngraving_CraftCount + 1, engraving_Count);
                        }

                        // 세공 횟수 증가
                        negativeEngraving_CraftCount += 1;
                    }
                }

                // 75% 이상이 아니라면 확률 10% 증가
                if (engravingProbability < 75) {
                    engravingProbability += 10;
                }
            }  
        }
    }

    /**
    public PageReference save() {
        // 결과 저장
    }
     */

     public void reset() {
        // 다시 하기
        engravingProbability = 75;

        engravingA_CraftCount = 0;
        engravingB_CraftCount = 0;
        negativeEngraving_CraftCount = 0;

        engravingList = getEngravingList();
        negativeEngravingList = getNegativeEngravingList();

        renderEngravingA = '◇◇◇◇◇◇◇◇◇◇';
        renderEngravingB = '◇◇◇◇◇◇◇◇◇◇';
        renderNegativeEngraving = '◇◇◇◇◇◇◇◇◇◇';
     }

    private Boolean check() {
        boolean result = false;
        // 1. 라인 별 최대 세공 횟수 초과 여부 검사 (라인 당 10회)
        // 2. 총 세공 횟수 초과 여부 검사 (전체 30회)

        if (
                engravingA_CraftCount > engraving_Count
            ||  engravingB_CraftCount > engraving_Count
            ||  negativeEngraving_CraftCount > engraving_Count
        ) {
            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR, '라인 당 10회까지 세공이 가능합니다. '));
            return result;
        }

        if (
                (engravingA_CraftCount + engravingB_CraftCount + negativeEngraving_CraftCount) > engraving_TotalCount
        ) {
            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR, '더 이상 세공을 진행할 수 없습니다. '));
            return result;
        }

        result = true;
        return result;
    }

    private List<SelectOption> getEngravingList() {
        // 각인1, 각인2 목록 불러오기
        List<SelectOption> engravingList = new List<SelectOption>();

        Schema.DescribeFieldResult fieldResult = Stone__c.engraving__c.getDescribe();
        List<Schema.PicklistEntry> pickListEntry = fieldResult.getPicklistValues();

        engravingList.add(new SelectOption('', ''));

        for (Schema.PicklistEntry pick: pickListEntry) {
            engravingList.add(new selectOption(pick.getValue(), pick.getLabel()));
        }

        return engravingList;
    }

    private List<SelectOption> getNegativeEngravingList() {
        // 감소각인 목록 불러오기
        List<SelectOption> negativeEngravingList = new List<SelectOption>();

        negativeEngravingList.add(new SelectOption('', ''));
        negativeEngravingList.add(new SelectOption('AttackDebuf', '공격력 감소'));
        negativeEngravingList.add(new SelectOption('DefenceDebuf', '방어력 감소'));
        negativeEngravingList.add(new SelectOption('AttackSpeedDebuf', '공격속도 감소'));
        negativeEngravingList.add(new SelectOption('MovementSpeedDebuf', '이동속도 감소'));

        /**
            Schema.DescribeFieldResult fieldResult = Stone__c.negativeEngraving__c.getDescribe();
            List<Schema.PicklistEntry> pickListEntry = fieldResult.getPicklistValues();

            negativeEngravingList.add(new SelectOption('', ''));

            for (Schema.PicklistEntry pick: pickListEntry) {
                negativeEngravingList.add(new selectOption(pick.getValue(), pick.getLabel()));
            }
        */

        return negativeEngravingList;
    }
}
