global class SalesNonSKUScrubSync implements Schedulable {
    //Class set up to be scheduled as an Apex Job
    global void execute(SchedulableContext sc){
            SalesNonSKUScrubBatch batchObject = new SalesNonSKUScrubBatch();
            Id batchId = Database.executeBatch(batchObject, 200);
        }
}