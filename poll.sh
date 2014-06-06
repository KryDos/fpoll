#! /bin/bash
 
FILE_COOKIE='/tmp/poll.ru_cookie'
POLL_KEY='oeksq'
POLL_ID=8991
VOTE=3 #Номер варианта ответа
USER_AGENT='Mozilla/4.73 [en] (X11; U; Linux 2.2.15 i686)'
 
function vote {
        rm "$FILE_COOKIE" &> /dev/null #Чистим куки
        #Получаем уникальный токен
        token=`curl -s -D "$FILE_COOKIE" -d "poll_key=$POLL_KEY" http://poll.ru/index.php | tail -c 34 | cut -c -32`
        #Голосуем
        curl -s -b "$FILE_COOKIE" -d "votes[]=$VOTE&poll_id=$POLL_ID&token=$token" --user-agent "$USER_AGENT" http://poll.ru/vote.php &> /dev/null
}
 
x=1000 #сколько голосов накрутить
i=1
while [ $i -le $x ]; do
        vote
        echo $i of $x
        ((i++))
done
echo Done!
 
exit 0
