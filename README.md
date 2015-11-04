# kiwi-airbrowz

## Category mappings
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