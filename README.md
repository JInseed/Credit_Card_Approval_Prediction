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
      <img src="https://github.com/user-attachments/assets/ce63a0f0-8916-43f3-a7dd-0f43596d81e7" width="70%">
    </td>
  </tr>
</table>

<br>

- MONTHS_BALANCE와 ID별 계좌가 몇 개월 동안 열렸는지에 대한 변수의 상관관계가 0.6으로 높음
- 계수 추정의 오류나 다중공선성의 문제가 생길 수 있음에도 불구하고 두 변수를 사용하면 좋을지의 대한 근거를 검증해보기 위해 활용
- MONTHS_BALANCE : 독립변수
- begin(ID별 계좌가 몇 개월 동안 열렸는지에 대한 변수) : 매개변수
- 나머지 변수 : 통제변수
- Scaling 진행한 후 분석

**`1단계. 매개변수와 종속변수가 유의미한 관계인지 확인`**

- MONTHS_BALANCE 를 제외한 후 begin을 독립변수, 나머지를 통제변수로 두고 다중 로지스틱  회귀분석 진행
- 분산 팽창 계수가 전부 10 이하로 다중공선성 문제는 없음을 확인

<br>

<table width="100%">
  <tr>
    <td align="center">
      <img src="https://github.com/user-attachments/assets/07dc68ae-4ff9-4e55-ade8-a3b255c1d539" width="90%">
    </td>
  </tr>
</table>

<br>

- 독립변수와 종속변수가 유의미한 관계임을 확인

**`2단계. 독립변수와 종속변수가 유의미한 관계인지 확인`**

- begin 를 제외한 후 MONTHS_BALANCE 을 독립변수, 나머지를 통제변수로 두고 다중 로지스틱  회귀분석 진행
- 분산 팽창 계수가 전부 10 이하로 다중공선성 문제는 없음을 확인

<br>

<table width="100%">
  <tr>
    <td align="center">
      <img src="https://github.com/user-attachments/assets/9778eab9-fec7-4838-a8cb-2f61d4a27785" width="90%">
    </td>
  </tr>
</table>

<br>

- 매개변수와 종속변수가 유의미한 관계임을 확인

**`3단계. 독립변수와 매개변수가 유의미한 관계인지 확인`**

- MONTHS_BALANCE 을 종속변수, begin을 독립변수, 나머지를 통제변수로 두고 다중 회귀 분석 진행
- 분산 팽창 계수가 전부 10 이하로 다중공선성 문제는 없음을 확인
- 독립변수와 매개변수의 관계가 유의함을 확인

**`4단계. 모든 변수 투입하여  다중 로지스틱 분석`**

- 독립변수와 매개변수가 동시에 회귀식에 투입되었을 때 매개변수가 종속변수에 여전히 유의한 영향을 미치는 한편, 독립변수와 종속변수의 관계는 매개변수가 투입되지 않았을 경우보다도 더 약화되거나(부분매개) 혹은 유의하지 않게 나타나야 한다(완전매개)
- 분산 팽창 계수가 전부 10 이하로 다중공선성 문제는 없음을 확인

<br>

<table width="100%">
  <tr>
    <td align="center">
      <img src="https://github.com/user-attachments/assets/aafc24ca-8ee3-4824-8cc6-e79a4a34f01e" width="90%">
    </td>
  </tr>
</table>

<br>

- 독립변수인 MOTHS_BALANCE의 odd ratio가 매개변수가 투입되지 않았을 때 -0.67 에서 투입되었을 때 -0.54 로 약화되었으며 종속변수와 유의한 관계를 가지므로 부분매개라고 할 수 있다.

***`부분매개를 하기 때문에 두 변수 모두 사용하는 것이 좋다.`***
<br>

### *Modeling*
<br>

- **`K-fold Cross Validation`**
    - 모델 신뢰성 검증 및 기본적인 성능 검토
    - LR, RF, SVM, XGB, KNN 모델 사용
    - fold는 5로 진행
    - 아래는 XGB 결과
    
    ```
    각 분할의 Accuracy 기록 : [0.9874244712990936, 0.9861027190332327, 0.9854601759885192, 0.9860644284149703, 0.9868197439480343]
    Accuracy 평균: 0.9863743077367699
    Accuracy 표준편차: 0.0006792171077153273
    
    각 분할의 recall 기록 : [0.6935483870967742, 0.7106598984771574, 0.6666666666666666, 0.7074468085106383, 0.7065217391304348]
    recall 평균 : 0.6969686999763344
    recall 표준편차: 0.01623830037177331
    ```
    

- Accuracy의 경우 모든 모델에서 비슷한 결과를 도출할 수 있었으며 편차도 크지 않아 신뢰성 확보
- recall의 경우 SVM, XGB, KNN, Logistic Regression, RF 순으로 높음. 특히 SVM과 XGB가 매우 높은 결과를 가져옴. 편차가  크지 않아서 신뢰성 확보된 것으로 판단
- Sampling 및 하이퍼 파라미터 조정을 하지 않았음에도 좋은 결과가 도출됨

<br>

<table width="70%">
  <tr>
    <td align="center">
      <img src="https://github.com/user-attachments/assets/bf55f88f-f12a-4f83-80d2-221dc1bbd35d" width="50%">
    </td>
  </tr>
</table>

<br>

- **`Sampling`**
    - 예측변수가 불균형하므로 Sampling을 요함
    - 앞선 교차 검증에서 Sampling을 하지 않고도 좋은 결과가 나왔으나 recall이 모델마다 꽤 큰 차이를 보여서 더 안정화 시키고 성능을 높여보고자 Sampling을 진행한 후 튜닝하자고 판단
    - 또한 튜닝 시 너무 시간이 오래 걸림
    - `논문 참고하여 진행`
        - **Handling Method of Imbalance Data for Machine Learning : Focused on Sampling**

<br>

<table width="100%">
  <tr>
    <td align="left" width="50%">
      <img src="https://github.com/user-attachments/assets/d5d7c698-4ac3-4219-8971-9b22bd8beb37" width="95%">
    </td>
    <td align="right" width="50%">
      <img src="https://github.com/user-attachments/assets/deca735f-203d-4ba2-9743-02ecb8200ba0" width="95%">
    </td>
  </tr>
</table>

<br>

1. 소수 클래스 데이터 크기만큼 다수 클래스에서 데이터를 추출 ⇒ **➁**
2. 나머지 다수 클래스 데이터를 이등분 한 후 ➂ 데이터에 랜덤으로 소수 클래스에 해당되는 레이블을 부여
3. 학습된 모델로 ➁, ➃ 를 테스트
4. 이 때 임계값을 0.48 < threshold < 0.52 (사용자가 정해도 됨) 으로 지정하여 구간 안으로 테스트 결과가 나올 경우, ➁ 데이터는 ➁ +  ➂ + ➃ 데이터 전체를 대표할 수 있다고 판단

<br>

- 오른쪽 그림은 **일반적인 언더 샘플링과 논문에서 제안하는 기법 차이**
    - 이에 ➀ + ➁ 데이터만을 사용하여 튜닝을 진행하면 시간을 대폭 줄일 수 있음
    - 기존의 기법들보다 성능도 우수함을 검증
    - 실제 진행 시 테스트 결과가 임계값 안에 포함되지 않을 시 모집단을 대표할 수 없기에 반복하여 뽑아야 했음

<br>

- **`Hyper Parameter Tunning`**
    - grid_search 로 튜닝 진행
    - recall 을 기준으로 탐색
    - LR, RF, SVM, XGB, KNN 모델 및 Soft Ensemble 활용
    - 최적 모델은 RF로 선정. 결과는 아래와 같음

<br>

```r
최적 하이퍼 파라미터:{'max_depth': 5, 'max_features': 'auto', 'min_samples_leaf': 1, 'min_samples_split': 2, 'n_estimators': 200}, 최적 평균 recall:0.990
```

```r
               precision    recall  f1-score   support

           0       1.00      0.87      0.93     55691
           1       0.13      0.99      0.22      1051

    accuracy                           0.87     56742
   macro avg       0.56      0.93      0.58     56742
weighted avg       0.98      0.87      0.92     56742

ROC AUC Score: 0.9314528372976066
```

## 시사점 및 보완할 점

- **Feature Selection**
    - 꼼꼼한 EDA를 통해 예측에 영향이 적을 것으로 예상되는 변수 제거
        - 교호 작용 확인 및 변수 중요도를 추가로 분석했더라면 더욱 정교한 결과를 도출할 수 있었을 것
    - 공통 ID 추출, 중복 행 삭제, 변수 변환 등을 통해 데이터의 정합성과 품질을 점검
    - `위계적 회귀분석`을 통해 상관관계가 높은 변수들의 사용 여부를 신중히 결정
- **Sampling**
    - 데이터 불균형을 처리하기 위해 논문을 참고하여 `새로운 Sampling 방법` 적용
    - SMOTE 등 다른 방법론과의 성능 비교를 추가로 진행했다면 더 신뢰성 있는 결과를 확인할 수 있었을 것
- **세부 분석**
    - 승인과 승인 거부를 분리할 때, 연체 상태가 1~29일인 경우 연체 가능성이 높은 고객을 보다 세밀하게 분석할 필요가 있었음.
        - 군집화를 활용하여 연체 가능성이 높은 고객을 추출하는 등 추가적인 접근이 이루어졌다면 결과의 정밀도가 향상되었을 것










