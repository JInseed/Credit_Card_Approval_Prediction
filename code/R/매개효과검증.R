library(moonBook)
library(car)
library(caret)
library(ROCR)
library(pROC)
library(Epi)
library(klaR)
library(rpart)
library(rpart.plot)
library(Metrics)
library(mlr)
library(gplots)

prediction=ROCR::prediction
performance=ROCR::performance
select=dplyr::select
car::vif

train=train %>% 
  select(-ID)

test=test %>% 
  select(-ID)

train$STATUS = as.factor(train$STATUS)
test$STATUS = as.factor(test$STATUS)

#정규화
for(i in 1:ncol(train)){
  if (class(train[,i]) %in% c('numeric', 'integer')){
    m=mean(train[,i], na.rm=T)
    s=sd(train[,i], na.rm=T)
    
    train[,i]=(train[,i]-m)/s
    test[,i]=(test[,i]-m)/s
  }
}

#1단계. 독립변수와 종속변수 유의미한 관계인지 확인
fit_glm_1=glm(STATUS ~ .-MONTHS_BALANCE, family=binomial, data=train)

vif(fit_glm_1)
summary(fit_glm_1)
ORplot(fit_glm_1, show.CI = F,cex = 1, type=1)

exp(-0.09)

#2단계. 매개변수와 종속변수 유의미한 관계인지 확인
fit_glm_2=glm(STATUS ~ .-begin, family=binomial, data=train)

vif(fit_glm_2)
summary(fit_glm_2)
ORplot(fit_glm_2, show.CI = F,cex = 1, type=3)


#3단계. 독립변수와 매개변수 유의미한 관계인지 확인
fit_glm_3=lm(MONTHS_BALANCE ~ .-STATUS,  data=train)

vif(fit_glm_3)
summary(fit_glm_3)
ORplot(fit_glm_3, show.CI = F,cex = 1, type=3)


#4단계. 독립변수와 매개변수가 동시에 회귀방정식 투입되었을 때 매개변수가 종속변수에 여전히 유의한 영향을 미치는 한편, 독립변수와 종속변수들관의 관계는 매개변수가 투입되지 않았을 경우보다도 더 약화되거나(부분매개) 혹은 유의하지 않게 나타나야 한다(완전매개)
     
fit_glm_4=glm(STATUS ~ ., family=binomial, data=train)

vif(fit_glm_4)
summary(fit_glm_4)
ORplot(fit_glm_4, show.CI = F,cex = 1, type=3)




















