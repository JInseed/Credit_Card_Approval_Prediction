#1-1) ID
length(unique(credit[,'ID']))
sum(is.na(credit[,'ID']))

#1-2) MONTHS_BALANCE
length(unique(credit[,'MONTHS_BALANCE']))
sum(is.na(credit[,'MONTHS_BALANCE']))

table(credit$MONTHS_BALANCE)

#분포 시각화
credit %>% 
  select(MONTHS_BALANCE) %>% 
  mutate(MONTHS_BALANCE=as.factor(MONTHS_BALANCE)) %>% 
  ggplot()+
  geom_bar(aes(MONTHS_BALANCE),
           col='white',
           fill='skyblue') #+
#  theme(axis.text.x = element_text(angle = 90))

#1-3) STATUS
length(unique(credit[,'STATUS']))
sum(is.na(credit[,'STATUS']))

table(credit$STATUS)

#분포 시각화
credit %>% 
  select(STATUS) %>% 
  mutate(STATUS=as.factor(STATUS)) %>% 
  ggplot()+
  geom_bar(aes(STATUS),
           col='white',
           fill='skyblue')+
  scale_y_continuous(labels = scales::comma)

credit %>% 
  select(STATUS) %>% 
  mutate(STATUS=as.factor(STATUS)) %>%
  filter(STATUS %in% c('1','2','3','4','5')) %>% 
  ggplot()+
  geom_bar(aes(STATUS),
           col='white',
           fill='skyblue')+
  scale_y_continuous(labels = scales::comma)

#1-4) begin
length(unique(credit[,'begin']))
sum(is.na(credit[,'begin']))
max(unique(credit[,'begin']))
min(unique(credit[,'begin']))

credit %>% 
  mutate(begin=as.factor(begin)) %>% 
  ggplot()+
  geom_bar(aes(begin),
           col='white',
           fill='skyblue')

credit %>% 
  mutate(begin = as.factor(begin),
         STATUS = as.factor(STATUS)) %>% 
  ggplot(aes(fill=STATUS))+
  geom_bar(aes(begin),
           col='white',
           position='fill')

credit %>% 
  mutate(begin = as.factor(begin),
         STATUS = as.factor(STATUS)) %>% 
  ggplot(aes(fill=STATUS))+
  geom_bar(aes(begin),
           col='white',
           position='stack')

#승인
credit %>%
  select(begin, STATUS) %>% 
  group_by(begin, STATUS) %>% 
  summarise(count=n()) %>%
  mutate(p=count/sum(count)) %>% 
  filter(STATUS == '승인') %>% 
  ggplot()+
  geom_point(aes(begin, p))+
  geom_line(aes(begin, p))


#승인거부
credit %>%
  select(begin, STATUS) %>% 
  group_by(begin, STATUS) %>% 
  summarise(count=n()) %>%
  mutate(p=count/sum(count)) %>% 
  filter(STATUS == '승인거부') %>% 
  ggplot()+
  geom_point(aes(begin, p))+
  geom_line(aes(begin, p))


#1-5) 승인비율
length(unique(credit[,'승인비율']))
sum(is.na(credit[,'승인비율']))
max(unique(credit[,'승인비율']))
min(unique(credit[,'승인비율']))

credit %>% 
  distinct(ID, 승인비율) %>% 
  select(승인비율) %>% 
  ggplot()+
  geom_histogram(aes(승인비율),
                 col='white',
                 fill='skyblue')

credit %>% 
  distinct(ID, 승인비율) %>% 
  select(승인비율) %>% 
  filter(승인비율!=1) %>% 
  ggplot()+
  geom_histogram(aes(승인비율),
                 col='white',
                 fill='skyblue')







