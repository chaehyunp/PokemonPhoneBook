# 🥚 포켓몬 연락처 앱

### 📑 개요

네트워크 통신을 이용해서 서버에서 랜덤 포켓몬 이미지를 불러오고, 이름과 전화번호를 함께 저장하는 앱입니다.

---

## ⏰ 프로젝트 일정

- **시작일**: 24/12/10  
- **종료일**: 24/12/12

---

## 🛠️ 기술 스택

### Development Environment
- OS: macOS Sequoia (15.0.1)
- IDE: Xcode 16.1

### Project Target Version
- iOS 16.0+
- Swift 5.0+

### Dependencies
- SnapKit (~> 5.7.1)

### UI
- UIKit (Programmatic UI) 
- Auto Layout

### Data Persistence
- Core Data

### Networking
- URLSession

---

### 🌳 코드 파일 구조

- 📂 Repository: 데이터 저장소와 관련된 폴더입니다
    - 🗄️ ImageRepository: 이미지 관련 데이터를 처리하는 저장소 클래스입니다

- 📂 Util: 유틸리티 함수들을 모아놓은 폴더입니다
    - 🔧 formatPhoneNumbersUtil: 전화번호 형식을 포매팅하는 유틸리티 클래스입니다


- 📂 View: UI 컴포넌트들을 포함하는 폴더입니다
    - 📂 List: 목록 관련 뷰들을 포함하는 하위 폴더
        - 📱 ContactCell: 연락처 셀 UI 컴포넌트
        - 📱 ListView: 목록 표시를 위한 뷰 컴포넌트

    - 📂 PhoneBook: 전화번호부 관련 뷰들을 포함하는 하위 폴더
        - 📱 PhoneBookView: 전화번호부 메인 뷰 컴포넌트

- 📂 ViewController: 뷰 컨트롤러들을 모아놓은 폴더입니다
    - 🎮 ListViewController: 목록 화면을 제어하는 컨트롤러
    - 🎮 PhoneBookViewController: 전화번호부 화면을 제어하는 컨트롤러
    - 🎮 ViewController: 기본 뷰 컨트롤러

---

### 🪲 트러블 슈팅
- [보라색 경고👾](https://chaehyunp.github.io/blog/?post=%5B20241213%5D_%5B%EB%B3%B4%EB%9D%BC%EC%83%89+%EA%B2%BD%EA%B3%A0%F0%9F%91%BE%5D_%5B%EC%B8%84%EB%9F%AC%EB%B8%94%5D_%5B%5D_%5B%EB%85%B8%EB%9E%80%EC%83%89%EB%8F%84%2C+%EB%B9%A8%EA%B0%84%EC%83%89%EB%8F%84+%EC%95%84%EB%8B%8C+%EC%83%89%EB%8B%A4%EB%A5%B8+%EA%B2%BD%EA%B3%A0...%E2%9A%A0%EF%B8%8F%5D_%5B%5D.md)
