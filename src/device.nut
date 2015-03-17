local light_sensor = hardware.pin8;
light_sensor.configure(ANALOG_IN);
//local temperature_sensor = hardware.pin9;
therm_sensor <- hardware.pin9;
therm_sensor.configure(ANALOG_IN);

therm_switch <- hardware.pin7;
therm_switch.configure(DIGITAL_OUT);
therm_switch.write(1);


//temperature_sensor.configure(ANALOG_IN);

const b_therm = 3988;
const t0_therm = 298.15;
const WAKEINTERVAL_MIN = 15; 

// function returns voltage from pin
function getSensor() {
    server.log("getting light");
    local supplyVoltage = hardware.voltage();
    local voltage = supplyVoltage * light_sensor.read() / 65535.0;
    return (voltage);
}
/*
function getSensortemp(){
    server.log("getting temperature");
    local supplyVoltage2 = hardware.voltage();
    local retvoltage = (temperature_sensor.read() - 273.0);
    return (retvoltage);
}
*/
function getSensortemp() {

        server.log("getting temp");
        local vrat_raw = 0;
        for (local i = 0; i < 10; i++) {
            vrat_raw += therm_sensor.read();
            imp.sleep(0.001); // sleep to allow thermistor pin to recharge
        }
        local v_rat = vrat_raw / ( 655350.0);
        local ln_therm = 0;
        // if high side therm
        ln_therm = math.log(v_rat / (1.0 - v_rat));
        //else {
          //  ln_therm = math.log((1.0 - v_rat) / v_rat);
        //}     
        local ret= (t0_therm * b_therm) / (b_therm - t0_therm * ln_therm);
        return ((ret -273.15) * 9.0/5.0 + 32.0);
}

// Send Sensor Data to be plotted
function sendDataToAgent() {
    // pulling lux data
    local supplyVoltage = hardware.voltage();
    local light_voltage = getSensor();
    // loading luxdata
    local luxdata = {
        lux_reading = light_voltage,
        time_stamp = getTime(),
    }
    
    //turn on thermistor
    therm_switch.write(0);
    // pull tempdata
    local temp_voltage = getSensortemp();
    therm_switch.write(1);
    // loading temp data
    local tempdata = {
        temp_reading =  temp_voltage,
        time_stamp = getTime(),
    }
    
    agent.send("light_readings", luxdata);
    agent.send("temp_readings", tempdata);
    
    // How often to make http request (seconds)
    
    imp.wakeup(30, sendDataToAgent);
}




// Get Time String, -14400 is for -4 GMT (Montreal)
// use 3600 and multiply by the hours +/- GMT.
// e.g for +5 GMT local date = date(time()+18000, "u");
function getTime() {
    local date = date(time()-25200,"L");
    local sec = stringTime(date["sec"]);
    local min = stringTime(date["min"]);
    local hour = stringTime(date["hour"]);
    local day = stringTime(date["day"]);
    local month = date["month"] +1;
    //server.log(month);
    //server.log(day);
    //server.log("month worked");
    local year = date["year"];
    return year+"-"+month+"-"+day+" "+hour+":"+min+":"+sec;
}

// Fix Time String
function stringTime(num) {
    if (num < 10)
        return "0"+num;
    else
        return ""+num;
}

// Initialize Loop
sendDataToAgent();
