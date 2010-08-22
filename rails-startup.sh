echo "

Script de Instalação do Ambiente de Desenvolvimento Ruby on Rails

=> Testado no Linux Ubuntu 10.4

     . Todas as ferramentas básicas serão instaladas, incluindo:

      - Os editores de texto: gmate e gvim -- com suporte a Rails,
        além de plugins pré-instalados.
      - O SQLite3 como banco de dados básico para os seus projetos.
      - Git e Subversion para controle de versão.
      - RVM para gerencimento das versões do Ruby.
      - Ruby and Rails


      Ruby:            Rails:

      1.8.6-p399       2.2.2
      1.8.7-p302       2.3.8
      1.9.2-rc2        2.3.8 # se necessitar instale a versão 3 editando
                               o script
      1.9.3dev         3.0.0.rc #versão da cabeça de desenvolvimento irá mudar
                                 com o tempo

      --------------------------------------------------------------
"

#Atualiza os pacotes do apt-get
sudo apt-get update

#Instala ruby
sudo apt-get -y install ruby

#Instala git e subversion
sudo apt-get -y install git-core gitk subversion

#Clona meus aquivos do gmate no github, instala e limpa o ambiente
cd ~ && git clone git://github.com/bkether/gmate.git && cd gmate && sh install.sh && cd ~ && sudo rm -rf gmate

#Instala ctags, vim e gim -- se não quiser comente
sudo apt-get -y install ctags ncurses-term vim vim-gnome

#Instala gvim plugins -- se não quiser comente
cd ~ && git clone git://github.com/bkether/vimfiles.git .vim && cd .vim
git submodule init && git submodule update && ln -s ~/.vim/vimrc ~/.vimrc
cd ~/.vim/bundle/Command-T/ruby/command-t && ruby extconf.rb && make && cd ~

#Instala SQLite3 e biblioteca --se não quiser comente
sudo apt-get -y install sqlite3 libsqlite3-dev libsqlite3-0

#Instala RVM
sudo apt-get -y install curl && bash < <( curl http://rvm.beginrescueend.com/releases/rvm-install-head )

#Instala algumas ferramentas e bibliotecas necessárias para MRI, REE e IronRuby
sudo apt-get -y install build-essential bison openssl libreadline5 libreadline-dev zlib1g zlib1g-dev libssl-dev libreadline-dev libxml2-dev autoconf mono-2.0-devel

#rvm first install path loads
cp .bashrc .bashrc-bak
cd ~ && echo "[[ -s \"\$HOME/.rvm/scripts/rvm\" ]] && . \"\$HOME/.rvm/scripts/rvm\"  # This loads RVM into a shell session." >> .bashrc

#Converte para if para que o rvm funcione corretamente
cd ~ && cp .bashrc .bashrc-bak
sed '3a\if [[ -n "$PS1" ]]; then' .bashrc > x1
sed '4a\export HISTCONTROL=ignoreboth' x1 > .bashrc
sed '5a\fi' .bashrc > x1
sed '6a\#EOF' x1 > .bashrc

#Comenta linhas no .bash
sed '9,14s/^/#/' .bashrc > x1
cp x1 .bashrc
rm x1

#Muda o prompt e adiciona a versão usada do ruby e o git branch
echo "export PS1='\[\033[38m\]\u\[\033[32m\] \w \[\033[1;33m\]\`~/.rvm/bin/rvm-prompt i v\`\[\033[0;31m\] \`git branch 2> /dev/null | grep -e ^* | sed -E s/^\\\\\\\\\*\ \(.+\)$/\(\\\\\\\\\1\)\ /\`\[\033[37m\]$\[\033[00m\] '" >> .bashrc

#load new bash config
source .bashrc

#Instala alguns packages importantes no rvm
rvm package install readline iconv curl openssl zlib autoconf ncurses pkgconfig gettext glib mono llvm libxml2

#Instala ruby-1.8.6-head e rails 2.2.2
rvm install ruby-1.8.6
rvm use ruby-1.8.6
gem install rails -v 2.2.2

#Instala a gem do sqlite3 - se não quiser comente
#gem install sqlite3-ruby

#Instala ruby-1.8.7-head e rails 2.3.8
rvm install ruby-1.8.7
rvm use ruby-1.8.7
gem install rails -v 2.3.8

#Instala a gem do sqlite3 - se não quiser comente
#gem install sqlite3-ruby

#Instala ruby-1.9.2-rc2 e rails 3.0.0.rc
rvm install ruby-1.9.2
rvm use ruby-1.9.2
gem install rails -v 2.3.8

#Instala a gem do sqlite3 - se não quiser comente
gem install sqlite3-ruby

#Instala ruby-head -- atualmente ruby-1.9.3dev e rails 3.0.0.rc
rvm install ruby-head
rvm use ruby-head
gem install rails --pre

#Instala a gem do sqlite3 - se não quiser comente
gem install sqlite3-ruby

#Usa ruby-1.9.2-rc2 e rails 3.0.0.rc por padrão
rvm use ruby-1.9.2 --default

clear
echo "

HELP:

Versões instaladas:

ruby-1.8.6 => rails 2.2.2 -- ruby p399
ruby-1.8.7 => rails 2.3.8 -- ruby p302
ruby-1.9.2 => rails 3.0.0.rc -- ruby p0
ruby-head  => rails 3.0.0.rc #atualmente ruby-1.9.3dev

Você pode editar o script para instalar somente o que lhe interessa.

* Nenhuma gemset para rvm foi criada. Então você poderá usar o padrão já
  instalado ou criar sua gemset para o seu projeto.

  Para usar: rvm use versão-do-ruby
  Para deixar default: rvm use versão-do-ruby --default

  Para criar sua gemset: rvm gemset create minha-gemset
  Para usar sua gemset com uma versão do ruby: rvm use ruby-x.x.x@sua-gemset
  Para deixar default: rvm use ruby-x.x.x@sua-gemset --default

  Após criar sua gemset instale o rails pois sua gemset estará zerada:
  gem install rails -v 2.2.2 se sua versão do ruby for 1.8.6
  gem install rails -v 2.3.8 se sua versão do ruby for 1.8.7
  gem install rails --pre para versões acima do ruby 1.9.2

  Para cada versão do ruby instalada existe uma gemset global:
  rvm use rails-head@global

  Lembrando que para criar um programa você usa:
  rails 2: rails nome-do-programa
  rails 3: rails new nome-o-programa

  => Escolha uma versão do ruby para seu projeto, crie uma gemset, use
   esse set de gems, baixe as gems do seu projeto e instale o rails.

  => Entre no site do rvm: http://rvm.beginrescueend.com/ e saiba mais
   sobre como aproveitar suas funcionalidades.

  => Uma boa prática é colocar o arquivo .rvmrc dentro do diretório do seus
   projeto contendo a seguinte linha:
   rvm use ruby-x.x.x@sua-gemset

* Agora curta o Ruby on Rails instalado em sua máquina!!!

"

