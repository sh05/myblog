TODAY=`date +%Y_%m_%d`
TITLE=$TODAY-作業ログ.md
LOGPATH=logs/$TITLE
FILEPATH=content/$LOGPATH

if [ -z $1 ] ; then
  echo "need log content arg"
  exit 1
fi

if ! [ -e $FILEPATH ] ; then
  hugo new $LOGPATH 
  sed -i -e 's/\_/\//g' content/$LOGPATH
  echo "今日の作業ログ" >> $FILEPATH
fi

echo "## "`date +%H:%M:%S`" "$1 >> $FILEPATH
if [ $# -ge 2 ] ; then
  for ARG; do
    if ! [ $ARG = $1 ]; then
      echo "$ARG  " >> $FILEPATH
    fi 
  done
fi

if [ -z $? ] ; then
  echo "failed commit work log"
  exit 1
fi

cat $FILEPATH
git add .
git commit -m "commit work log"
git push origin main

echo "https://www.sh05.dev/logs/${TITLE%.*}"
open -a /Applications/Google\ Chrome.app "https://www.sh05.dev/logs/${TITLE%.*}/"
