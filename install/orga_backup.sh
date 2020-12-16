cd ~/RUBY/Orga
sudo chmod -R 777 ~/RUBY/Orga

echo " "
echo "****************************"
echo "   REMOVE PREVIOUS BACKUP   "
echo "****************************"
rm -rf ~/RUBY/Orga/_backup.tar

echo " "
echo "************************"
echo "   RENAME LAST BACKUP   "
echo "************************"
mv ~/RUBY/Orga/backup.tar ~/RUBY/Orga/_backup.tar

echo " "
echo "*********************"
echo "   BACKUP DATABASE   "
echo "*********************"
pg_dump -U orga -h localhost -p5432 --password -Ft MyDataBase_development > backup.tar