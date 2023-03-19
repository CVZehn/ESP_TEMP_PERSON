/*
   MQTT Sensor - Temperature and Humidity (DHT22) for Home-Assistant - NodeMCU (ESP8266)
   https://home-assistant.io/components/sensor.mqtt/
   Libraries :
    - ESP8266 core for Arduino : https://github.com/esp8266/Arduino
    - PubSubClient : https://github.com/knolleary/pubsubclient
    - DHT : https://github.com/adafruit/DHT-sensor-library
    - ArduinoJson : https://github.com/bblanchon/ArduinoJson
   Sources :
    - File > Examples > ES8266WiFi > WiFiClient
    - File > Examples > PubSubClient > mqtt_auth
    - File > Examples > PubSubClient > mqtt_esp8266
    - File > Examples > DHT sensor library > DHTtester
    - File > Examples > ArduinoJson > JsonGeneratorExample
    - http://www.jerome-bernard.com/blog/2015/10/04/wifi-temperature-sensor-with-nodemcu-esp8266/
   Schematic :
    - https://github.com/mertenats/open-home-automation/blob/master/ha_mqtt_sensor_dht22/Schematic.png
    - DHT22 leg 1 - VCC
    - DHT22 leg 2 - D1/GPIO5 - Resistor 4.7K Ohms - GND
    - DHT22 leg 4 - GND
    - D0/GPIO16 - RST (wake-up purpose)
   Configuration (HA) :
    sensor 1:
      platform: mqtt
      state_topic: 'office/sensor1'
      name: 'Temperature'
      unit_of_measurement: '°C'
      value_template: '{{ value_json.temperature }}'
    
    sensor 2:
      platform: mqtt
      state_topic: 'office/sensor1'
      name: 'Humidity'
      unit_of_measurement: '%'
      value_template: '{{ value_json.humidity }}'
   Samuel M. - v1.1 - 08.2016
   If you like this example, please add a star! Thank you!
   https://github.com/mertenats/open-home-automation
*/

#include <ESP8266WiFi.h>
#include <PubSubClient.h>
#include <ArduinoJson.h>
#include "dht12z.h"

#define MQTT_VERSION MQTT_VERSION_3_1_1
#define PERSON_SENSOR_PIN 10

// Wifi: SSID and password
const char* WIFI_SSID = "Zehn_YIT";
const char* WIFI_PASSWORD = "YYDS1024512";

// MQTT: ID, server IP, port, username and password
const PROGMEM char* MQTT_CLIENT_ID = "office_dht22";
const PROGMEM char* MQTT_SERVER_IP = "192.168.31.201";
const PROGMEM uint16_t MQTT_SERVER_PORT = 1883;
const PROGMEM char* MQTT_USER = "admin";
const PROGMEM char* MQTT_PASSWORD = "HMZB1527733";

// MQTT: topic
const PROGMEM char* MQTT_SENSOR_TOPIC = "bedroom/sensor1";
const PROGMEM char* MQTT_SENSOR_PERSON_TOPIC = "livingroom/person_sensor";

// sleeping time
const PROGMEM uint16_t SLEEPING_TIME_IN_SECONDS = 600; // 10 minutes x 60 seconds

DHT12_z DHT12(4, 5);
WiFiClient wifiClient;
PubSubClient client(wifiClient);

// function called to publish the temperature and the humidity
void publishData(float p_temperature, float p_humidity) {
  // create a JSON object
  // doc : https://github.com/bblanchon/ArduinoJson/wiki/API%20Reference
  StaticJsonBuffer<200> jsonBuffer;
  JsonObject& root = jsonBuffer.createObject();
  // INFO: the data must be converted into a string; a problem occurs when using floats...
  root["temperature"] = (String)p_temperature;
  root["humidity"] = (String)p_humidity;
  root.prettyPrintTo(Serial);
  Serial.println("");
  /*
     {
        "temperature": "23.20" ,
        "humidity": "43.70"
     }
  */
  char data[200];
  root.printTo(data, root.measureLength() + 1);
  client.publish(MQTT_SENSOR_TOPIC, data, true);
  yield();
}

// function called when a MQTT message arrived
void callback(char* p_topic, byte* p_payload, unsigned int p_length) {
}

void reconnect() {
  // Loop until we're reconnected
  while (!client.connected()) {
    Serial.println("INFO: Attempting MQTT connection...");
    // Attempt to connect
    if (client.connect(MQTT_CLIENT_ID, MQTT_USER, MQTT_PASSWORD)) {
      Serial.println("INFO: connected");
    } else {
      Serial.print("ERROR: failed, rc=");
      Serial.print(client.state());
      Serial.println("DEBUG: try again in 5 seconds");
      // Wait 5 seconds before retrying
      delay(5000);
    }
  }
}

void setup() {
  // init the serial
  Serial.begin(115200);
	pinMode(PERSON_SENSOR_PIN, INPUT);

  DHT12.DHTC12_MInit();

  // init the WiFi connection
  Serial.println();
  Serial.println();
  Serial.print("INFO: Connecting to ");
  WiFi.mode(WIFI_STA);
  Serial.println(WIFI_SSID);
  WiFi.begin(WIFI_SSID, WIFI_PASSWORD);

  while (WiFi.status() != WL_CONNECTED) {
    delay(500);
    Serial.print(".");
  }

  Serial.println("");
  Serial.println("INFO: WiFi connected");
  Serial.println("INFO: IP address: ");
  Serial.println(WiFi.localIP());

  // init the MQTT connection
  client.setServer(MQTT_SERVER_IP, MQTT_SERVER_PORT);
  client.setCallback(callback);
}
float t12 ;
uint16_t h12;
void publishData_person(uint8_t had_person)
{
  String messageString = (had_person == true) ? "{\"state\":\"ON\"}" : "{\"state\":\"OFF\"}"; 
  client.publish(MQTT_SENSOR_PERSON_TOPIC, messageString.c_str(), true);
}

void delayandcheck_preson(int16_t ms)
{
  static uint8_t had_person = false;
  while (ms--)
  {
    if(digitalRead(PERSON_SENSOR_PIN) == HIGH && had_person == false) 
    {
       publishData_person(had_person = true);
    }
    delay(1);
  }

  if(digitalRead(PERSON_SENSOR_PIN) == LOW && had_person == true)
  {
      publishData_person(had_person = false);
  }
}

void loop() {
  if (!client.connected()) {
    reconnect();
  }
  client.loop();
    DHT12.ReadDHTC12_M(&t12, &h12);
    t12 = t12/10;
    h12 = h12/10;
		Serial.print("DHT12=> Humidity: ");
		Serial.print(h12);
		Serial.print(" %\t");
		Serial.print("Temperature: ");
		Serial.print(t12);
		Serial.print(" *C ");
    
  if (isnan(h12) || isnan(t12)) {
    Serial.println("ERROR: Failed to read from DHT sensor!");
    return;
  } else {
    //Serial.println(h);
    //Serial.println(t);
    publishData(t12, h12);
  }

  Serial.println("INFO: Closing the MQTT connection");
  //client.disconnect();

  //Serial.println("INFO: Closing the Wifi connection");
  //WiFi.disconnect();

  //ESP.deepSleep(SLEEPING_TIME_IN_SECONDS * 1000, WAKE_RF_DEFAULT);
  //ESP.deepSleep(1000*1000*10, WAKE_RF_DEFAULT);
  delayandcheck_preson(5000); // wait for deep sleep to happen
  //WiFi.reconnect();

}
