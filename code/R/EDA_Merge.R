#1-1) ID
length(unique(app[,'ID']))
sum(is.na(app[,'ID']))

#1-2) CODE_GENDER
length(unique(app[,'CODE_GENDER']))
sum(is.na(app[,'CODE_GENDER']))

table(app$CODE_GENDER)

#분포시각화
df %>% 
  mutate(CODE_GENDER=as.factor(CODE_GENDER),
         STATUS = as.factor(STATUS)) %>% 
  ggplot(aes(fill=STATUS))+
  geom_bar(aes(CODE_GENDER),
           col='white')

df %>% 
  mutate(CODE_GENDER=as.factor(CODE_GENDER),
         STATUS = as.factor(STATUS)) %>% 
  ggplot(aes(fill=STATUS))+
  geom_bar(aes(CODE_GENDER),
           col='white',
           position = 'fill')

df %>% 
  group_by(CODE_GENDER,STATUS) %>% 
  summarise(count=n()) %>% 
  mutate(p=count/sum(count))


#1-3) FLAG_OWN_CAR
length(unique(app[,'FLAG_OWN_CAR']))
sum(is.na(app[,'FLAG_OWN_CAR']))

table(app$FLAG_OWN_CAR)

#분포시각화
df %>% 
  mutate(FLAG_OWN_CAR=as.factor(FLAG_OWN_CAR),
         STATUS = as.factor(STATUS)) %>% 
  ggplot(aes(fill=STATUS))+
  geom_bar(aes(FLAG_OWN_CAR),
           col='white')

df %>% 
  mutate(FLAG_OWN_CAR=as.factor(FLAG_OWN_CAR),
         STATUS = as.factor(STATUS)) %>% 
  ggplot(aes(fill=STATUS))+
  geom_bar(aes(FLAG_OWN_CAR),
           col='white',
           position = 'fill')

df %>% 
  group_by(FLAG_OWN_CAR,STATUS) %>% 
  summarise(count=n()) %>% 
  mutate(p=count/sum(count))


#1-4) FLAG_OWN_REALTY
length(unique(app[,'FLAG_OWN_REALTY']))
sum(is.na(app[,'FLAG_OWN_REALTY']))

table(app$FLAG_OWN_REALTY)

#분포시각화
df %>% 
  mutate(FLAG_OWN_REALTY=as.factor(FLAG_OWN_REALTY),
         STATUS = as.factor(STATUS)) %>% 
  ggplot(aes(fill=STATUS))+
  geom_bar(aes(FLAG_OWN_REALTY),
           col='white')

df %>% 
  mutate(FLAG_OWN_REALTY=as.factor(FLAG_OWN_REALTY),
         STATUS = as.factor(STATUS)) %>% 
  ggplot(aes(fill=STATUS))+
  geom_bar(aes(FLAG_OWN_REALTY),
           col='white',
           position = 'fill')

df %>% 
  group_by(FLAG_OWN_REALTY,STATUS) %>% 
  summarise(count=n()) %>% 
  mutate(p=count/sum(count))

#1-5) CNT_CHILDREN
length(unique(app[,'CNT_CHILDREN']))
sum(is.na(app[,'CNT_CHILDREN']))

table(app$CNT_CHILDREN)

#분포시각화
df %>% 
  mutate(CNT_CHILDREN=as.factor(CNT_CHILDREN),
         STATUS = as.factor(STATUS)) %>% 
  ggplot(aes(fill=STATUS))+
  geom_bar(aes(CNT_CHILDREN),
           col='white')

df %>% 
  mutate(CNT_CHILDREN=as.factor(CNT_CHILDREN),
         STATUS = as.factor(STATUS)) %>% 
  ggplot(aes(fill=STATUS))+
  geom_bar(aes(CNT_CHILDREN),
           col='white',
           position = 'fill')

df %>% 
  group_by(CNT_CHILDREN,STATUS) %>% 
  summarise(count=n()) %>% 
  mutate(p=count/sum(count))



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
df %>% 
  mutate(STATUS = as.factor(STATUS)) %>% 
  ggplot()+
  geom_histogram(aes(AMT_INCOME_TOTAL, fill = STATUS),
                 position = 'stack',
                 col='white',
                 binwidth = 40000 )+
  scale_y_continuous(labels = scales::comma)+
  scale_x_continuous(labels = scales::comma)+
  geom_vline(aes(xintercept=27000),
             color='red',
             linetype='dashed')+
  annotate('text', x=-20000, y=60000, 
           color='red', 
           label='27000',
           size=3)+
  ylab('count')

df %>% 
  mutate(STATUS = as.factor(STATUS)) %>% 
  filter(AMT_INCOME_TOTAL < 500000) %>% 
  ggplot()+
  geom_histogram(aes(AMT_INCOME_TOTAL, fill = STATUS),
                 position = 'stack',
                 col='white',
                 binwidth = 25000 )+
  scale_y_continuous(labels = scales::comma)+
  scale_x_continuous(labels = scales::comma)+
  geom_vline(aes(xintercept=27000),
             color='red',
             linetype='dashed')+
  annotate('text', x=0, y=5000, 
           color='red', 
           label='27000',
           size=3)+
  ylab('count')

df %>% 
  mutate(STATUS = as.factor(STATUS)) %>% 
  ggplot()+
  geom_histogram(aes(AMT_INCOME_TOTAL, fill = STATUS),
                 position = 'fill',
                 col='white',
                 binwidth = 40000 )+
  scale_y_continuous(labels = scales::comma)+
  scale_x_continuous(labels = scales::comma)+
  geom_vline(aes(xintercept=27000),
             color='red',
             linetype='dashed')+
  annotate('text', x=-20000, y=1,
           color='red', 
           label='27000',
           size=3)+
  ylab('count')

df %>% 
  mutate(STATUS = as.factor(STATUS)) %>% 
  filter(AMT_INCOME_TOTAL < 500000) %>% 
  ggplot()+
  geom_histogram(aes(AMT_INCOME_TOTAL, fill = STATUS),
                 position = 'fill',
                 col='white',
                 binwidth = 25000 )+
  scale_y_continuous(labels = scales::comma)+
  scale_x_continuous(labels = scales::comma)+
  geom_vline(aes(xintercept=27000),
             color='red',
             linetype='dashed')+
  annotate('text', x=0, y=1, 
           color='red', 
           label='27000',
           size=3)+
  ylab('count')


#1-7) NAME_INCOME_TYPE
length(unique(app[,'NAME_INCOME_TYPE']))
sum(is.na(app[,'NAME_INCOME_TYPE']))

table(app$NAME_INCOME_TYPE)

#분포시각화
df %>% 
  mutate(NAME_INCOME_TYPE=as.factor(NAME_INCOME_TYPE),
         STATUS = as.factor(STATUS)) %>% 
  ggplot(aes(fill=STATUS))+
  geom_bar(aes(NAME_INCOME_TYPE),
           col='white')

df %>% 
  mutate(NAME_INCOME_TYPE=as.factor(NAME_INCOME_TYPE),
         STATUS = as.factor(STATUS)) %>% 
  ggplot(aes(fill=STATUS))+
  geom_bar(aes(NAME_INCOME_TYPE),
           col='white',
           position = 'fill')

df %>% 
  group_by(NAME_INCOME_TYPE,STATUS) %>% 
  summarise(count=n()) %>% 
  mutate(p=count/sum(count))

#1-8) NAME_EDUCATION_TYPE
length(unique(app[,'NAME_EDUCATION_TYPE']))
sum(is.na(app[,'NAME_EDUCATION_TYPE']))

table(app$NAME_EDUCATION_TYPE)

#분포시각화
df %>% 
  mutate(NAME_EDUCATION_TYPE=as.factor(NAME_EDUCATION_TYPE),
         STATUS = as.factor(STATUS)) %>% 
  ggplot(aes(fill=STATUS))+
  geom_bar(aes(NAME_EDUCATION_TYPE),
           col='white')

df %>% 
  mutate(NAME_EDUCATION_TYPE=as.factor(NAME_EDUCATION_TYPE),
         STATUS = as.factor(STATUS)) %>% 
  ggplot(aes(fill=STATUS))+
  geom_bar(aes(NAME_EDUCATION_TYPE),
           col='white',
           position = 'fill')

df %>% 
  group_by(NAME_EDUCATION_TYPE,STATUS) %>% 
  summarise(count=n()) %>% 
  mutate(p=count/sum(count))

#1-9) NAME_FAMILY_STATUS
length(unique(app[,'NAME_FAMILY_STATUS']))
sum(is.na(app[,'NAME_FAMILY_STATUS']))

table(app$NAME_FAMILY_STATUS)

#분포시각화
df %>% 
  mutate(NAME_FAMILY_STATUS=as.factor(NAME_FAMILY_STATUS),
         STATUS = as.factor(STATUS)) %>% 
  ggplot(aes(fill=STATUS))+
  geom_bar(aes(NAME_FAMILY_STATUS),
           col='white')

df %>% 
  mutate(NAME_FAMILY_STATUS=as.factor(NAME_FAMILY_STATUS),
         STATUS = as.factor(STATUS)) %>% 
  ggplot(aes(fill=STATUS))+
  geom_bar(aes(NAME_FAMILY_STATUS),
           col='white',
           position = 'fill')

df %>% 
  group_by(NAME_FAMILY_STATUS,STATUS) %>% 
  summarise(count=n()) %>% 
  mutate(p=count/sum(count))

#1-10) NAME_HOUSING_TYPE

#분포시각화
df %>% 
  mutate(NAME_HOUSING_TYPE=as.factor(NAME_HOUSING_TYPE),
         STATUS = as.factor(STATUS)) %>% 
  ggplot(aes(fill=STATUS))+
  geom_bar(aes(NAME_HOUSING_TYPE),
           col='white')

df %>% 
  mutate(NAME_HOUSING_TYPE=as.factor(NAME_HOUSING_TYPE),
         STATUS = as.factor(STATUS)) %>% 
  ggplot(aes(fill=STATUS))+
  geom_bar(aes(NAME_HOUSING_TYPE),
           col='white',
           position = 'fill')

df %>% 
  group_by(NAME_HOUSING_TYPE,STATUS) %>% 
  summarise(count=n()) %>% 
  mutate(p=count/sum(count))

#1-11) age
length(unique(app[,'DAYS_BIRTH']))
sum(is.na(app[,'DAYS_BIRTH']))

table(app$DAYS_BIRTH)

min(unique(app[,'DAYS_BIRTH']))
max(unique(app[,'DAYS_BIRTH']))

#분포시각화
df %>% 
  mutate(STATUS = as.factor(STATUS)) %>% 
  ggplot(aes(fill = STATUS))+
  geom_histogram(aes(age),
                 col='white',
                 binwidth = 1,
                 position = 'stack')

df %>% 
  mutate(STATUS = as.factor(STATUS)) %>% 
  ggplot(aes(fill = STATUS))+
  geom_histogram(aes(age),
                 col='white',
                 binwidth = 1,
                 position = 'fill')
df %>% 
  mutate(STATUS = as.factor(STATUS)) %>% 
  ggplot(aes(fill = STATUS))+
  geom_histogram(aes(age),
                 col='white',
                 binwidth = 10,
                 position = 'fill')

df %>% 
  mutate(age = ifelse(age >= 60 & age < 70, '60대',
                      ifelse(age >= 50, '50대',
                             ifelse(age >= 40, '40대',
                                    ifelse(age >= 30, '30대', '20대'))))) %>% 
  group_by(age,STATUS) %>% 
  summarise(count=n()) %>% 
  mutate(p=count/sum(count))

#1-12) 고용개월

#분포시각화
df %>% 
  mutate(STATUS = as.factor(STATUS)) %>% 
  ggplot(aes(fill = STATUS))+
  geom_histogram(aes(고용개월),
                 col='white',
                 binwidth = 10,
                 position = 'stack')


df %>% 
  mutate(STATUS = as.factor(STATUS)) %>% 
  ggplot(aes(fill = STATUS))+
  geom_histogram(aes(고용개월),
                 col='white',
                 binwidth = 10,
                 position = 'fill')


#1-13) FLAG_WORK_PHONE
#분포시각화
df %>% 
  mutate(FLAG_WORK_PHONE=as.factor(FLAG_WORK_PHONE),
         STATUS = as.factor(STATUS)) %>% 
  ggplot(aes(fill=STATUS))+
  geom_bar(aes(FLAG_WORK_PHONE),
           col='white')

df %>% 
  mutate(FLAG_WORK_PHONE=as.factor(FLAG_WORK_PHONE),
         STATUS = as.factor(STATUS)) %>% 
  ggplot(aes(fill=STATUS))+
  geom_bar(aes(FLAG_WORK_PHONE),
           col='white',
           position = 'fill')

df %>% 
  group_by(FLAG_WORK_PHONE,STATUS) %>% 
  summarise(count=n()) %>% 
  mutate(p=count/sum(count))

#1-14) FLAG_PHONE
#분포시각화
df %>% 
  mutate(FLAG_PHONE=as.factor(FLAG_PHONE),
         STATUS = as.factor(STATUS)) %>% 
  ggplot(aes(fill=STATUS))+
  geom_bar(aes(FLAG_PHONE),
           col='white')

df %>% 
  mutate(FLAG_PHONE=as.factor(FLAG_PHONE),
         STATUS = as.factor(STATUS)) %>% 
  ggplot(aes(fill=STATUS))+
  geom_bar(aes(FLAG_PHONE),
           col='white',
           position = 'fill')

df %>% 
  group_by(FLAG_PHONE,STATUS) %>% 
  summarise(count=n()) %>% 
  mutate(p=count/sum(count))

#1-15) FLAG_EMAIL
#분포시각화
df %>% 
  mutate(FLAG_EMAIL=as.factor(FLAG_EMAIL),
         STATUS = as.factor(STATUS)) %>% 
  ggplot(aes(fill=STATUS))+
  geom_bar(aes(FLAG_EMAIL),
           col='white')

df %>% 
  mutate(FLAG_EMAIL=as.factor(FLAG_EMAIL),
         STATUS = as.factor(STATUS)) %>% 
  ggplot(aes(fill=STATUS))+
  geom_bar(aes(FLAG_EMAIL),
           col='white',
           position = 'fill')

df %>% 
  group_by(FLAG_EMAIL,STATUS) %>% 
  summarise(count=n()) %>% 
  mutate(p=count/sum(count))

#1-16) OCCUPATION_TYPE
length(unique(app[,'OCCUPATION_TYPE']))
sum(is.na(app[,'OCCUPATION_TYPE']))

table(app$OCCUPATION_TYPE)
unique(app$OCCUPATION_TYPE)

#분포시각화
df %>% 
  mutate(OCCUPATION_TYPE=as.factor(OCCUPATION_TYPE),
         STATUS = as.factor(STATUS)) %>%
  ggplot()+
  geom_bar(aes(OCCUPATION_TYPE, fill=STATUS),
           col='white')+
  xlab('OCCUPATION_TYPE')+
  coord_flip()

df %>% 
  mutate(OCCUPATION_TYPE=as.factor(OCCUPATION_TYPE),
         STATUS = as.factor(STATUS)) %>% 
  group_by(OCCUPATION_TYPE, STATUS) %>% 
  summarise(count=n()) %>% 
  ggplot()+
  geom_bar(aes(fct_reorder(OCCUPATION_TYPE, count), count, fill=STATUS),
           col='white',
           stat='identity',
           position = 'stack')+
  xlab('OCCUPATION_TYPE')+
  coord_flip()

df %>% 
  mutate(OCCUPATION_TYPE=as.factor(OCCUPATION_TYPE),
         STATUS = as.factor(STATUS)) %>% 
  group_by(OCCUPATION_TYPE, STATUS) %>% 
  summarise(count=n()) %>% 
  ggplot()+
  geom_bar(aes(fct_reorder(OCCUPATION_TYPE, count), count, fill=STATUS),
           col='white',
           stat='identity',
           position = 'fill')+
  xlab('OCCUPATION_TYPE')+
  coord_flip()

#1-17) CNT_FAM_MEMBERS
#분포시각화
df %>% 
  mutate(CNT_FAM_MEMBERS=as.factor(CNT_FAM_MEMBERS),
         STATUS = as.factor(STATUS)) %>% 
  ggplot(aes(fill=STATUS))+
  geom_bar(aes(CNT_FAM_MEMBERS),
           col='white')

df %>% 
  mutate(CNT_FAM_MEMBERS=as.factor(CNT_FAM_MEMBERS),
         STATUS = as.factor(STATUS)) %>% 
  ggplot(aes(fill=STATUS))+
  geom_bar(aes(CNT_FAM_MEMBERS),
           col='white',
           position = 'fill')

df %>% 
  group_by(CNT_FAM_MEMBERS,STATUS) %>% 
  summarise(count=n()) %>% 
  mutate(p=count/sum(count))
