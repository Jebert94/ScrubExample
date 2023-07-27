## SalesNonSKUScrubSync and SalesNonSKUScrubBatch Classes

## Overview

SalesNonSKUScrubSync and SalesNonSKUScrubBatch classes work in coordination to execute periodic scrubbing and synchronization of sales data that lack SKU details. The SalesNonSKUScrubSync class sets the schedule for triggering the SalesNonSKUScrubBatch class, which, in turn, performs the core tasks of sales record retrieval and SKU scrubbing.

## SalesNonSKUScrubSync Class

SalesNonSKUScrubSync is a Salesforce Apex class that implements the Schedulable interface. Its primary function is to schedule the execution of the SalesNonSKUScrubBatch class at specific intervals.

## SalesNonSKUScrubBatch Class

SalesNonSKUScrubBatch is the main class performing the tasks of sales record retrieval and SKU scrubbing. This class implements the Database.Batchable<sObject> interface, which allows it to process large numbers of records asynchronously. This class retrieves Sales__c and Item__c records from Salesforce, scrubs the SKU details and synchronizes the sales records.

## Class Methods Descriptions

**SalesNonSKUScrubSync Class**
execute(SchedulableContext sc): This method is essential to the Schedulable interface. It triggers the SalesNonSKUScrubBatch for execution when the scheduler fires.

**SalesNonSKUScrubBatch Class**
start(Database.BatchableContext bc): This method collects batches of Sales__c records to be processed. It returns a Database.QueryLocator with the required query.

execute(Database.BatchableContext bc, List<Sales__c> scope): This is the main method where each batch of Sales__c records is processed. This method gets called for each batch of records to be processed.

finish(Database.BatchableContext bc): This method is called once all batches have been processed. It logs the total number of Sales__c records processed.

## How To Use

Schedule the SalesNonSKUScrubSync using Salesforce's System.schedule method.

## Notes

All Object Names, Methods, and Variables have been modified from the original classes for security purposes.
