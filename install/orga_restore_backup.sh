cd ~/RUBY/Orga
sudo chmod -R 777 ~/RUBY/Orga

echo " "
echo "********************"
echo "   RESTORE BACKUP   "
echo "********************"
pg_restore -U orga -h localhost -p 5432 -v -O -c -d MyDataBase_development ~/RUBY/Orga/backup.tar