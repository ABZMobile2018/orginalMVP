# kiwi-airbrowz

## Category mappings
0=Fashion , 1=Food, 2=Electronics, 3=Entertainment, 4=Health/Fitness, 5=Service, 6=Lifestyle. 7=Furniture, 8=Misc

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