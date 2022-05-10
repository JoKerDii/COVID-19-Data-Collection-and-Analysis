# COVID-19 Data Collection and Analysis

[Project Notebook](https://nbviewer.org/github/JoKerDii/COVID-19-Data-Collection-and-Analysis/blob/main/project_notebook.ipynb)

## Data Collection

We are interested in the degree to which the SARS-CoV-2 virus has affected United States citizens (SARS-CoV-2 is the virus that causes the COVID-19 disease). The Centers for Disease Control and Prevention (CDC) provides relevant data from USAFacts.org that includes the number of confirmed COVID-19 cases on a per-county basis. At the bottom of the web page (https://usafacts.org/visualizations/coronavirus-covid-19-spread-map/), a blue table provides a list of states, each of which has its own web page displaying the reported numbers of cases and deaths.

We automatically downloaded each state's data with Requests and then manipulated it with BeautifulSoup. Specifically, we first fetched the web page located at `base_url` and save the request's returned object (a respond object) to `home_page`. We then used the BeautifulSoup object to parse the home page as an HTML document in order to extract the link for every state. With these extracted URLs, we populated a `state_urls` dictionary by setting each key to be the state name and the value to be the full URL. To avoid download state web pages multiple times frequently, we iterated through the `state_urls`, make a web request for each URL, and save the contents out to a file on the hard drive.

## Data Manipulation

We created a data object `covid_data` including 4 pieces of information 1) 7-day average case (integer) 2) 7-day average deaths (integer) 3) # of confirmed cases (total) (float if # of confirmed cases per 100k) 4) # of deaths (integer).

Since the population data per county has been removed from usafacts.org, we collected those population data from other sources. We ignored counties with missing population data or populations of 0.

## Exploratory Data Analysis (EDA) I

We first observed the single-most extreme counties and states, then inspected all states, after having sorted the data by some features. 

Considering that the data is messy and some are not reliable, we attempted to understand some of the uncertainty around COVID data. We consider that false negatives of deaths of COVID-19 is minimal. Every disease has a mortality rate and we can consider it's constant throughout all people in the US. Although some are at highe risk (e.g. older folks, people with pre-existing conditions, etc), we can imagine that this variance in the population to be fairly uniform throughout the USA. Therefore, if all counties were equal in their testing, we are supposed to see a consistent ratio between # people who died from COVID and # of people who tested positive for COVID, which is called 'case fatality rate'.

We learned from the analyses that states vary wildly in their death rate (e.g., The number of deaths in New Jersey or California is orders of magnitude higher than those in Hawaii or Alaska) and COVID testing. States also fluctuate a lot amongst their counties, as some counties with very bad statistics are within states with good statistics.

When it comes to data reliability, some states and counties are probably more proactive when it comes to testing, so they could have higher cases counts. Other counties might have a similar number of cases or higher, but they are just not being represented in the data due to lower testing. Deaths are thus harder to overlook, so states with lax testing policies may have inflated deaths per case metrics. Perhaps we could supplement the data with some measure of testing rates in the county or state.

## Incorporate More Data

We are also interested in how COVID has impacted our world. We can better understand this by looking at how it relates to demographics, income, education, health, and politicala voting.

Our `case_fatality_rate` column can be viewed as an approximation of how effective and thorough COVID testing is for a given county. Our `# covid deaths` column can be viewed as an extreme indication of how severe COVID has impacted a given county. Our `# covid cases per 100k` column be viewed as middle-ground between the two aforementioned features. That is, it measures the impact of the disease and is influenced by the thoroughness of COVID testing.

Using these three informative features, we can inspect how impacted each county is, while correlating this with other features of each county, such as income-level, health metrics, demographics, etc.

In this project, we merged our COVID case data with 'election2020_by_county.csv' dataset. We only care about 15 columns which are hispanic, minority, female, unemployed, income, nodegree, bachelor, inactivity, obesity, desity, cancer, voter_turnout, voter_gap, trump, biden. We droppde fipscode and population columns.

## Exploratory Data Analysis (EDA) II

We can partition any quantitative feature by using quantiles. With arbitrarily chosen minv and maxv, we can partition certain feature of interest multiple times and observe interesting relationships.

We split the data into equal lower, middle, and upper quantiles based on first obeity and then inactivity. We can see that the the average death rates of counties in these partitions is positivly correlated with both of these features. This was expected as preexisting health conditions (obescity) and heath risks (inactivity) increase all cause mortality but also have a strong effect on how serious a covid infection can be. Finally we see that income has an even stronger relationship with the death rate, though here the correlation is a negative one. Obesity and inactivity are both negatively correlated with income as well. The relationship between voting for Trump and income is not a string one strong, though there is a positive correlation between Trump voting and obesity, inactivity, and covid death rate.

## Data Weakness

We can tell from comparing the populations between the groups that this data is not treated granularly as would be ideal. Very small population counties that get weighted the same as very large population counties in regards to the mean. So rural areas get over represented in the averages nationwide. This also explains why the Trump vs Biden is so far skewed from the actual well known national average based on popular votes.

Also, the difference between income correlates more with population density than it might with an individual socio economic status. First, a higher income might not go as far towards standard of living in the city as it does in rural areas. Second, by using the average income over the whole county, income inequality in that county is not factored in. There could be many low income individuals living with many high income individuals in the same county.

## Future Work

We have done data gathing, parsing, and exploring data. We can continue to predict some behavior of the data (e.g. how a particular county will respond to COVID on a weekly basis).

Alternatively, we could be interested in inference, whereby we are more concerned with trying to understand why and how a system behaves the way it does. We might wish to understand which factors most correlate and cause a certain event to happen. This could give us insights into where certain inequalities persist.

