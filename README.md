# 🔉 타래
![간지나는 썸네일](https://github.com/HackathonOteam/O_Server/assets/98451999/70e7063c-0871-4a95-9b7c-12110d7b0d03)

### **▶️ 대화로 뭉치는 기억일기, 타래**

**치매 환자 또는 노년층이 음성으로**
<br>**쉽게 하루를 기록하고 추억을 상기할 수 있는 앱, 타래**

**서서히 자신을 잃어가는 병,**
<br>**그 본인과 가족을 위해 당신을 대신 기억해드릴게요.**

<br>


### 앱명 : 타래

'실이나 끈 따위를 모은 것' 이라는 뜻으로, 기억의 실마리를 모아 이어주는 서비스가 되겠다는 의미를 담았습니다. 

<br>

### R&R

| 분야 | 이름 | 포지션 |
| --- | --- | --- |
| 기획 | 이지훈 | 📈 서비스 기획 |
| 디자인 | 최은정 | 📢 서비스 디자인 |
| 개발 | [신상우](https://github.com/iosdevSW) | 🔦 iOS 화면 UI 구현, 서버 연동 |
| 개발 | [정보영](https://github.com/zxcvb2002) | 📱 iOS 화면 UI 구현, 서버 연동 |
| 개발 | [최지철](https://github.com/jife98) | 📱 iOS 화면 UI 구현, 서버 연동 |
| 개발 | [곽다은](https://github.com/daeunkwak) | 💻 DB 및 API 구축, 서버 배포 |
| 개발 | [한호정](https://github.com/hojeong2747) | 🖥️ DB 및 API 구축, 서버 배포 |

<br>

### 4th Ne(o)rdinary HACKATHON 목적

### **💭 "Chat GPT"의 API 활용 💭** ###


<br>


## 🔎 시장 분석과 고객 분석 및 사업

### **1️⃣ 시장 분석** 

🔔 평균 실종 중 정보 양극화와 인구 양극화에 집중하여, '디지털 소외 계층의 노인들'을 고객으로 선정하였습니다. 

**1. 정보 양극화**
- IT 환경이 급변하는 상황 속에 고령 인구가 대표적인 디지털 소외 계층으로 주목
    - 전체: 세대 별로 스마트폰 활용 능력을 분석한 결과, 고령 인구는 다른 세대의 절반 이하
    - 상세: 고령 인구는 정보검색 등 텍스트를 많이 입력하거나 복잡한 상황일 때 더욱 불편 체감

**2. 인구 양극화**
- 저출산, 고령화가 도래하며 인구 피라미드가 정규 분포를 벗어날 것으로 전망
    - 현황: 2022년 기준 고령(만 65세 이상) 인구가 전체 인구의 18% 차지
    - 전망: 2070년 기준 고령(만 65세 이상) 인구가 전체 인구의 70% 차지 예상

> Source: KOSIS 인구상황판

<br>

### **2️⃣ 고객 분석** 

🔔 치매 환자와 그 가족의 고통에 주목하여 일기/추억의 리마인드 기능을 기획

**1. 니즈**
- 고령층과 IT 환경 사이의 장벽을 음성 변환 기능과 Chat GPT의 요약 기능으로 해결
- Pain Points
    - 고령층의 신체/인지적 특성: 노안으로 인해 맥락 파악 어려움
    - 고령층의 접근이 어려운 설계 방식: 터치 타자 기반이라 내용 입력 어려움
- Solutions
    - 음석-텍스트 변환 기능
    - 텍스트 자동 요약 기능

**2. 문제 상황 구체화**
- 치매 환자와 그 가족의 고통에 주목하여 일기/추억 리마인드 기능을 기획
- Pain Points
    - 치매 유병률: 2050년 기준 고령 인구 중 15% 예상
    - 치매 환자수: 2050년 기준 270만명 예상
- Solutions
    - 일기 대신 기록
    - 추억 리마인드

<br>

### **3️⃣ 사업성** 
- 앱 자체 수익(앱 내 광고 등)은 추구하지 않고, 고령 인구 소비 행태 등 빅데이터를 판대하거나 서비스 자체를 대기업에 매각할 수 있습니다.
- 시중 일기 어플과 비교했을 때, 사용법이 간단하고 고령층을 겨냥한 주요 기능을 통해 니치 마켓을 선점할 수 있습니다.

<br>

## 💡 핵심 기능

**1. 리마인드 기능**
- 가입 후, 리마인드 기능에 대한 초기 가이드를 제공합니다.
- 기록에 따른 리마인드(1년 전 오늘, 누군가의 기념일, 좋았던 기억 등)를 확인할 수 있습니다. 대화를 통한 기록을 한 후, 일정 조건에 따라 기록을 홈에서 리마인드로 나타냅니다.

**2. 음성기록 / 대화형 기록 기능**
- **ChatGPT 기반 질문 기록**
    - 타래의 말과 질문을 강조해서 보여줍니다. 어르신 분들이 보시기에 편하시도록 타래의 질문을 크게 보여줍니다.
    - 대화 내용을 스크롤을 통해 다시 볼 수 있습니다. 대화는 남아있으니 언제든 다시 볼 수 있습니다.
    - 사용자의 하루를 타래에게 들려줍니다. 타래는 사용자의 하루에 공감하고 질문을 건넵니다. 

**3. 기록 요약 기능**
- 기록 완료 후 사용자가 기억하기 편하도록 요약합니다.
    - 감정을 캐치하고, 감정 아이콘으로 보여줍니다. 타래와 대화한 내용을 바탕으로 그 날의 기록과 감정을 카드로 요약합니다.
    - 요약이 된 후에도 다시 들어가서 대화를 계속할 수 있습니다. 

**4. 월별 감정 캘린더 기능**
- 기록된 일기와 감정 아이콘과 함께 보관됩니다. 이번달 감정을 통해 기록된 일기들을 다시 볼 수 있습니다.
- 쌓인 기록과 감정은 이번 달의 감정 분석을 만들어 냅니다. 특정 감정을 해당 달에 몇 퍼센트 느꼈는지, 감정 분석을 통해 가장 많이 느낀 감정은 무엇인지 요약해서 보여줍니다. 

<br>

## 💡 구현 화면
<img width="1920" alt="Slide 16_9 - 1" src="https://github.com/HackathonOteam/O_Server/assets/98451999/bf020913-6c76-4598-b105-d321879fa43b">

<img width="1920" alt="Slide 16_9 - 2" src="https://github.com/HackathonOteam/O_Server/assets/98451999/f4de01f7-443d-45cf-8c10-acc25e710c17">

![Slide 16_9 - 3](https://github.com/HackathonOteam/O_Server/assets/98451999/51bbbb91-1129-4b49-b1cf-ff4f768832bf)

<img width="1920" alt="Slide 16_9 - 4" src="https://github.com/HackathonOteam/O_Server/assets/98451999/4a9e2daf-4485-4efe-ba58-dd52373a3777">

<br>
<br>

## :computer: Technology

- iOS
    - ![Xcode](https://img.shields.io/badge/Xcode-007ACC?style=flat-square&logo=Xcode&logoColor=white)
      ![Swift](https://img.shields.io/badge/Swift-F54A2A?style=flat-square&logo=swift&logoColor=white)
    - ![UIkit](https://img.shields.io/badge/UIkit-2396F3?style=flat-square&logo=swift&logoColor=white)
      ![AlamoFire](https://img.shields.io/badge/Alamofire-DB5C3F?style=flat-square&logo=swift&logoColor=white)
- Server
    - ![IntelliJ IDEA](https://img.shields.io/badge/IntelliJ%20IDEA-000000.svg?style=flat-square&logo=intellij-idea&logoColor=white)
      ![Java](https://img.shields.io/badge/Java-%23ED8B00.svg?style=flat-square&logo=Java&logoColor=white)
      ![Springboot](https://img.shields.io/badge/Springboot-6DB33F?style=flat-square&logo=springboot&logoColor=white)
      ![Shell Script](https://img.shields.io/badge/Shell_Script-%23121011.svg?style=flat-square&logo=gnu-bash&logoColor=white)
      ![Gradle](https://img.shields.io/badge/Gradle-02303A.svg?style=flat-square&logo=Gradle&logoColor=white)
      ![Swagger](https://img.shields.io/badge/-Swagger-%23Clojure?style=flat-square&logo=swagger&logoColor=white)
    - ![Spring Data JPA](https://img.shields.io/badge/Spring%20Data%20JPA-6DB33F?style=flat-square&logo=spring&logoColor=white)
      ![QueryDSL](https://img.shields.io/badge/QueryDSL-007ACC?style=flat-square&logo=kotlin&logoColor=white)
    - ![MySQL](https://img.shields.io/badge/MySQL-%2300f.svg?style=flat-square&logo=mysql&logoColor=white)
      ![RDS](https://img.shields.io/badge/AWS%20RDS-527FFF?style=flat-square&logo=Amazon%20RDS&logoColor=white)
    - ![GitHub Actions](https://img.shields.io/badge/Github%20Actions-%232671E5.svg?style=flat-square&logo=githubactions&logoColor=white)
      ![EC2](https://img.shields.io/badge/AWS%20EC2-FF9900?style=flat-square&logo=Amazon%20EC2&logoColor=white)
      ![Elastic Beanstalk](https://img.shields.io/badge/Elastic%20Beanstalk-232F3E?style=flat-square&logo=Amazon-AWS&logoColor=white)
      ![Nginx](https://img.shields.io/badge/Nginx-%23009639?style=flat-square&logo=nginx&logoColor=white)
- Co-working Tool
    - ![Notion](https://img.shields.io/badge/Notion-%23000000.svg?style=flat-square&logo=notion&logoColor=white)
      ![Postman](https://img.shields.io/badge/Postman-FF6C37?style=flat-square&logo=postman&logoColor=white)

<br>

## 📄 ER Diagram

<img width="418" alt="KakaoTalk_20230611_085909443" src="https://github.com/HackathonOteam/O_Server/assets/98451999/0a8906c9-30ca-4a6c-885a-6a253acbce04">

<br>
<br>

## 🎨 디자인 무드보드

![디자인가이드 설명](https://github.com/HackathonOteam/O_Server/assets/98451999/dfcbb42f-b224-4e3b-93dd-e5f1f3aa7f90)

