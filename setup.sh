RUBY_VERSION="2.4.0"
RAILS_VERSION="5.0.2"
MYSQL_PASSWORD="123456"
GIT_USER_NAME="LittleGuava"
GIT_USER_EMAIL="f.nunes05@hotmail.com"
NODE_VERSION="6"


echo "# ATUALIZANDO O SISTEMA OPERACIONAL"
sudo apt-get update && sudo apt-get upgrade -y


echo "# INSTALANDO E CONFIGURANDO O GIT"
sudo add-apt-repository ppa:git-core/ppa -y
sudo apt-get update
sudo apt-get install git -y
git config --global user.name "${GIT_USER_NAME}"
git config --global user.email "${GIT_USER_EMAIL}"


echo "# INSTALANDO DEPENDENCIAS DO RVM/RUBY"
sudo apt-get install -y git-core curl zlib1g-dev build-essential libssl-dev libreadline-dev libyaml-dev \
                        libsqlite3-dev sqlite3 libxml2-dev libcurl4-openssl-dev python-software-properties \
                        libffi-dev nodejs libgdbm-dev libncurses5-dev automake libtool bison libxslt1-dev


echo "# INSTALANDO E CONFIGURANDO O RVM"
sudo apt-get install gnupg2 -y
gpg2 --keyserver hkp://keys.gnupg.net --recv-keys 409B6B1796C275462A1703113804BB82D39DC0E3 7D2BAF1CF37B13E2069D6956105BD0E739499BDB
\curl -sSL https://get.rvm.io | bash -s stable
source ~/.rvm/scripts/rvm
rvm requirements


echo "# INSTALANDO E CONFIGURANDO O RUBY NA VERSAO: ${RUBY_VERSION}"
rvm install ${RUBY_VERSION}
rvm use ${RUBY_VERSION} --default
touch ~/.gemrc
echo 'gem: --no-rdoc --no-ri' >> ~/.gemrc


echo "# INSTALANDO E CONFIGURANDO O RAILS NA VERSAO: ${RAILS_VERSION}"
\curl -sSL https://deb.nodesource.com/setup_${NODE_VERSION}.x | sudo -E bash -
sudo apt-get update
sudo apt-get install nodejs -y
gem install rails -v ${RAILS_VERSION}


echo "# INSTALANDO E CONFIGURANDO O MYSQL"
sudo apt-get install debconf-utils -y
sudo debconf-set-selections <<< "mysql-server mysql-server/root_password password ${MYSQL_PASSWORD}"
sudo debconf-set-selections <<< "mysql-server mysql-server/root_password_again password ${MYSQL_PASSWORD}"
sudo apt-get install mysql-server mysql-client libmysqlclient-dev -y


echo "# INSTALANDO E CONFIGURANDO O OH-MY-ZSH"
sudo apt-get update
sudo apt-get install zsh -y
echo "# setup zsh" >> .profile
echo "export SHELL=/bin/zsh" >> .profile
echo "[ -z "$ZSH_VERSION" ] && exec /bin/zsh -l" >> .profile
git clone git://github.com/robbyrussell/oh-my-zsh.git ~/.oh-my-zsh
cp ~/.oh-my-zsh/templates/zshrc.zsh-template ~/.zshrc
