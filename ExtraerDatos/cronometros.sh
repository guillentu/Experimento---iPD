countdown(){     date1=$((`date +%s` + $1));     while [ "$date1" -ge `date +%s` ]; do      days=$(($(($(( $date1 - $(date +%s))) * 1 ))/86400));     echo -ne "$days day(s) and $(date -u --date @$(($date1 - `date +%s`)) +%H:%M:%S)\r";      sleep 0.1;     done; eject -T; }


function countdown(){    date1=$((`date +%s` + $1));     while [ "$date1" -ge `date +%s` ]; do       echo -ne "$(date -u --date @$(($date1 - `date +%s`)) +%H:%M:%S)\r";      sleep 0.1;    done; eject -T; }



function stopwatch(){   date1=`date +%s`;     while true; do      echo -ne "$(date -u --date @$((`date +%s` - $date1)) +%H:%M:%S)\r";      sleep 0.1;    done; }


