# ABAP Dictionary
ABAP 프로그램에 사용되는 오브젝트들(Table, View, Structure, Types...)을 ABAP Dictionary라고 부른다. <br>
이러한 오브젝트들의 정보를 Metadata 또는 Data Definition이라 정의하며, 데이터 구조를 정의하고 관리하는 역할을 <br> ABAP Dictionary가 하게 된다.

ABAP Dictionary는 시스템에 사용되는 오브젝트들을 중앙집중식으로 관리한다. <br>
신규 또는 변경된 Metadata의 정보는 모든 시스템 오브젝트에게 알려진다.<br>
다시 말해서, ABAP Dictionary는 동적으로 ABAP WorkBench와 연결되어 있기 때문인데 <br>
오브젝트를 변경하면 ABAP Program과 Screen에 바로 영향을 미쳐버린다. <br>
또한 시스템에서 사용되는 모든 데이터들을 중앙집중적으로 관리한다. <br> <br>

***이것은 Data Integegrity(무결성), Data Consistency(일관성), Data Security(안정성)를 보장하게 된다.*** <br>

ABAP Dictionary는 통상적으로 우리가 아는 Database Object인 테이블만을 의미하는 것이 아니라 <br>
Definition, Databas Object, ABAP Tool의 세 가지 영역으로 분류된다.<br>
<img src = "https://help.sap.com/doc/saphelp_nw73ehp1/7.31.19/en-us/cf/21ea0b446011d189700000e8322d00/loiod88f9389ef6e44abb86fd330205666b1_LowRes.png" width = "400" hegit = "200">

## 2 ABAP Dictionary의 종류
테이블과 같은 개별 오브젝트들을 살펴보기 이전에 ABAP Dictionary의 3가지 유형에 대해서 간략히 정의해 본다. <br>

1. Database Object <br>
    • Table은 시스템에서 생성된 데이터를 저장하는 실제 물리적인 공간 데이터베이스의 바탕을 이룸. <br>
    • View는 하나 이상의 Table이 논리적으로 결합한 구조, 실제 데이터를 가지는 것이 아니라 Table 데이터를 조합해서 <br>
    조건에  맞게 조회하는 기능을 주로 담당. <br>

2. Type Definition <br>
ABAP Dictionary는 사용자 정의 Type을 지원하기 때문에 개별 프로그램에서 사용되는 Type은 TYPES 구문으로 생성하지만 <br>
모든 ABAP 프로그램에서 사용할 수 있는 Type Object 는 ABAP Dictionary에서 정의한다. <br>
중앙집중으로 관리되기 때문에 Type Object를 변경하면 모든 프로그램에 영향을 미치게 된다. <br><br>
    • Data Element : 필드의 내역과 같은 어의적인 정보를 가짐. <br>  Domain은 테이블 필드의 기술적 속성을 정의하는 오브젝트이며, ABAP 프로그램에서 참고해서 변수를 선언할 필요는 X <br><br>
    • Structure : Structure는 Type을 가지는 Component로 구성되어져 있다. <br><br>
    • Table Type : 인터널 테이블의 기능적 속성을 정의하는 데 사용됨. 특별한 형태인 Range Table Type이 존재함.