public with sharing class SalesNonSKUScrubBatch implements Database.Batchable<sObject>{
    // Variable itemList is used to store all relevant Item__c records
    public List<Item__c> itemList;
    // Variable recordsProcessed is used to keep track of the number of Sales__c records processed
    private Integer recordsProcessed = 0;

    /*
    *********************************************************
    @Method Name    : SalesNonSKUScrubBatch (Constructor)
    @description    : Initializes itemList with all relevant Item__c records
    @param          : None
    @return         : None
    ********************************************************
    */
    public SalesNonSKUScrubBatch(){
        itemList = [SELECT id, name, sku__c, external_ID__c, Account_owner__c FROM Item__c WHERE (sku__c LIKE 'SKU%') AND (NOT External_id__c = NULL)];
    }

    /*
    *********************************************************
    @Method Name    : start
    @description    : Collects the batch of Sales__c records to be processed
    @param          : bc - BatchableContext
    @return         : Database.QueryLocator with the required query
    ********************************************************
    */
    public Database.QueryLocator start(Database.BatchableContext bc) {
        return Database.getQueryLocator(
            'SELECT createdDate, id, sku__c,  account__c FROM Sales__c WHERE (Not sku__c LIKE \'SKU%\') AND (Not sku__c = NUll) ORDER BY CreatedDate DESC'
        );
    }

    /*
    *********************************************************
    @Method Name    : execute
    @description    : Processes each batch of Sales__c records
    @param          : bc - BatchableContext, scope - List of Sales__c records
    @return         : None
    ********************************************************
    */
    public void execute(Database.BatchableContext bc, List<Sales__c> scope){
        for(Sales__c s : scope){
            for(Item__c item : itemList){
                // Checking if the SKU in the Sales__c record matches the external ID in the Item__c record
                if(s.sku__c == item.external_id__c){
                    // Updating the SKU and account owner in the Sales__c record
                    s.sku__c = item.sku__c;
                    s.account__c = item.Account_Owner__c;
                    recordsProcessed++;
                }
            }
        }
        update scope;
    }

    /*
    *********************************************************
    @Method Name    : finish
    @description    : Called once all batches have been processed, and logs the total number of Sales__c records processed
    @param          : bc - BatchableContext
    @return         : None
    ********************************************************
    */
    public void finish(Database.BatchableContext bc){
        System.debug('Number of Sales__c records processed: ' + recordsProcessed);
    }
}
