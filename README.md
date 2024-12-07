# 카드 승인 예측
<br>

## 진행기간
> **2023/03~05**
<br>


## 사용 데이터
> **application_record: 고객의 사회적/경제적인 개인 정보**

> **credit_record: 고객의 납부 상태, 계약 진행 기간 정보**

> **https://www.kaggle.com/datasets/rikdifos/credit-card-approval-prediction**
<br>

## 개발 환경
> **R, Python**
<br>

### 역할
> **EDA,  Data Processing, Modeling**
<br>

## 분석 주제
> **고객 개인 정보 및 납부 기록을 활용한 카드 발급 승인 예측**
<br>


## 분석 요약

1. EDA&Data Preprocessing
    1. Feature Selection
    2. 공통 ID 추출 및 중복행 삭제
    3. 변수 변환
    4. 파생변수 생성
2. Hierarchial regression Analysis(매개 효과 검증)
3. Modeling
    1. K-fold Cross Validation
    2. Sampling(논문 참고)
    3. Hyper Parameter Tunning
<br>

## 분석 과정

### *EDA&Data Preprocessing*
<br>

<table width="100%">
  <tr>
    <td align="left" width="30%">
      <img src="https://github.com/user-attachments/assets/248ae0c6-ed45-4fb9-b09b-dcd5bbeb5849" width="95%">
    </td>
    <td align="right" width="70%">
      <img src="https://github.com/user-attachments/assets/8057755b-2f1b-4a88-b396-d7e0feaffe9a" width="95%">
    </td>
  </tr>
</table>

<br>

- 연체 상태가 `0, C, X는 승인`, `1,2,3,4,5는  승인거부`로 변환
- 0 의 경우 연체를 하나 기업 입장에서 짧은 기간안에 갚는 고객이기에 고객확보를 위해 승인으로 분류

<br>

<table width="100%">
  <tr>
    <td align="left" width="50%">
      <img src="https://github.com/user-attachments/assets/6e646b42-9c4d-4e2d-971c-95f92593de81" width="95%">
    </td>
    <td align="right" width="50%">
      <img src="https://github.com/user-attachments/assets/754874f3-a3a5-4392-ae19-3f5d0f1e6737" width="95%">
    </td>
  </tr>
</table>

<br>

- 소득 범주 여부에 따라 승인되는 비율 차이가 미비(Commercial associate : 0.982, Pensioner : 0.981, State servant : 0.985, Student : 0.985, Working : 0.983)
- 나머지 삭제한 열의 경우도 이같은 양상을 띠고 있음
    - 휴대폰 소유 여부, 가족 규모, 자차 소유 여부, 부동산 소유 여부, 소득 범주, 직장 전화 소유 여부, 전화 소유 여부, 이메일 소유 여부
<br>

***고객 개인 정보 데이터와 납부 상태 데이터에서 공통 ID 추출 및 중복 행 삭제***

---

<br>

<table width="100%">
  <tr>
    <td align="left" width="50%">
      <img src="https://github.com/user-attachments/assets/bd1d9d26-83f6-477f-adae-ba0640a0985b" width="95%">
    </td>
    <td align="right" width="50%">
      <img src="https://github.com/user-attachments/assets/68a926aa-f67d-4bf0-8562-2bec08267f92" width="95%">
    </td>
  </tr>
</table>

<br>

- **`변수 변환`**
    - `자녀의 수 범주형으로 변환`
        - 7명 이상의 자녀를 가지는 경우 삭제(7, 14, 19의 경우가 각각 한번씩 존재해서 제거)
        - 자녀의 수에 따라서 승인비율의 차이가 거의 없으나 4, 5명의 자녀를 가질때 그래도 다른 경우보다 승인거부비율이 높음. 자녀의 수가 많아질 수록 승인비율이 높아지는 것은 아니라 범주형으로 사용
            - 0 : 0.983, 1 : 0.980, 2 : 0.981, 3 : 0.982, 4 : 0.992, 5 : 1
                - 0,1,2,3 ⇒ normal
                - 4,5 ⇒ above
    - `태어난 날 ⇒ 나이,  고용 시작일 ⇒ 고용 개월 변수 변환`
        - 0이 현재 날짜, -1 은 하루 전
        - 실업자의 경우 양수인 값을 갖는데 전부 365243의 값을 가져서 0으로 변환(1696명)
        - 고용개월이 300이 넘는 고객을 살펴본 결과 잘못 기입하거나 거짓을 입력하는 경우는 없었음
    - `직업 열 변환`
        - 결측치를 가지는 경우 고용 개월 열을 활용하여 실업자로 확인될 경우 무직으로 변환(1696명), 나머지 행은 결측을 채우기 어려우므로 삭제(1295명)

<br>

<table width="100%">
  <tr>
    <td align="left" width="50%">
      <img src="https://github.com/user-attachments/assets/727a9d85-a4f4-466e-a564-2058e4e6250c" width="95%">
    </td>
    <td align="right" width="50%">
      <img src="https://github.com/user-attachments/assets/7523df80-870d-48e7-b469-eed903a455be" width="95%">
    </td>
  </tr>
</table>

<table width="100%">
  <tr>
    <td align="center">
      <img src="https://github.com/user-attachments/assets/2473a7b5-89fc-4d37-bf63-005eb661c2b8" width="70%">
    </td>
  </tr>
</table>

<br>

- **`파생변수`**
    - `ID별 계좌가 몇 개월 동안 열렸는지에 대한 파생변수(begin)`
        - 오래 열린 계좌일 수록 신뢰도가 높을 것이라 판단하여 생성한 파생변수지만 큰 특징은 나타나지 않았음
    - `ID별 총 월 중 승인된 비율 나타내는 파생변수 생성(승인비율)`
        - 한 고객이 전부 승인거부되는 경우는 없고 승인되다가 승인거부로 바뀌는 경우가 다수 존재함을 확인
        - 바뀔 수 있는 포인트는 MONTHS_BALANCE 열밖에 없으므로 반드시 필요한 변수
            - 월별기록에 관한 변수(ex.0의 값을 가질 경우 이번 달의 기록, -2라면 2달 전의 기록의 의미)

<br>
| ID | … | MONTHS_BALANCE | begin | 승인비율 | STATUS |
| --- | --- | --- | --- | --- | --- |
| 1 | … |  0 | -2 | 1 | 승인 |
| 1 | … | -1 | -2 | 1 | 승인 |
| 1 | … | -2 | -2 | 1 | 승인 |
| 2 | … |  0 | -4 | 0.2 | 승인 |
| 2 | … | -1 | -4 | 0.2 | 승인 |
| 2 | … | -2 | -4 | 0.2 | 승인 |
| 2 | … | -3 | -4 | 0.2 | 승인거부 |
| 2 | … | -4 | -4 | 0.2 | 승인 |
<br>

### *Hierarchial Regression Analysis*
<br>

<table width="100%">
  <tr>
    <td align="center">
      <img src="https://github.com/user-attachments/assets/2473a7b5-89fc-4d37-bf63-005eb661c2b8" width="70%">
    </td>
  </tr>
</table>

<br>





