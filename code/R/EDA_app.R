#1-1) ID
length(unique(app[,'ID']))
sum(is.na(app[,'ID']))

#1-2) CODE_GENDER
length(unique(app[,'CODE_GENDER']))
sum(is.na(app[,'CODE_GENDER']))

table(app$CODE_GENDER)

#분포시각화
app %>% 
  mutate(CODE_GENDER=as.factor(CODE_GENDER)) %>% 
  ggplot()+
  geom_bar(aes(CODE_GENDER),
           col='white',
           fill='skyblue')


#1-3) FLAG_OWN_CAR
length(unique(app[,'FLAG_OWN_CAR']))
sum(is.na(app[,'FLAG_OWN_CAR']))

table(app$FLAG_OWN_CAR)

#분포시각화
app %>% 
  mutate(FLAG_OWN_CAR=as.factor(FLAG_OWN_CAR)) %>% 
  ggplot()+
  geom_bar(aes(FLAG_OWN_CAR),
           col='white',
           fill='skyblue')

#1-4) FLAG_OWN_REALTY
length(unique(app[,'FLAG_OWN_REALTY']))
sum(is.na(app[,'FLAG_OWN_REALTY']))

table(app$FLAG_OWN_REALTY)

app %>% 
  mutate(FLAG_OWN_REALTY=as.factor(FLAG_OWN_REALTY)) %>% 
  ggplot()+
  geom_bar(aes(FLAG_OWN_REALTY),
           col='white',
           fill='skyblue')

#1-5) CNT_CHILDREN
length(unique(app[,'CNT_CHILDREN']))
sum(is.na(app[,'CNT_CHILDREN']))

table(app$CNT_CHILDREN)


#분포시각화
app %>% 
  select(CNT_CHILDREN) %>% 
  mutate(CNT_CHILDREN=as.factor(CNT_CHILDREN)) %>% 
  ggplot()+
  geom_bar(aes(CNT_CHILDREN),
           col='white',
           fill='skyblue')



#1-6) AMT_INCOME_TOTAL
length(unique(app[,'AMT_INCOME_TOTAL']))
sum(is.na(app[,'AMT_INCOME_TOTAL']))

min(unique(app[,'AMT_INCOME_TOTAL']))
max(unique(app[,'AMT_INCOME_TOTAL']))

app %>% 
  select(AMT_INCOME_TOTAL) %>% 
  group_by(AMT_INCOME_TOTAL) %>% 
  summarise(n=n()) %>%
  arrange(-n)


table(app$AMT_INCOME_TOTAL)

#분포 시각화
app %>% 
  select(AMT_INCOME_TOTAL) %>% 
  ggplot()+
  geom_histogram(aes(AMT_INCOME_TOTAL),
                 fill='skyblue',
                 col='white',
                 binwidth = 40000 )+
  scale_y_continuous(labels = scales::comma)+
  scale_x_continuous(labels = scales::comma)+
  geom_vline(aes(xintercept=27000),
             color='red',
             linetype='dashed')+
  annotate('text', x=-20000, y=3000, 
           color='red', 
           label='27000',
           size=3)+
  ylab('count')

app %>% 
  select(AMT_INCOME_TOTAL) %>% 
  filter(AMT_INCOME_TOTAL < 500000) %>% 
  ggplot()+
  geom_histogram(aes(AMT_INCOME_TOTAL),
                 fill='skyblue',
                 col='white',
                 binwidth = 25000 )+
  scale_y_continuous(labels = scales::comma)+
  scale_x_continuous(labels = scales::comma)+
  geom_vline(aes(xintercept=27000),
             color='red',
             linetype='dashed')+
  annotate('text', x=0, y=2000, 
           color='red', 
           label='27000',
           size=3)+
  ylab('count')

app %>% 
  filter(AMT_INCOME_TOTAL > 500000) %>% 
  arrange(AMT_INCOME_TOTAL) %>% 
  group_by(AMT_INCOME_TOTAL) %>% 
  summarise(count=n()) %>% 
  view()

df %>% 
  filter(AMT_INCOME_TOTAL > 500000) %>% 
  arrange(AMT_INCOME_TOTAL) %>% 
  group_by(AMT_INCOME_TOTAL, STATUS) %>% 
  summarise(count=n()) %>% 
  mutate(p=count/sum(count)) %>% 
  view()

df %>% 
  filter(AMT_INCOME_TOTAL > 500000) %>% 
  mutate(AMT_INCOME_TOTAL = ifelse(AMT_INCOME_TOTAL >= 550000, 550000,AMT_INCOME_TOTAL)) %>% 
  arrange(AMT_INCOME_TOTAL) %>% 
  group_by(AMT_INCOME_TOTAL, STATUS) %>% 
  summarise(count=n()) %>% 
  mutate(p=count/sum(count)) %>% 
  view()


round(quantile(app$AMT_INCOME_TOTAL, 0.995))

#1-7) NAME_INCOME_TYPE
length(unique(app[,'NAME_INCOME_TYPE']))
sum(is.na(app[,'NAME_INCOME_TYPE']))

table(app$NAME_INCOME_TYPE)

#분포시각화
app %>% 
  select(NAME_INCOME_TYPE) %>% 
  mutate(NAME_INCOME_TYPE=as.factor(NAME_INCOME_TYPE)) %>% 
  ggplot()+
  geom_bar(aes(NAME_INCOME_TYPE),
           col='white',
           fill='skyblue')

#1-8) NAME_EDUCATION_TYPE
length(unique(app[,'NAME_EDUCATION_TYPE']))
sum(is.na(app[,'NAME_EDUCATION_TYPE']))

table(app$NAME_EDUCATION_TYPE)

app %>% 
  select(NAME_EDUCATION_TYPE) %>% 
  mutate(NAME_EDUCATION_TYPE=as.factor(NAME_EDUCATION_TYPE)) %>% 
  ggplot()+
  geom_bar(aes(NAME_EDUCATION_TYPE),
           col='white',
           fill='skyblue')

#1-9) NAME_FAMILY_STATUS
length(unique(app[,'NAME_FAMILY_STATUS']))
sum(is.na(app[,'NAME_FAMILY_STATUS']))

table(app$NAME_FAMILY_STATUS)

app %>% 
  select(NAME_FAMILY_STATUS) %>% 
  mutate(NAME_FAMILY_STATUS=as.factor(NAME_FAMILY_STATUS)) %>% 
  ggplot()+
  geom_bar(aes(NAME_FAMILY_STATUS),
           col='white',
           fill='skyblue')

#1-10) NAME_HOUSING_TYPE
length(unique(app[,'NAME_HOUSING_TYPE']))
sum(is.na(app[,'NAME_HOUSING_TYPE']))

table(app$NAME_HOUSING_TYPE)

app %>% 
  select(NAME_HOUSING_TYPE) %>% 
  mutate(NAME_HOUSING_TYPE=as.factor(NAME_HOUSING_TYPE)) %>% 
  ggplot()+
  geom_bar(aes(NAME_HOUSING_TYPE),
           col='white',
           fill='skyblue')

#1-11) age
length(unique(app[,'age']))
sum(is.na(app[,'age']))

table(app$age)

min(unique(app[,'age']))
max(unique(app[,'age']))

app %>% 
  select(age) %>% 
  ggplot()+
  geom_histogram(aes(age),
           binwidth = 1,
           col='white',
           fill='skyblue')

#1-12) 고용개월
length(unique(app[,'고용개월']))
sum(is.na(app[,'고용개월']))

min(unique(app[,'고용개월']))
max(unique(app[,'고용개월']))

sum(app$고용개월 == 0)

table(app$고용개월)

app %>% 
  select(고용개월) %>% 
  ggplot()+
  geom_histogram(aes(고용개월),
                 binwidth = 10,
                 col='white',
                 fill='skyblue')

app %>% 
  filter(고용개월 > 400) %>% 
  view()

app %>% 
  filter(고용개월 > 300) %>% 
  mutate(start = age - (고용개월/12)) %>% 
  view()



#1-13) FLAG_WORK_PHONE
length(unique(app[,'FLAG_WORK_PHONE']))
sum(is.na(app[,'FLAG_WORK_PHONE']))

table(app$FLAG_WORK_PHONE)

app %>% 
  mutate(FLAG_WORK_PHONE=as.factor(FLAG_WORK_PHONE)) %>% 
  ggplot()+
  geom_bar(aes(FLAG_WORK_PHONE),
           col='white',
           fill='skyblue')

#1-14) FLAG_PHONE
length(unique(app[,'FLAG_PHONE']))
sum(is.na(app[,'FLAG_PHONE']))

table(app$FLAG_PHONE)

app %>% 
  mutate(FLAG_PHONE=as.factor(FLAG_PHONE)) %>% 
  ggplot()+
  geom_bar(aes(FLAG_PHONE),
           col='white',
           fill='skyblue')

#1-15) FLAG_EMAIL
length(unique(app[,'FLAG_EMAIL']))
sum(is.na(app[,'FLAG_EMAIL']))

table(app$FLAG_EMAIL)

app %>% 
  mutate(FLAG_PHONE=as.factor(FLAG_PHONE)) %>% 
  ggplot()+
  geom_bar(aes(FLAG_PHONE),
           col='white',
           fill='skyblue')

#1-16) OCCUPATION_TYPE
length(unique(app[,'OCCUPATION_TYPE']))
sum(is.na(app[,'OCCUPATION_TYPE']))

table(app$OCCUPATION_TYPE)
unique(app$OCCUPATION_TYPE)

#분포시각화
app %>% 
  select(OCCUPATION_TYPE) %>% 
  mutate(OCCUPATION_TYPE=as.factor(OCCUPATION_TYPE)) %>% 
  group_by(OCCUPATION_TYPE) %>% 
  summarise(count=n()) %>% 
  ggplot()+
  geom_bar(aes(fct_reorder(OCCUPATION_TYPE, count), count),
           fill='skyblue',
           col='white',
           stat='identity')+
  xlab('OCCUPATION_TYPE')+
  coord_flip()

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


#1-17) CNT_FAM_MEMBERS
length(unique(app[,'CNT_FAM_MEMBERS']))
sum(is.na(app[,'CNT_FAM_MEMBERS']))

table(app$CNT_FAM_MEMBERS)
unique(app$CNT_FAM_MEMBERS)

app %>% 
  select(CNT_FAM_MEMBERS) %>% 
  mutate(CNT_FAM_MEMBERS=as.factor(CNT_FAM_MEMBERS)) %>% 
  ggplot()+
  geom_bar(aes(CNT_FAM_MEMBERS),
           col='white',
           fill='skyblue')


cor(app$CNT_CHILDREN, app$CNT_FAM_MEMBERS)
