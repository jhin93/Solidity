# Solidity

이곳은 Solidity를 위한 공간입니다.
블록체인 개발자를 향하여.



[ Solidity 학습 순서 ]
완료된 과정은 우측에 완료된 날짜와 함께 완료라고 작성.(ex 프로그래머스 4/17 완료)

1.  크립토좀비
https://cryptozombies.io/ko/course


2. 인프런
https://www.inflearn.com/course/blockchain-%EC%9D%B4%EB%8D%94%EB%A6%AC%EC%9B%80-dapp#curriculum

3. dapp university.
https://www.youtube.com/watch?v=CgXQC4dbGUE&t=783s


- 공식문서.
https://solidity-kr.readthedocs.io/ko/latest/index.html



[Warm-up reference]
시작하기 전에 읽고 시작하자.

블록체인이란(원리, 활용, 전망)  
http://wiki.hash.kr/index.php/%EB%B8%94%EB%A1%9D%EC%B2%B4%EC%9D%B8#.EC.9E.91.EB.8F.99_.EC.9B.90.EB.A6.AC

블록체인 구조 설명  
https://brownbears.tistory.com/371?category=281929

작업증명  
https://brownbears.tistory.com/373?category=281929  

지분증명  
http://wiki.hash.kr/index.php/%EC%A7%80%EB%B6%84%EC%A6%9D%EB%AA%85#cite_note-2  
https://www.youtube.com/watch?v=psKDXvXdr7k&t=64s  

우로보로스 지분증명  
http://wiki.hash.kr/index.php/%EC%9A%B0%EB%A1%9C%EB%B3%B4%EB%A1%9C%EC%8A%A4_%EC%A7%80%EB%B6%84%EC%A6%9D%EB%AA%85  

nonce 설명  
http://wiki.hash.kr/index.php/%EB%85%BC%EC%8A%A4_(%EC%9E%84%EC%8B%9C%EA%B0%92)

bits 설명(+블록체인 작동 방식 설명)  
https://homoefficio.github.io/2016/01/23/BlockChain-%EA%B8%B0%EC%B4%88-%EA%B0%9C%EB%85%90/  

스마트 컨트랙트란?  
https://medium.com/haechi-audit-kr/smart-contract-a-to-z-79ebc04d6c86  

web3.js란?  
http://wiki.hash.kr/index.php/Web3.js  

node.js란?  
http://sblog.netraweb.com/node-js-%EA%B0%95%EC%A2%8C-node-js-%EB%9E%80-%EA%B0%9C%EB%85%90%EA%B3%BC-%EC%86%8C%EA%B0%9C/  

nft란? https://v.kakao.com/v/20210401051201642  
코인과 토큰의 차이 https://www.tokenpost.kr/terms/11550  
코인 메인넷이란? https://webruden.tistory.com/530  

geth 터미널 명령어  
https://geth.ethereum.org/docs/interface/command-line-options



[솔리디티 관련 자료 모음]

- 문법

솔리디티 코드 레이아웃(스타일가이드)  
https://docs.soliditylang.org/en/v0.5.2/style-guide.html#code-layout  
https://medium.com/returnvalues/%EC%86%94%EB%A6%AC%EB%94%94%ED%8B%B0-v-0-5-2-%EC%8A%A4%ED%83%80%EC%9D%BC-%EA%B0%80%EC%9D%B4%EB%93%9C-19e2686201f6

여기는 문법개념을 분류해서 예시함수들로 설명함. visibility, 함수 제어자, 데이터 유형.  
https://potensj.tistory.com/18?category=671470  

접근 제어자(Visibility)에 대해서만 다룬 글  
https://noooop.tistory.com/entry/Solidity-%EA%B3%B5%EB%B6%80-Visibility-%EA%B0%80%EC%8B%9C%EC%84%B1?category=1031030  
https://caileb.tistory.com/140  

상태 제어자 설명 잘해놓은 글  
https://codemath.github.io/Solidity-%EC%9D%B4%EB%8D%94%EB%A6%AC%EC%9B%80-%EA%B8%B0%EB%B0%98-Dapp-%EA%B0%9C%EB%B0%9C%EA%B8%B0(2)-Solidity-%EC%96%B8%EC%96%B4-%EC%A0%95%EB%A6%AC/  

여긴 스마트 컨트랙트 구조, 변수, 데이터 위치 등 전반적으로 다룬다.  
https://d2fault.github.io/2018/03/19/20180319-about-solidity-1/  


storage와 memory  
https://www.geeksforgeeks.org/storage-vs-memory-in-solidity/  

calldata  
https://medium.com/day34/solidity-0-5-0-%EC%97%90%EC%84%9C%EC%9D%98-%EB%B3%80%EA%B2%BD%EC%82%AC%ED%95%AD%EC%9D%84-%EC%86%8C%EA%B0%9C%ED%95%A9%EB%8B%88%EB%8B%A4-ab6104296164  

https://docs.soliditylang.org/en/v0.5.3/types.html  


- 개념

pragma란?  
https://m.blog.naver.com/PostView.nhn?blogId=wnsdnjsjay&logNo=150178059882&proxyReferer=https:%2F%2Fwww.google.com%2F  

msg란?  
msg (tx 와 block 포함)는 유용한 전역 변수로 블록체인에 접근할 수 있는 다양한 속성들을 담고 있습니다.  
msg.sender 는 외부에서 지금 함수를 호출한 주소를 나타냅니다.  
https://solidity-kr.readthedocs.io/ko/latest/introduction-to-smart-contracts.html?highlight=msg#subcurrency 에서 '유용한 전역 변수' 검색.  

msg 멤버 값.  
https://solidity-kr.readthedocs.io/ko/latest/units-and-global-variables.html#index-2  


자료형 (강철의 블록체인 유튜브 채널 운영자의 블로그)  
https://needjarvis.tistory.com/255

SHA-3 란?  
https://ko.wikipedia.org/wiki/SHA-3

keccak-256이란?  
http://wiki.hash.kr/index.php/Keccak-256

abi란?  
https://hucet.tistory.com/46  
https://cryptozombies.io/ko/lesson/6/chapter/3  

이더리움과 abi 관련. api와 비교.  
https://medium.com/pocs/ethereum-abi%EC%99%80-%EA%B4%80%EB%A0%A8%EB%90%9C-q-a-%EC%A0%95%EB%A6%AC-40e639ee1a03  

abi-encodepacked란?  
https://frontalnh.github.io/categories/ethereum/blockchain/  

솔리디티에서의 event에 대하여 (dApp = 스마트 컨트랙트 + 프론트엔드)  
https://nujabes403.medium.com/solidity-event%EC%97%90-%EB%8C%80%ED%95%B4%EC%84%9C-6ed040e12808  

매핑과 구조체의 차이  
https://m.blog.naver.com/PostView.nhn?blogId=blokorea&logNo=221311000461&proxyReferer=https:%2F%2Fwww.google.com%2F  

구조체 배열 사용예시  
https://hatpub.tistory.com/56  

생성자(constructor)  
https://caileb.tistory.com/137  
https://docs.soliditylang.org/en/v0.7.5/contracts.html?highlight=constructor#constructors  
  
생성자의 가시성에 대한 이슈 업데이트 - Visibility (public / external) is not needed for constructors anymore:  
https://docs.soliditylang.org/en/v0.7.0/070-breaking-changes.html#functions-and-events  

가스란?  
https://phemex.com/ko/academy/%EC%9D%B4%EB%8D%94%EB%A6%AC%EC%9B%80-%EA%B0%80%EC%8A%A4%EB%9E%80  

payable 제어자  
https://www.crocus.co.kr/1254  

address 관련 (balance, transfer 등)  
https://solidity-kr.readthedocs.io/ko/latest/types.html?highlight=balance#address-members  
https://solidity-kr.readthedocs.io/ko/latest/units-and-global-variables.html  

이더리움 계정(Account), 트랜잭션(Transaction), 메시지(Message) + 스마트 컨트랙트  
https://brownbears.tistory.com/385  

안전한 난수생성  
https://ethereum.stackexchange.com/questions/191/how-can-i-securely-generate-a-random-number-in-my-smart-contract  

ERC-20(대체 가능)  
http://wiki.hash.kr/index.php/ERC-20  
- 사용규칙 : http://wiki.hash.kr/index.php/ERC-20#.EA.B7.9C.EC.B9.99  

ERC-721(대체 불가능)  
http://wiki.hash.kr/index.php/ERC-721#OpenZeppelin  

ERC-721 표준안  
https://github.com/ethereum/EIPs/blob/master/EIPS/eip-721.md#specification  

ERC 정리  
https://eips.ethereum.org/erc  

추상 컨트랙트(abstract contract), 인터페이스.  
https://goodgid.github.io/Ethereum-Basic-Solidity-(8)/  
https://medium.com/upstate-interactive/solidity-how-to-know-when-to-use-abstract-contracts-vs-interfaces-874cab860c56  

인터페이스  
https://solidity-kr.readthedocs.io/ko/latest/contracts.html#interfaces  
https://cryptozombies.io/ko/lesson/2/chapter/10  
https://goodgid.github.io/Ethereum-Basic-Solidity-(8)/  

오버라이딩  
https://docs.soliditylang.org/en/v0.6.0/contracts.html#function-overriding  
http://wiki.hash.kr/index.php/%EC%98%A4%EB%B2%84%EB%9D%BC%EC%9D%B4%EB%94%A9  
https://medium.com/upstate-interactive/solidity-override-vs-virtual-functions-c0a5dfb83aaf  

오버로딩  
http://wiki.hash.kr/index.php/%EC%98%A4%EB%B2%84%EB%A1%9C%EB%94%A9  
https://solidity-kr.readthedocs.io/ko/latest/contracts.html#index-11  

데이터 단위(비트, 바이트..) 8bit == 2^8 - 1 == (2^7) + (2^6) + ... + (2^0)  
https://kbench.com/?q=node/2635  
오버플로우 발생 예시  
https://steemit.com/kr-dev/@modolee/the-go-programming-language-3-3-1  
  
자주 쓰이는 패턴  
https://solidity-kr.readthedocs.io/ko/latest/common-patterns.html  

라이브러리(library)  
https://cryptozombies.io/ko/lesson/5/chapter/9  
https://solidity-kr.readthedocs.io/ko/latest/contracts.html#libraries  

assert : 조건이 충족되지 않으면 예외를 발생시킵니다 - 내부 에러에 사용됩니다.  
require : 조건이 충족되지 않으면 예외를 발생시킵니다 - 입력 또는 외부 요소의 에러에 사용됩니다.  
https://solidity-kr.readthedocs.io/ko/latest/units-and-global-variables.html?highlight=assert#index-3. 
  
assert : 함수 실행이 실패해도 남은 가스 돌려주지 않음.  
require : 함수 실행이 실패하면 남은 가스 되돌려줌.  
https://cryptozombies.io/ko/lesson/5/chapter/10  

블록체인 네트워크, 노드  
https://www.youtube.com/watch?v=u4voz9XBbWA  

캐시란  
https://ko.wikipedia.org/wiki/%EC%BA%90%EC%8B%9C  
https://mangkyu.tistory.com/69  

-Web3.js 와 컨트랙트의 통신  
필요한 것 : 컨트랙트 주소, 컨트랙트 ABI  
컨트랙트 주소 - 이더리움에 배포하면 영구적이고 고정된 주소를 얻게 됨. 복사해서 사용.  
컨트랙트 ABI - 이더리움에 이더리움에 배포하기 위해 컨트랙트를 컴파일할 때, 솔리디티 컴파일러가 자네에게 ABI를 줌.  
(해당 내용 챕터 : https://cryptozombies.io/ko/lesson/6/chapter/3)  

비동기 처리방식  
https://joshua1988.github.io/web-development/javascript/javascript-asynchronous-operation/  

자바스크립트 promise  
https://joshua1988.github.io/web-development/javascript/promise-for-beginners/  

자바스크립트 setinterval  
https://kyounghwan01.github.io/blog/JS/JSbasic/intervalFunction/#setinterval  

자바스크립트 es6 for of(+for in)  
https://jsdev.kr/t/for-in-vs-for-of/2938  

자바스크립트 template literal  
https://developer.mozilla.org/ko/docs/Web/JavaScript/Reference/Template_literals  

.on 이벤트 바인딩  
http://www.devkuma.com/books/pages/232  

indexed 키워드  
https://solidity-kr.readthedocs.io/ko/latest/miscellaneous.html#index-6  
https://docs.soliditylang.org/en/latest/contracts.html#events  

web3js에서 메소드, 이벤트를 다루는 법  
ex - CryptoZombies.methods.createRandomZombie(name)  
ex - cryptoZombies.events.NewZombie()...  
