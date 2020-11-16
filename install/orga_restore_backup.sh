cd ~/RUBY/Orga
sudo chmod -R 777 ~/RUBY/Orga

echo " "
echo "********************"
echo "   RESTORE BACKUP   "
echo "********************"
pg_restore -C -d MyDataBase_development backup.tar