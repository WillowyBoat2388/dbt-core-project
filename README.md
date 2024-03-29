Welcome to the TPCH_SF Analytics Report

### Project Description:
This is an analytics engineer project done for a fictitious organization by the name of Millage Group.

I have been tasked with creating a report and populating the organization's warehouse with certain models to answer specific business and customer related questions, and generate insights for decision-making across a range of teams within the organization.

This report will provide more information on the individual insights generated by each table or model.

### Model Description:
- ###### Model One:
    Model one gives insight into the profit generated by suppliers of parts for the organization, specifically for green parts grouped by the nation each supplier is from.
- ###### Model Two:
    The second model identifies the top twenty customers who lost revenue and returned their ordered items within the third quarter of 1993.
    This model helps identify which customers have the most dire need of support from the organization i.e the customers who have the most problems with the items they ordered during that quarter.
- ###### Model Three:
    The third model generates the necessary information regarding the distribution of customers according to the size of their order, while exempting customers who ordered 'special' items.
- ###### Model Four:
    Model four deals with identifying the ten greatest value unshipped orders, that is orders with the greatest price that are yet to be shipped by the organziation for the first quarter of 1995.
- ###### Model Five:
    This is a model to determine how well the order priority system is working and gives an assessment of customer satisfaction within the first 2 quarters of the year 1993.
- ###### Model Six:
    This model focuses its attention on showing revenue volume for local suppliers that is, suppliers that supply parts to customers within the same nation. Therefore the model returns a table that shows revenue volume per nation, with the nation that has the highest revenue beginning the table.
- ###### Model Seven:
    The total price each customer spent along with their nation of origin and the date of their order are returned by this model. Along with this, a running sum of the total sum spent by each customer across dates is returned in a separate column
- ###### Model Eight:
    Each supplier nation is grouped and the total quantity of items they sold in their three most lucrative or successful years and months is returned and a rank is given to each row.
- ###### Model Nine:
    The total price each customer spent along with the date of their order are returned by this model. Along with this a running sum of the total sum spent by each customer across previous dates before each row is returned, likewise the percent change between the amount each customer spent on previous dates and the current date are returned.
- ###### Model Ten:
    The total price each customer spent along with the date of their order are returned by this model. Along with this, two columns that return true or false are returned. The first boolean column checks if the total price increased between the previous date and the current date, while the second boolean column checks if total price is less than the next day's total price.
- ###### Model Eleven:
    This model analyzes the percentage of revenue from promotional parts for each month of the last quarter of 1995.

### Interacting with the Project:

To begin working with the project, the intended user must begin by ensuring that he has DBT installed locally, and has Snowflake credentials to be able to interact with the TPC_H dataset.

### Using the project
To run the project, clone the repository from this GitHub page. Afterwards, if all necessary dependencies are installed, ensure that a profiles.yml file is present and then input your snowflake credentials into the yaml file. 
The profiles.yml template can be found under the dev branch of this GitHub repository. To begin;
Try running the following commands:
- dbt debug
- dbt run

 Afterwards, you should find the created models within your snowflake database schema.

### Feedback on the Project:
From this project, I learnt quite a bit about what it taks to setup a DBT workflow with Snowflake as the Data Warehouse
- ###### Ready to go

### Resources:

- Learn more about dbt [in the docs](https://docs.getdbt.com/docs/introduction)
- Check out [Discourse](https://discourse.getdbt.com/) for commonly asked questions and answers
- Join the [chat](https://community.getdbt.com/) on Slack for live discussions and support
- Find [dbt events](https://events.getdbt.com) near you
- Check out [the blog](https://blog.getdbt.com/) for the latest news on dbt's development and best practices
