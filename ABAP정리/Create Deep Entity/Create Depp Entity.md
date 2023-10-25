# Create Deep Entity
Assocication을 만들어준다라고 표현

1. Data Model -> 생성 -> 연관성(assocication)
2. principal Entity = Header <br> Dependent Entity = Body라고 보면 된다.
3. 탐색속성 -> Navigation Property <br> 키 관계는 라인 선택해주고 삭제해버린다. <br> &nbsp; 로직 구현중에 키를 맺어줄 때 또는 관계를 맺어줄 때 오히려 문제생기는 경우가 빈번하기 때문에
4. Assocication 생성 해주고 나면 <br> ABAP 필드이름이라고 생기는데 Deep Entity 로직 구현 중 Data : ABAP 필드이름이 들어가게 된다. <br> 코딩하기 편리한 필드명으로 바꾸어서 사용해도 된다.
```abap
* Create Deep Entity 구현부
DATA : Begin of
    Include Type " Header
    Data :  " Body
end of.    
```