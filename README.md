# kiwi-airbrowz

## Parse Data Structure

### \<category> in Deal Table
0 = Maternity & Children’s wear  
1 = Men’s Fashion  
2 = Women’s Fashion  
​3 = Books, Music, Games & Gifts  
4 = Computers, Tablets & Mobiles  
5 = Handbags & Footwear  
6 = Health & Beauty  
7 = Fitness & Well-Being  
8 = Food & Drink  
9 = Electronics & Entertainment  
10 = Automotive  
11 = Home & Garden  
12 = Services  
13 = Sports, Outdoor & Travel  
14 = Events  
15 = Misc  

### \<phone> in User Table
Stored as plain string "(647) - 456 - 8551"

### \<hoursOfOperation> in User Table
2D array where

* Outer array represents day of the week and starts from Monday
* Inner array represents ["OpeningHours", "ClosingHours"]  
<b>Note:</b> Each hour is in HH:MM format where HH ranges from [0,23] and MM ranges from [0,59]  



<b>Example</b>

[["09:00", "23:30"], ["00:00", "23:59"], [] ... ]  
Will represents following hours


| Day           | Hours         |
| ------------- |:-------------:|
| Monday        | 9:00 AM - 11:30 PM |
| Tuesday       | 12:00 AM - 11:59 PM|
| Wednesday     | Closed             |
|  .... | ....|




## Push Notifications
Example: Following curl will send push notification to every users

```
curl -X POST \
  -H "X-Parse-Application-Id: D7VKvOCpa2Pnt8lr3dvynhVQxoDW6AgiXVsyQuB1" \
  -H "X-Parse-REST-API-Key: ieH2cz8myRcudIyt2eoMIRq2orA2MqEtC4SaytF8" \
  -H "Content-Type: application/json" \
  -d '{
        "channels": [
          "global"
        ],
        "data": {
          "alert": "Hello Dave"
        }
      }' \
  https://api.parse.com/1/push
```

For detailed information please consult with [Parse-Push Notifications](https://parse.com/docs/rest/guide#push-notifications)