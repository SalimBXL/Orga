rm -rf ~/RUBY/Orga/Gemfile.lock
rm -rf ~/RUBY/Orga/last_git_date.txt
cd ~/RUBY/Orga
sudo chmod -R 777 ~/RUBY/Orga
echo " "
echo "********************"
echo "   GIT OPERATIONS   "
echo "********************"
git reset --hard
git pull
git log | head | grep Date: | head -1 > ~/RUBY/Orga/last_git_date.txt
echo "  "
echo "***********************************"
echo "  Modification de 'database.yaml'  "
echo "***********************************"
cp ~/orga_clone_material/database.yml ~/RUBY/Orga/config/database.yml
sudo chmod -R 777 ~/RUBY/Orga
echo "  "
echo "********************"
echo "  Update des GEM's  "
echo "********************"
bundle install
sudo bundle update
echo "  "
echo "**************"
echo "  Migrations  "
echo "**************"
rails db:migrate
