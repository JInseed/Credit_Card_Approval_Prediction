rm(list=ls())
library(tidyverse)

#0.데이터 불러오기
app=read.csv('application_record.csv')
credit=read.csv('credit_record.csv')

#1. credit 예측 변수 변환
credit = credit%>% 
  mutate(STATUS = ifelse(STATUS %in% c('0','C','X'), '승인', '승인거부'))

#2.휴대폰 소유 여부, 자차 소유 여부, 부동산 소유 여부, 소득 범주, 직장 전화 소유 여부, 전화 소유 여부, 이메일 소유 여부, 가족 규모 열 삭제
app=app %>% 
  select(-FLAG_MOBIL,-FLAG_OWN_CAR,-FLAG_OWN_REALTY,-NAME_INCOME_TYPE,-FLAG_WORK_PHONE,-FLAG_PHONE,-FLAG_EMAIL,-CNT_FAM_MEMBERS)

#3. 두 데이터간 겹치는 ID 확인 및 해당 ID만 뽑아 데이터 다시 생성
cred_id=unique(credit[,'ID'])

app %>% 
  filter(ID %in% cred_id) %>% 
  select(ID) %>% 
  n_distinct()

app = app %>% 
  filter(ID %in% cred_id)

app_id = unique(app[,'ID'])

credit = credit %>% 
  filter(ID %in% app_id)

#4. ID 제외 중복되는 행 확인 및 삭제, credit_record 데이터 재 생성
app %>% 
  select(ID) %>% 
  n_distinct()

app %>% 
  select(-ID) %>% 
  n_distinct()

app = app %>% 
  distinct(CODE_GENDER,       
          CNT_CHILDREN, AMT_INCOME_TOTAL,
           NAME_EDUCATION_TYPE, NAME_FAMILY_STATUS, 
           NAME_HOUSING_TYPE, DAYS_BIRTH, DAYS_EMPLOYED,   
           OCCUPATION_TYPE, .keep_all=T)

app_id = unique(app[,'ID'])

credit = credit %>% 
  filter(ID %in% app_id)

#5. 태어난 날 => 나이 변수 변환
#   고용 날짜 => 고용개월로 변환, 실업자의 경우 0으로 변환
app = app %>% 
  mutate(age = -(DAYS_BIRTH / 365),
         고용개월 = ifelse(DAYS_EMPLOYED > 0, 0, -(DAYS_EMPLOYED / 30))) %>% 
  select(-DAYS_BIRTH, -DAYS_EMPLOYED)

#6. 자녀의 수 0~3 통합, 4,5 통합 후 범주형 변수로 변환(7명 이상의 자녀를 가지는 경우 삭제)
app = app %>% 
  filter(CNT_CHILDREN < 7) %>% 
  mutate(CNT_CHILDREN = factor(CNT_CHILDREN)) %>% 
  mutate(CNT_CHILDREN = factor(ifelse(CNT_CHILDREN %in% c('0','1','2','3'), 'normal', 'above')))

#7. 직업 열에서 결측치인 경우 실업자로 확인할 수 있는 것은 실업자로 변환

#직업 결측인거 실업자 비율 확인
app %>% 
  filter(OCCUPATION_TYPE=='') %>% 
  mutate(고용개월=ifelse(고용개월 == 0,'실업','실업아님')) %>% 
  group_by(OCCUPATION_TYPE, 고용개월) %>% 
  summarise(count=n())

app %>% 
  mutate(고용개월=ifelse(고용개월 == 0,'실업','실업아님')) %>% 
  group_by(OCCUPATION_TYPE, 고용개월) %>% 
  summarise(count=n())

#변수 변환
app = app %>% 
  mutate(OCCUPATION_TYPE = ifelse(OCCUPATION_TYPE == '' & 고용개월 == 0, 'unemployed', OCCUPATION_TYPE)) %>% 
  filter(OCCUPATION_TYPE != '')



#8. ID 별 계좌가 몇 개월 동안 열렸는지에 관한 파생변수 생성
credit = credit %>%  
  group_by(ID) %>% 
  mutate(begin = min(MONTHS_BALANCE))

#9. ID 별 총 월에서 승인된 비율 나타내는 파생변수 생성
p=credit %>% 
  group_by(ID, STATUS) %>% 
  summarise(count = n()) %>% 
  mutate(p= count/sum(count)) %>% 
  pivot_wider(
    names_from = STATUS,
    values_from = p
  ) %>% 
  mutate(승인비율 = 승인) %>% 
  select(ID, 승인비율) %>% 
  distinct(ID, .keep_all = T)

credit = credit %>% 
  left_join(p, by='ID')


#10.데이터프레임 변환
app = app %>% 
  as.data.frame()

credit = credit %>% 
  as.data.frame()

#11.두 데이터 셋 ID 기준 병합
df = app %>% 
  left_join(credit, by='ID')


#12. train, test 셋 분리
set.seed(1001)

n=nrow(df)
idx = 1:n

train_idx = sample(idx, n * 0.7)
test_idx = setdiff(idx, train_idx)

train = df[train_idx,]
test = df[test_idx,]


write.csv(train, file = "train.csv", row.names = F)
write.csv(test, file = "test.csv", row.names = F)





