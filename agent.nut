device.on("light_readings" function(msg) {

    //Plotly Data Object
    local data = [{
        x = msg.time_stamp, // Time Stamp from Device
        y = msg.lux_reading // Sensor Reading from Device
    }];

    // Plotly Layout Object
    local layout = {
        fileopt = "extend",
        filename = "Light Graph100", //same filename = same url
    };


    // Setting up Data to be POSTed
    local payload = {
    un = "MichaelUy627",
    key = "a4fhhm5v7c",
    origin = "plot",
    platform = "electricimp",
    args = http.jsonencode(data),
    kwargs = http.jsonencode(layout),
    version = "0.0.1"
};
    // encode data and log
    local headers = { "Content-Type" : "application/json" };
    //local headers2 = {"Content-Type" : "application/json" };
    local body = http.urlencode(payload);
    server.log(body);
    //local body2 = http.urlencode(payload);
    //server.log(body2);
    local url = "https://plot.ly/clientresp";
    //local url2 = "https://plot.ly/clientresp";
    HttpPostWrapper(url, headers, body, true);
    //HttpPostWrappertemp(url2, headers2, body2, true);
});

// When Device sends new readings, Run this!
device.on("temp_readings" function(msg) {

    //Plotly Data Object
    local data = [{
        x = msg.time_stamp, // Time Stamp from Device
        y = msg.temp_reading // Sensor Reading from Device
    }];

    // Plotly Layout Object
    local layout = {
        fileopt = "extend",
        filename = "Temperature Graph100", //same filename = same url
    };


    // Setting up Data to be POSTed
    local payload = {
    un = "MichaelUy627",
    key = "a4fhhm5v7c",
    origin = "plot",
    platform = "electricimp",
    args = http.jsonencode(data),
    kwargs = http.jsonencode(layout),
    version = "0.0.1"
};
    // encode data and log
    //local headers = { "Content-Type" : "application/json" };
    local headers2 = {"Content-Type" : "application/json" };
    //local body = http.urlencode(payload);
    //server.log(body);
    local body2 = http.urlencode(payload);
    server.log(body2);
    //local url = "https://plot.ly/clientresp";
    local url2 = "https://plot.ly/clientresp";
    //HttpPostWrapper(url, headers, body, true);
    HttpPostWrappertemp(url2, headers2, body2, true);
});


// Http Request Handler
function HttpPostWrapper (url, headers, string, log) {
  local lightrequest = http.post(url, headers, string);
  //local temprequest = http.post(url, headers, string);
  local response = lightrequest.sendsync();
  //local tempresponse = temprequest.sendsync();
  if (log)
    server.log(http.jsonencode(response));
    //server.log(http.jsonecode(tempresponse));
  return response;
}

function HttpPostWrappertemp (url2, headers2, string2, log2) {
  local temprequest = http.post(url2, headers2, string2);
  local tempresponse = temprequest.sendsync();
  if (log2)
    server.log(http.jsonencode(tempresponse));
  return tempresponse;
}

