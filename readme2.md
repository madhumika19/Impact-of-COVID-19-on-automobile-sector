# Impact of Covid-19 on automobile sector

# Objective

Comparing the nifty indices of Automobile sector from pre and post COVID-19 scenarios using Wald test with bootstrap variance estimates.

# Bootstrap Sampling Method

The basic idea of `bootstrap` is make inference about a estimate(such as sample mean) for a population parameter &theta; (such as population mean) on sample data. It is a resampling method by independently sampling with replacement from an existing sample data with same sample size `n`, and performing inference among these resampled data.

Generally, bootstrap involves the following steps:
1) A sample from population with sample size `n`.
2) Draw a sample from the original sample data with replacement with size `n`, and replicate B times, each re-sampled sample is called a Bootstrap Sample, and there will totally B Bootstrap Samples.
3) Evaluate the statistic of &theta; for each Bootstrap Sample, and there will be totally B estimates of &theta;.
4) Construct a sampling distribution with these B Bootstrap statistics and use it to make further statistical inference, such as:
    * Estimating the `standard error` of statistic for &theta;.
    * Obtaining a `Confidence Interval` for &theta;.


`Variance Estimation`

Sampling variance is an important measure of the quality of estimates of finite population parameters (totals, means,
quantiles etc.). It measures the amount of sampling error in the estimate due to observing a sample instead of the whole
population. Estimates of sampling variance are needed to produce the coefficients of variation (cv) that are disseminated
along with the survey estimates and to construct confidence intervals for finite population parameters of interest.

`The Standard Error`

The standard error of an estimator is it’s standard deviation. It tells us how far your sample estimate deviates from the actual parameter. If the standard error itself involves unknown parameters, we used the estimated standard error by replacing the unknown parameters with an estimate of the parameters.

# Nifty Index

The `Nifty` meaning is a derivation from the mix of two words, i.e. `“National Stock Exchange”` and `“fifty”`. It is an abbreviation of the National Stock Exchange Fifty. It is a collection of top performing 50 equity stocks that are actively trading in the index

Nifty is a popular stock index. The National Stock Exchange of India introduced it. This index was founded in 1992 and started trading in 1994

# Normality

`Normality` is a property of a random variable that is distributed according to the normal distribution .

# Testing for Normality

1) **Using a graph for normality test**
     * `Q Q Plot` :
       A Q Q plot compares two different distributions. If the two sets of data came from the same distribution, the points will fall on a 45 degree reference line. To use this type of graph for the assumption of normality, compare your data to data from a distribution with known normality
     * `Boxplot` :
       Draw a boxplot of your data. If your data comes from a normal distribution, the box will be symmetrical with the mean and median in the center. If the data meets the assumption of normality, there should also be few outliers.
     * `Normal Probability Plot`
       The normal probability plot was designed specifically to test for the assumption of normality. If your data comes from a normal distribution, the points on the graph will form a line.
     * `Histogram`
       The popular histogram can give you a good idea about whether your data meets the assumption. If your data looks like a bell curve: then it’s probably normal.

2) **Statistical Tests for Normality**
     * `Chi-square normality test`:
       You can use a chi square test for normality. The advantage is that it’s relatively easy to use, but it isn’t a very strong test. If you have a small sample (under 20), it may be the only test you can use. For larger samples, you’re much better off choosing another option.
     * `D’Agostino-Pearson Test`: This uses skewness and kurtosis to see if your data matches normal data. It requires your sample size to be over 20.
     * `Jarque-Bera Test`: This common test is also relatively straightforward. Like the D’Agostino-Pearson, the basic idea is that it tests the skew and kurtosis of your data to see if it matches what you would expect from a normal distribution. The larger the JB statistic, the more the data deviates from the normal.
     * `Kolmogorov-Smirnov Goodness of Fit Test`: This compares your data with a known distribution (i.e. a normal distribution).
     * `Lilliefors Test`: The Lilliefors test calculates a test statistic T which you can compare to a critical value. If the test statistic is bigger than the critical value, it’s a sign that your data isn’t normal. It also computes a p-value for your distribution, which you compare to a significance level. 
     * `Shapiro-Wilk Test`: This test will tell you if a random sample came from a normal distribution. The test gives you a W value; small values indicate your sample is not normally distributed.

# WALD Test

The `Wald test` (also called the `Wald Chi-Squared Test`) is a way to find out if explanatory variables in a model are significant. “Significant” means that they add something to the model; variables that add nothing can be deleted without affecting the model in any meaningful way.


**The null hypothesis for the test is**: `some parameter = some value`. For example, you might be studying if weight is affected by eating junk food twice a week. “Weight” would be your parameter. The value could be zero (indicating that you don’t think weight is affected by eating junk food). If the null hypothesis is rejected, it suggests that the variables in question can be removed without much harm to the model fit.
If the Wald test shows that the parameters for certain explanatory variables are zero, you can remove the variables from the model.
If the test shows the parameters are not zero, you should include the variables in the model.

The Wald test is usually talked about in terms of chi-squared, because the sampling distribution (as n approaches infinity) is usually known. This variant of the test is sometimes called the Wald Chi-Squared Test to differentiate it from the Wald Log-Linear Chi-Square Test, which is a non-parametric variant based on the log odds ratios.

# Libraries
`boot` `matlib` 

# References

1) https://towardsdatascience.com/an-introduction-to-the-bootstrap-method-58bcb51b4d60
2) https://nces.ed.gov/FCSM/pdf/2005FCSM_Mach_Dumais_Robidou_VA.pdf
3) https://scripbox.com/mf/what-is-nifty/
4) https://www.statistics.com/glossary/normality/
5) https://www.statisticshowto.com/assumption-of-normality-test/
6) https://www.statisticshowto.com/wald-test/
