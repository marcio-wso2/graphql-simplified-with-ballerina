import ballerina/log;
import ballerina/http;

configurable int sleep_summary_port = 9091;
service /activities/summary on new http:Listener(sleep_summary_port) {

    function init() {
        log:printInfo("Fitfit sleep summary API started", host = "0.0.0.0", port = sleep_summary_port, protocol = "HTTP");
    }

    resource function get sleep/user/[string id]() returns json {
        return sleepSummary;
    }
}

final json & readonly sleepSummary = {
    "sleep": [
        {
            "date": "2022-03-20",
            "duration": 28800,
            "levels": {
                "summary": {
                    "deep": {
                        "minutes": 19000,
                        "thirtyDayAvgMinutes": 23000
                    },
                    "light": {
                        "minutes": 9000,
                        "thirtyDayAvgMinutes": 7500
                    },
                    "wake": {
                        "minutes": 800,
                        "thirtyDayAvgMinutes": 700
                    }
                }
            }
        },
        {
            "date": "2022-03-15",
            "duration": 28080,
            "levels": {
                "summary": {
                    "deep": {
                        "minutes": 20900,
                        "thirtyDayAvgMinutes": 23000
                    },
                    "light": {
                        "minutes": 8080,
                        "thirtyDayAvgMinutes": 7500
                    },
                    "wake": {
                        "minutes": 180,
                        "thirtyDayAvgMinutes": 700
                    }
                }
            }
        },
        {
            "date": "2022-03-10",
            "duration": 28080,
            "levels": {
                "summary": {
                    "deep": {
                        "minutes": 20000,
                        "thirtyDayAvgMinutes": 23000
                    },
                    "light": {
                        "minutes": 8080,
                        "thirtyDayAvgMinutes": 7500
                    },
                    "wake": {
                        "minutes": 80,
                        "thirtyDayAvgMinutes": 700
                    }
                }
            }
        },
        {
            "date": "2022-02-10",
            "duration": 23400,
            "levels": {
                "summary": {
                    "deep": {
                        "minutes": 20000,
                        "thirtyDayAvgMinutes": 23000
                    },
                    "light": {
                        "minutes": 3000,
                        "thirtyDayAvgMinutes": 7500
                    },
                    "wake": {
                        "minutes": 400,
                        "thirtyDayAvgMinutes": 700
                    }
                }
            }
        },
        {
            "date": "2022-02-03",
            "duration": 27000,
            "levels": {
                "summary": {
                    "deep": {
                        "minutes": 20000,
                        "thirtyDayAvgMinutes": 23000
                    },
                    "light": {
                        "minutes": 7000,
                        "thirtyDayAvgMinutes": 7500
                    },
                    "wake": {
                        "minutes": 0,
                        "thirtyDayAvgMinutes": 700
                    }
                }
            }
        },
        {
            "date": "2022-01-07",
            "duration": 25200,
            "levels": {
                "summary": {
                    "deep": {
                        "minutes": 20000,
                        "thirtyDayAvgMinutes": 23000
                    },
                    "light": {
                        "minutes": 5000,
                        "thirtyDayAvgMinutes": 7500
                    },
                    "wake": {
                        "minutes": 200,
                        "thirtyDayAvgMinutes": 700
                    }
                }
            }
        },
        {
            "date": "2022-01-01",
            "duration": 28800,
            "levels": {
                "summary": {
                    "deep": {
                        "minutes": 20000,
                        "thirtyDayAvgMinutes": 23000
                    },
                    "light": {
                        "minutes": 8000,
                        "thirtyDayAvgMinutes": 7500
                    },
                    "wake": {
                        "minutes": 800,
                        "thirtyDayAvgMinutes": 700
                    }
                }
            }
        }
    ]
};
