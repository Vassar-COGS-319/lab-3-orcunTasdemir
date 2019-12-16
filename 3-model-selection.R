# model selection ####

# suppose we have data from an experiment like this:
# mean RT correct = 250ms
# mean RT incorrect = 246ms
# accuracy = 0.80

# try to fit this data with both models by adjusting the parameters of the model
# HINT: you can speed up your parameter search by using a small number of samples
# initially, and then increasing the samples as you get closer to a viable set
# of parameters.
# 2nd HINT: Don't adjust the sdrw parameter of the random.walk.model or the criterion
# paramter of the accumulator model.

# You don't need to get a perfect match. Just get in the ballpark. 


# test <- accumulator.model(1000, 89.1, 82.3, 3) #below are  the means I got for correct/incorrect
# > mean(correct$rt)                             #and the accuracy rate of 0.205 which is very off
# [1] 250.4732
# > mean(incorrect$rt)
# [1] 244.7057
# > sum(test$correct) / length(test$correct)
# [1] 0.205

test <- accumulator.model(1000, 85, 91, 3)

correct <- test %>% filter(correct==TRUE)
incorrect <- test %>% filter(correct==FALSE)

mean(correct$rt)
mean(incorrect$rt)
sum(test$correct) / length(test$correct)

#------------------------------------------------------------------------------

#test2 <- random.walk.model(1000, -0.00002 , 0.265 , 4) #this line gave me the stats below
# > mean(correct2$rt)                                   #I simply couldn't get the correct numbers
# [1] 239.0118
# > mean(incorrect2$rt)
# [1] 246.4705
# > sum(test2$correct) / length(test2$correct)
# [1] 0.509
test2 <- random.walk.model(1000, 0.012 , 0.3, 4.8)

correct2 <- test2 %>% filter(correct==TRUE)
incorrect2 <- test2 %>% filter(correct==FALSE)

mean(correct2$rt)
mean(incorrect2$rt)

#test2 %>% group_by(correct) %>% summarize(mean.rt = mean(rt))
#the way you got the means here looks much nicer

sum(test2$correct) / length(test2$correct)


# Can both models do a reasonable job of accounting for the mean RT and accuracy? Report the
# results of your efforts:

#Initially I thought that the model was not complex enough to give the correct accuracy level

## I believe they both do reasonably well in predicting the RT means but I don't know if the
## same can be said for the accuracy values. Trying to fit the data for the mean RT rates was
## easier, however, I could not do it for the accuracy levels for either of the models. Accuracy
## levels were always below 0.8. It seemedlike the model was insufficient and not complex enough
## to model for the 0.8 accuracy level around the RT mean values I was fixing for. 


# Using the parameters that you found above, plot histograms of the distribution of RTs
# predicted by each model. Based on these distributions, what kind of information could
# we use to evaluate which model is a better descriptor of the data for the experiment?
# Describe briefly how you might make this evaluation.


# hist(test$rt)
# hist(test2$rt)

#initially I thought I only needed to plot these two histograms above
#seeing your solutions, ı am now plotting the new histograms too.

layout(matrix(1:4, nrow=2, byrow=T))

hist((test2 %>% filter(correct==TRUE))$rt, breaks=seq(0,2000,100), main="RW Model, correct", xlab="RT")
hist((test2 %>% filter(correct==FALSE))$rt, breaks=seq(0,2000,100), main="RW Model, incorrect", xlab="RT")

#I found using a range from 0 to 500 visually more understandable for the histogram for the accumulator model (ACC)
hist((test %>% filter(correct==TRUE))$rt, breaks=seq(0,500,10), main="ACC Model, correct", xlab="RT")
hist((test %>% filter(correct==FALSE))$rt, breaks=seq(0,500,10), main="ACC Model, incorrect", xlab="RT")

##My initial attempt to answer the question is below where it looks like I am trying to say that
##the random walk model gives us more scattered values for Rt which means that it is not
##very precise. The variability, which is something you also talked about in your solution.
##However, apart from the precision, what I needed to comment on is the fact that the standard deviation
## we get from the two models are significantly different as you pointed out.
##When we calculate the standard deviations for each model:

#random walk model is test2
test2 %>% group_by(correct) %>% summarize(sd.rt = sd(rt))
# correct sd.rt
# <lgl>   <dbl>
# FALSE    171.
# TRUE     188.

#accumulator model is test
test%>% group_by(correct) %>% summarize(sd.rt = sd(rt))
# correct sd.rt
# <lgl>   <dbl>
# FALSE    12.2
# TRUE     14.8

#As we see the standard deviation the random walk model generates is very high
#compared to the standard deviation from the accumulator model, which means that
#for these accuracy and rt levels for both correct and incorrect responses, accumulator
#model is much better at fitting the data.



#Another thing you said about the accumulator model's rt level graphs being more symmetric
#also makes sense in that the AC model does not have an unnatural favoring of response times that are
#shorter as the RW model does, instead the response times around the mean response time are
#evenly distributed in terms of their frequency of occurence.


#BELOW is my initial commentary which I think still communicates the ideas
#in an informal way but given the standard deviation calculations now,
#It is more grounded. The part about the MDD does not make sense to me now, or rather that I am not sure if makes sense.

## I think the accumulator model is a better way to plot for this data.
## The reason is that the random-walk model has a wider range that has
## the majority of the total frequency value spread widely over the graph which
## creates a sense of possible inprecision and ambiguity for the model's part.
## The accumulator model on the other hand is much less spread and produces a better
## difference between the frequent occurences of the RT means and the much less
## infrequent values. It has a spike at one value another that is very close to the
## first one and the third most frequency looks insignificant compared to the first two
## which shows a better sense of precision for the model. It is as if the most frequent
## RT mean is resulted by the group with MDD, the second one is characterized by the control group
## and the rest of the points on the histogram are the relatively outlier data that would
## get accounted for as you increased the sample space of the experiment, and they would get
## less and less insignificant quicker (than in the random-walk-model) as the changes of the
## sample size reflect exponentially to the RT mean value. The random-walk-model is not very
## representative of the 20-80% rule that seems to govern most things (zipfy law).





