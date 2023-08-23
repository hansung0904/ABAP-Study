# WRITE 구문
WRITE 구문은 OUTPUT 리스트에 데이터를 쓰는 기능을 주로 하게 되며, 값을 할당하는 (MOVE) 기능도 수행한다. <br>
리스트용으로 사용될 때에는 데이터를 LIST BUFFER에 저장한다. <br>
OUTPUT 리스트에 사용될 수 있는 항목은 다음과 같다. <br>

-   DATA 구문으로 선언된 필드
-   TABLES 구문으로 선언된 구조체의 항목
-   FIELD-SYMBOL로 선언된 필드 심볼
-   언어에 종속적이지 않은 Text 문장

```ABAP
WRITE AT pl.(position and lenght specification)
         option. (formatting option)
         ofmt. (output format by field)
         AS CHECKBOX. (output as checkbox)
         AS SYMBOL. (output as symbol)
         AS ICON. (output as ICON)
```
