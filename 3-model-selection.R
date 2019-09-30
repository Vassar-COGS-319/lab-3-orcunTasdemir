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


test <- accumulator.model(1000, 89.1, 82.3, 3)

correct <- test %>% filter(correct==TRUE)
incorrect <- test %>% filter(correct==FALSE)

mean(correct$rt)
mean(incorrect$rt)
sum(test$correct) / length(test$correct)

#------------------------------------------------------------------------------

test2 <- random.walk.model(1000, -0.00002 , 0.265 , 4)

correct2 <- test2 %>% filter(correct==TRUE)
incorrect2 <- test2 %>% filter(correct==FALSE)

mean(correct2$rt)
mean(incorrect2$rt)
sum(test2$correct) / length(test2$correct)


# Can both models do a reasonable job of accounting for the mean RT and accuracy? Report the
# results of your efforts:

## I believe they both do reasonably well in predicting the RT means but I don't know if the
## same can be said for the accuracy values. Trying to fit the data for the mean RT rates was
## easier, however, I could not do it for the accuracy levels for either of the models. Accuracy
## levels were always below 0.8. It seemedlike the model was insufficient and not complex enough
## to model for the 0.8 accuracy level around the RT mean values I was fixing for. 


# Using the parameters that you found above, plot histograms of the distribution of RTs
# predicted by each model. Based on these distributions, what kind of information could
# we use to evaluate which model is a better descriptor of the data for the experiment?
# Describe briefly how you might make this evaluation.


hist(test$rt)
hist(test2$rt)

## I think the accumulator model is a better way to plot for this data.
## The reason is that the random-walk model has a wider range that has
## the majority of the total frequency value spread widely over the graph which
##O creates a sense of possible inprecision and ambiguity for the model's part.
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





