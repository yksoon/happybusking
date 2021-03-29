# 해피버스킹 V3 프로젝트  
기존 해피버스킹 프로젝트에 상업공간을 추가한 프로젝트  

개발환경: Windows 10  
사용 라이브러리: Cordova, jQuery mobile,  
사용 API: google firebase, kakaomap, jsPDF, html2canvas  
사용 DB: MariaDB  
작업툴: 디자인 시안 - Adobe XD, VSCode  
서버: 윈도우서버, Tomcat  
작업인원: 4명 (본인이 맡은 역할 - 기획, 개발)  
<br/>

---

## 개요
기존 버스킹 플랫폼 해피버스킹에 공연무대가 갖추어져 있는 개인 사업자의 사업장 홍보 및  
아티스트들의 고용보험 가입을 위 업데이트 프로젝트  
1. 사업주 - 자신의 공연 가능한 상업공간을 등록하여 아티스트를 모집하고 공연 및 가게 홍보를 할수 있다.  
2. 아티스트 - 모집중인 공연에 대해 공연을 신청할 수 있고, 공연에 따른 고용보험 신고도 가능하다.  
<br /> 
사업주 디자인 시안

![사업주 시안](https://user-images.githubusercontent.com/62881936/112793555-765e7100-90a0-11eb-8119-7f1c71b8a490.jpg)  

아티스트 디자인 시안

![아티스트 시안](https://user-images.githubusercontent.com/62881936/112793571-7c545200-90a0-11eb-977d-516c7ccf2e1b.jpg)  

<br />

## 작업기간
2020년 11월 ~ 12월 : 기획  
2021년 1월 ~ 3월 : 개발  
2021년 3월 ~ 4월 : 테스트 및 홍보기획  
2021년 4월 ~  : 배포  

## 프로젝트 특징
cordova 를 이용하여 아이폰, 안드로이드 웹 앱으로 작성.  
프론트엔드 개발은 Javascript 및 jQuery mobile 을 이용하여 모바일 환경 웹 앱으로 개발.  
ajax 를 이용한 java 백엔드 서버와 통신.  
윈도우 서버에서 작업을 하여 스케줄러를 이용한 자동 SQL  
firebase를 이용하여 사용자에게 push알림 서비스  

## 실제 앱 구동 모습
1. 메인  

![메인](https://user-images.githubusercontent.com/62881936/112794294-9b071880-90a1-11eb-89b8-d2c28b0db4ea.jpg)

2. 카페&버스킹존  

![카페_버스킹존](https://user-images.githubusercontent.com/62881936/112794293-9a6e8200-90a1-11eb-9b4a-96612676a443.jpg)  

3. 공연등록  

![공연모집등록](https://user-images.githubusercontent.com/62881936/112794292-9a6e8200-90a1-11eb-9174-7ab721abe059.jpg)

4. 계약이력  

![공연신청이력](https://user-images.githubusercontent.com/62881936/112794291-99d5eb80-90a1-11eb-89a1-fafa74c338e9.jpg)

5. 공연상세  

![공연상세](https://user-images.githubusercontent.com/62881936/112794290-99d5eb80-90a1-11eb-9b37-26dbd312c16b.jpg)

6. 전자계약서  

![전자계약서](https://user-images.githubusercontent.com/62881936/112794285-98a4be80-90a1-11eb-8e7e-79a30defd52b.jpg)  
<b>(PDF 다운로드 가능)</b>
<br/>

```
$.ajax({
    type: "GET",
    cache: false,
    url: 'url',
    data: {
        data: data
    },
    contentType: "application/xml; charset=utf-8",
    dataType: "xml",
    timeout: 30000,
    success: function (data) {
      // success code
    }
});
```
<b>프로젝트 하던 중 제일 많이 사용한 ajax 통신</b>  
<br/>

## 프로젝트 개선사항
Firebase Storage 에서 사진 업로드 및 다운로드를 하다보니 이에 따른 딜레이 현상 발생.  
Native로 개발된 앱이 아니다보니 전반적인 성능을 모바일 OS 의 WebView에 의존. 퍼포먼스적으로 불리함.  

## 마치며
기회가 된다면 React Native로 앱을 치환하여보고 싶은 생각이 든다.  
물론 더 공부하고 해봐야 하겠지만, 다음에 기회가 된다면 React Native로 개발을 해보고싶다.
기존 프로젝트가 cordova 로 된 javascript 프로젝트였지만 정말 많은 공부와 도움이 되었다.
