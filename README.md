# AUTOMATING-DATA-INTEGRATION
 Developed complex SQL statements in order to implement functions, stored procedures, and triggers to prepare data sets for data analysis and manipulation.  Configured data extraction, transformation, and loading tasks in order to automate data integration.

Database Management and ETL in PostgreSQL

This task defines a report as a collection of data that answers a real-world business question. The report contains two distinct sections that differ in the granularity of the data they present and how directly they support the answering of the business question of interest. The Detailed section will contain all data that informs the answers to the question, and the Summary section will include contains relevant aggregated data that provide the answer to the business question. For example, if the business question of interest in the context of a computer factory is focused on the number of the computers manufactured in the past six months, the detailed portion of a report could contain details on each individual computer made, while the summary portion contains only the total number of computers made in each factory.

Your business question must rely on the aggregation of data. In this task, the summary data will be automatically created from the detailed data.

- Summarized one real-world business report that can be created from the attached Data Sets and Associated Dictionaries.

- Described the data used for the report.

- Identifed two specific tables from the given DVD RENTAL dataset that will provide the data necessary for the detailed and the summary sections of the report.

- Identified the specific fields that will be included in the detailed and the summary sections of the report.

- Identifed one field in the detailed section that requirex a custom transformation and explaindx why it should be transformed. 

- Explained the different business uses of the detailed and the summary sections of the report.

- Explained how frequently report should be refreshed to remain relevant to stakeholders.

- Wrote SQL code that creates the tables to hold report sections.

- Wrote a SQL query that extracts the raw data needed for the Detailed section of the report from the source database and verifed the data’s accuracy.

- Write code for function(s) that perform the transformation(s) in part A4.

- Wrote a SQL code that created a trigger on the detailed table of the report that continually updates the summary table as data is added to the detailed table.

- Created a stored procedure that can be used to refresh the data in both the detailed and summary tables. The procedure clears the contents of the detailed and summary tables and perform the ETL load process from part C.

- Explained how the stored procedure can be run on a schedule to ensure data freshness.




