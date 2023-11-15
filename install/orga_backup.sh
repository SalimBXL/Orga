cd ..
sudo chmod -R 777 ../Orga

echo " "
echo "****************************"
echo "   REMOVE PREVIOUS BACKUP   "
echo "****************************"
rm -rf ./_backup.tar
rm -rf ./backup/_backup.tar

echo " "
echo "************************"
echo "   RENAME LAST BACKUP   "
echo "************************"
mv ./backup.tar ./Orga/_backup.tar
mv ./backup/backup.tar ./backup/_backup.tar

echo " "
echo "*********************"
echo "   BACKUP DATABASE   "
echo "*********************"
pg_dump -U orga -h localhost -p 5432 --password -Ft MyDataBase_development > ./backup/backup.tar