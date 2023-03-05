# Metabase with Clickhouse

## Requirements

1) Docker

## How to use this repository

1) Download this dataset https://www.kaggle.com/datasets/mkechinov/ecommerce-behavior-data-from-multi-category-store into data-origin
2) Unzip the 2019-Nov.csv file in that same folder
3) in the root folder do "docker compose up"

## Notes

You can use any dataset you want, in this demo I'm using the one from Kaggle as it is a decent sized one to test Clickhouse performance. If you want to use another one, you'll need to change the data-origin/init.sh file where I create the table, insert the data via clickhouse-client binary and then create a database view to sanitize the data (as it comes with some nulls and datetimes with a stringified timezone)