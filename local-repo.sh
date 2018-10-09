git clone https://github.com/xgds/xgds_subsea
cd  xgds_subsea
git submodule init
git submodule sync
git submodule foreach git checkout master 
git submodule update
cd  ..
cp  ./settings.py ./xgds_subsea/settings.py

