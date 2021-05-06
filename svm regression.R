set.seed(1234)


library(caret)
library(e1071)
library(randomForest)
library(kernlab)

#loading dataset

dataset <- read.csv("blosumIndicescombinedoptim.csv", header = TRUE)
row.names(dataset) <-dataset$Name
dataset[1] <- NULL

#ext <- read.csv("blosumIndicessaitooptim.csv", header = TRUE)

#dividing data for training

validation_index <- createDataPartition(dataset$Class, p=0.7, list=FALSE)

validation <- dataset[-validation_index,]

dataset <- dataset[validation_index,]



control <- trainControl(method="cv", number=10, classProbs = FALSE)
metric <- "Rsquared"

fit.svm <- train(Class~., data=dataset, method="svmPoly", metric=metric, trControl=control, tunelength = 10)

# predicting using best model
predictions <- predict(fit.svm, validation)
#extpred <- predict(fit.svm, ext)



pred <-write.csv(predictions, "pred.csv")
test <-write.csv(validation, "test.csv")
#extval <-write.csv(extpred, "external validation.csv")
