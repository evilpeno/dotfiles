#!/bin/bash
#!rm -f ~/.cache/weather.json
curl -s "https://query.yahooapis.com/v1/public/yql?q=select%20*%20from%20weather.forecast%20where%20woeid%20in%20(select%20woeid%20from%20geo.places(1)%20where%20text%3D%22Passo%20Fundo%2C%20BR%22)%20and%20u=%27c%27&format=json&env=store%3A%2F%2Fdatatables.org%2Falltableswithkeys" -o ~/.cache/weather.json
#!sleep 4
