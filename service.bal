import ballerina/graphql;
import ballerina/http;
import graphql_simplified_with_ballerina.back_ends as _;

public enum TimeUnit {
  SECONDS,
  MINUTES
}


public type SleepSummary record{
  string date = "";
  int duration = 0; 
  Levels levels = {};
};

public type Levels record {
  int deep = 0;
  int wake = 0;
  int 'light = 0;
};

public type Sleep record {
    string date;
    int duration;
    record {
        map<record {int minutes; int thirtyDayAvgMinutes;}> summary;
    } levels;
};

configurable string fitFitApiUrl = "http://localhost:9091";

http:Client fitFitClient = check new(fitFitApiUrl);

// Don't change the port number
service /graphql on new graphql:Listener(9090) {

    // Write your answer here. You must change the input and
    // the output of the below signature along with the logic.
    resource function get sleepSummary(string ID, TimeUnit timeunit) returns SleepSummary[]|error {
        SleepSummary[] sleepSummary = [];

        json|http:ClientError restPayload = fitFitClient->get("/activities/summary/sleep/user/" + ID);

        if (restPayload is json){

            map<json> mapReturn = <map<json>>restPayload;
            json[] sleepArray = <json[]> mapReturn.get("sleep");

            foreach json sleep in sleepArray {
                Sleep _sleepObject = check sleep.cloneWithType();

                SleepSummary summary = {};
                // jsonpath expressions would be awesome to have!!
                record {int minutes; int thirtyDayAvgMinutes;} deepRecord = _sleepObject.levels.summary.get("deep");
                record {int minutes; int thirtyDayAvgMinutes;} lightRecord = _sleepObject.levels.summary.get("light");
                record {int minutes; int thirtyDayAvgMinutes;} wakeRecord = _sleepObject.levels.summary.get("wake");
                
                summary.date = _sleepObject.date;
                summary.duration = self.convertDuration(_sleepObject.duration, timeunit);
                summary.levels = {
                    deep: self.convertDuration(deepRecord.minutes, timeunit),
                    light: self.convertDuration(lightRecord.minutes, timeunit),
                    wake: self.convertDuration(wakeRecord.minutes, timeunit)
                };

                sleepSummary.push(summary);
            }

            return sleepSummary;
        }
        else {
            panic error (restPayload.toBalString());
        }
    }

    function convertDuration(int durationInMinutes, TimeUnit timeunit) returns int{
        match timeunit {
            SECONDS => {return durationInMinutes * 60;}
            _ => {return durationInMinutes;}
        }
    }
}