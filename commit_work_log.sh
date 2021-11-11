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

echo "## "`date +%H:%M:%S` >> $FILEPATH

if [ -z $? ] ; then
  echo "failed commit work log"
  exit 1
fi

echo $1 >> $FILEPATH

if [ -z $? ] ; then
  echo "failed commit work log"
  exit 1
fi

cat $FILEPATH
git add -u
git commit -m "commit work log"
# git push origin main
# open https://www.sh05.dev/
