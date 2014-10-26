setwd("/Users/tunguz/Programming/R/MachineLearning/")
trainingData <- read.csv("pml-training.csv")
testData <- read.csv("pml-testing.csv")

head(trainingData)

useful_variables <- c("roll_belt", "pitch_belt", "yaw_belt", "total_accel_belt",
                      "gyros_belt_x", "gyros_belt_y", "gyros_belt_z",
                      "accel_belt_x", "accel_belt_y", "accel_belt_z", 
                      "magnet_belt_x", "magnet_belt_y",
                        "magnet_belt_z", "roll_arm", "pitch_arm",
                        "yaw_arm", "total_accel_arm", "gyros_arm_x",
                        "gyros_arm_y", "gyros_arm_z", "accel_arm_x",
                      "accel_arm_y", "accel_arm_z", "magnet_arm_x", "magnet_arm_y", 
                        "magnet_arm_z", "roll_dumbbell", "pitch_dumbbell", "yaw_dumbbell",
                      "gyros_dumbbell_y", "gyros_dumbbell_z", "accel_dumbbell_x",
                      "accel_dumbbell_y", "accel_dumbbell_z", "magnet_dumbbell_x",
                        "magnet_dumbbell_y", "magnet_dumbbell_z",
                      "roll_forearm", "pitch_forearm", "yaw_forearm",
                      "gyros_forearm_x", "gyros_forearm_y",
                      "gyros_forearm_z", "accel_forearm_x", 
                      "accel_forearm_y", "accel_forearm_z", "magnet_forearm_x",
                      "magnet_forearm_y", "magnet_forearm_z", "classe"
                      )

# splitdf function will return a list of training and testing sets
splitdf <- function(dataframe, seed=NULL) {
        if (!is.null(seed)) set.seed(seed)
        index <- 1:nrow(dataframe)
        trainindex <- sample(index, trunc(length(index)/2))
        trainset <- dataframe[trainindex, ]
        testset <- dataframe[-trainindex, ]
        list(trainset=trainset,testset=testset)
}

cleanTrainingData <- trainingData[useful_variables]

#apply the function
splits <- splitdf(cleanTrainingData, seed=808)

# save the training and testing sets as data frames
training <- splits$trainset
testing <- splits$testset

# Use the Random Forest library

library(randomForest)

#fit the randomforest model
model <- randomForest(classe~., 
                      data = training, 
                      importance=TRUE,
                      keep.forest=TRUE
)
print(model)

predicted <- predict(model, newdata=testing[ ,-50])
predicted
actual <- testing$classe
actual
as.numeric(actual) - as.numeric(predicted)
useful_variables_2 <- useful_variables[1:49]
cleanTestData <- testData[useful_variables_2]
predicted_2 <- predict(model, cleanTestData)
predicted_2

