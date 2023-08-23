# RFC
Communication between applications of different systems in the SAP environment includes connections between SAP systems as well as between SAP systems and non-SAP systems. Remote Function Call (RFC) is the standard SAP interface for communication between SAP systems. RFC calls a function to be executed in a remote system.

There is now a whole series of different RFC variants, each of which has different properties and is used for a specific purpose.

***번역*** <BR>
***SAP 환경에서 서로 다른 시스템의 애플리케이션 간 통신에는 SAP 시스템 간 연결뿐만 아니라 SAP 시스템과 비SAP 시스템 간 연결도 포함된다. <BR>
RFC(remote function call)는 SAP 시스템 간의 통신을 위한 표준 SAP 인터페이스이다. <br>
RFC는 원격 시스템에서 함수를 호출한다.***

***이제 각기 다른 속성을 가지고 특정 목적에 사용되는 다양한 RFC 변형 시리즈가 있다.***

## Synchronous RFC
The first version of RFC is synchronous RFC (sRFC). This type of RFC executes the function call based on synchronous communication, meaning that the systems involved must both be available at the time the call is made.

***번역 <br>
동기방식 RFC <br>
RFC의 첫번째 형태는 sRFC(동기식 RFC)이다.<br> 
이 유형의 RFC는 동기식 통신을 기반으로 함수 호출을 생성한다. <br>
즉, 관련된 시스템은 호출이 이루어질 때 모두 사용 가능해야 한다.***

## Asynchronous RFC (aRFC)
Despite its name, aRFC is not really an asynchronous type of communication, as it does not meet the conditions for this. With sRFC, for example, the called system must be available during the call.

The main characteristics of aRFC are as follows:

Function control returns to the calling program directly after the call.

The parameters of asynchronous RFCs are not logged to the database, but sent directly to the server.

Asynchronous RFCs allow the user to carry on an interactive dialog with the remote system.

When the caller starts an aRFC, the called server must be available to accept the request.

The calling program can receive results from the asynchronous RFC.

Using aRFC is always a good idea when real-time communication is established with a remote system, where processing in the calling program should not be interrupted until the results of the called function module have been obtained (the term asynchronous is used in this sense here).

***번역*** <br>
***비동기라는 이름에도 불구하고 aRFC는 이에 대한 조건을 충족하지 않기 때문에 실제로는 비동기 유형의 통신이 아니다. <br>
예를 들어 sRFC를 사용하면 통화 중에 호출된 시스템을 사용할 수 있어야 한다.***

***RFC의 주요 특징은 다음과 같다.***

***기능 제어는 호출 직후 호출 프로그램으로 돌아간다.***

***비동기 RFC의 매개변수는 데이터베이스에 기록되지 않고 서버로 직접 전송된다.***

***비동기 RFC를 사용하면 사용자가 원격 시스템과 대화형 대화를 수행할 수 있다.***

***호출자가 aRFC를 시작하면 호출된 서버가 요청을 수락할 수 있어야 한다.***

***호출 프로그램은 비동기 RFC에서 결과를 받을 수 있다.***

***aRFC를 사용하는 것은 호출된 함수 모듈의 결과를 얻을 때까지 호출 프로그램의 처리가 중단되어서는 안되는 원격 시스템과 실시간 통신이 설정될 때 항상 좋은 방법이다. (여기에서의 비동기라는 용어는 이러한 의미로 사용된다.)***

## Transactional RFC (tRFC)
Transactional RFC (tRFC, previously known as asynchronous RFC) is a genuine asynchronous communication method that – unlike aRFC - executes the called function module just once in the RFC server. The remote system need not be available at the time when the RFC client program is executing a tRFC. The tRFC component stores the called RFC function, together with the corresponding data, in the SAP database under a unique transaction ID (TID).

If a call is sent, and the receiving system is down, the call remains in the local queue until a later time. The calling dialog program can proceed without waiting to see whether or not the remote call was successful. If the receiving system does not become active within a certain amount of time, the call is scheduled to run in batch.

tRFC is always used if a function is executed as a Logical Unit of Work (LUW). Within a LUW, all calls are

executed in the order in which they are called

executed in the same program context in the target system

are executed in a single transaction: they are either committed or rolled back as a unit.

Implementation of tRFC is recommended if you want to maintain the transactional sequence of the calls.

***번역 <br>***
***트랜잭션 RFC(tRFC, 이전에는 비동기 RFC로 알려졌다.)는 aRFC와 달리  호출된 함수 모듈을 RFC 서버에서 한 번만 실행하는 진정한 비동기 통신 방법이다. <br>***
***원격 시스템은 RFC 클라이언트 프로그램이 tRFC를 실행할 때 사용 가능할 필요가 없다. tRFC 구성 요소는 고유 트랜잭션ID(TID)로 SAP 데이터베이스에 해당 데이터와 함께 호출된 RFC 함수를 저장한다.***

***call이 전송되고 수신 시스템이 다운된 경우 call은 나중까지 로컬 대기열에 남아 있다. call dialog 프로그램은 원격 호출이 성공했는지 여부를 기다리지 않고 진행할 수 있다. 수신 시스템이 특정 시간 내에 활성화되지 않으면 call이 일괄적으로 실행되도록 예약된다.***

***tRFC는 함수가 논리적 작업 단위(LUW)로 실행되는 경우 항상 사용된다. LUW내에서 모든 호출은***

***호출된 순서대로 실행***

***대상 시스템의 동일한 프로그램 컨텍스트에서 실행***

***단일 트랜잭션에서 실행된다. 하나의 단위로 커밋되거나 롤백된다.***

***호출의 트랜잭션 순서를 유지하려면 tRFC를 구현하는게 좋다.***

## Disadvantages of tRFC
tRFC processes all LUWs independently of one another. Due to the amount of activated tRFC processes, this procedure can reduce performance significantly in both the send and the target systems.

In addition, the sequence of LUWs defined in the application cannot be kept. It is therefore impossible to guarantee that the transactions will be executed in the sequence dictated by the application. The only thing that can be guaranteed is that all LUWs are transferred sooner or later.

***번역 <br>***
***tRFC는 모든 LUW를 서로 독립적으로 처리한다. 활성화된 tRFC는 프로세스의 양으로 인해 이 절차는 송신 시스템과 대상 시스템 모두에서 성능을 크게 저하시킬 수 있다.***

***또한 애플리케이션에 정의된 LUW의 시퀀스를 유지할 수 없다. 따라서 트랜잭션이 응용 프로그램에서 지시한 순서대로 실행된다는 것을 보장한다는 것은 불가능하다. 보장할 수 있는 유일한 것은 모든 LUW가 조만간 전송된다는 것이다.***

## Queued RFC (qRFC)
To guarantee that multiple LUWs are processed in the order specified by the application, tRFC can be serialized using queues (inbound and outbound queues). This type of RFC is called queued RFC (qRFC).

qRFC is therefore an extension of tRFC. It transfers an LUW (transaction) only if it has no predecessors (based on the sequence defined in different application programs) in the participating queues.

Implementation of qRFC is recommended if you want to guarantee that several transactions are processed in a predefined order.

***번역 <br>***
***여러 LUW가 애플리케이션에서 지정한 순서대로 처리되도록 보장하기 위해 대기열 (인바운드 및 아웃바운드 대기열)을 사용하여 tRFC를 직렬화 할 수 있다. 이러한 유형의 RFC를 qRFC(Queued RFC)라고 한다.***

***따라서 qRFC는 tRFC의 확장이다. 참여 큐에 선행 작업이 없는 경우에만 LUW(트랜잭션)를 전송한다. (다른 애플리케이션 프로그램에 정의된 시퀀스 기반.)***

***여러 트랜잭션이 사전 정의된 순서로 처리되도록 보장하려는 경우 qRFC구현이 권장된다.***

## Background RFC (bgRFC)
bgRFC is the successor to tRFC and qRFC, with significant improvements in terms of performance and functionality.

```
Note

Using bgRFC instead of tRFC and qRFC is therefore urgently recommended.
```

## Local Data Queue (LDQ)
The LDQ is a special case in RFC communication. Here, no data is sent actively by the system. Instead, it is stored locally until being called by an external application (such as a mobile device) according to the pull principle.
```
Note

All asynchronous RFC procedures (tRFC, qRFC, bgRFC, LDQ) form part of the Background Communication concept. As these procedures have certain characteristics that set them apart from “normal“ RFC, they are described in detail separately.
```

## Data transfer
All RFC types are transferred by means of CPI-C or TCP/IP. They constitute a kind of gateway communication.
```
Caution
For information security-relevant aspects of communication with RFC, see the RFC/ICF Implementation Guide.
```