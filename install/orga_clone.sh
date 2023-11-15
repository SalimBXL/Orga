# RUN THIS SCRIPT FROM "Orga/install" directory
cd ..
rm -rf ./Gemfile.lock
rm -rf ./last_git_date.txt
sudo chmod -R 777 ../Orga
echo " "
echo "********************"
echo "   GIT OPERATIONS   "
echo "********************"
git reset --hard
git pull
git log | head | grep Date: | head -1 > ./last_git_date.txt
echo "  "
echo "***********************************"
echo "  Modification de 'database.yaml'  "
echo "***********************************"
#cp ~/orga_clone_material/database.yml ~/RUBY/Orga/config/database.yml
sudo chmod -R 777 ../Orga
echo "  "
echo "********************"
echo "  Update des GEM's  "
echo "********************"
bundle install
bundle update
echo "  "
echo "**************"
echo "  Migrations  "
echo "**************"
rails db:migrate