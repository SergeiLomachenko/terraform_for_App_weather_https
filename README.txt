Порядок действий для запуска CI/CD:
1) terraform init, terraform validate, terraform plan -out plan_1 (либо свое название), terraform apply plan_1
2) пушим всё наше приложение в римоут репо weather-app - https://gitlab.com/lomachenko-98/weather-app.git
оттуда в пайплайн тянется код и разворачивается приложение на нашей тачке в aws
3) заходим в AWS, берем паблик айпи
4) заходим сюда https://my.noip.com/dynamic-dns в мой аккаунт и меняем айпи домена на скопированный из консоле aws
5) заходим в переменные ci cd и вставляем значение паблик айпи в REMOTE_HOST
6) немного ждем пока днс заработает, потом в браузере вводим sergeyweather.ddns.net и смотрим актуальную погоду в минске
    

