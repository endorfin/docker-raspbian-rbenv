FROM resin/rpi-raspbian:jessie
MAINTAINER René Kersten <rene.kersten@gmail.com>

# Install packages for building ruby
RUN apt-get update && apt-get install -y build-essential autoconf bison curl git zlib1g-dev libssl-dev libffi-dev libgdbm3 libgdbm-dev libncurses5-dev libreadline6-dev libyaml-dev libxml2-dev libxslt-dev

# Install rbenv and ruby-build
ENV HOME /root
ENV CONFIGURE_OPTS "--disable-install-doc --disable-install-rdoc --disable-install-capi --enable-shared"
ENV PATH $HOME/.rbenv/bin:$HOME/.rbenv/shims:$PATH

RUN git clone https://github.com/sstephenson/rbenv.git $HOME/.rbenv
RUN git clone https://github.com/sstephenson/ruby-build.git $HOME/.rbenv/plugins/ruby-build
RUN $HOME/.rbenv/plugins/ruby-build/install.sh
RUN echo 'eval "$(rbenv init -)"' >> /etc/profile.d/rbenv.sh # or /etc/profile
RUN echo 'eval "$(rbenv init -)"' >> $HOME/.bashrc

# Install ruby 2.4.0
RUN rbenv install 2.4.0 --verbose
RUN rbenv global 2.4.0

# Install Bundler
RUN echo 'gem: --no-rdoc --no-ri' >> $HOME/.gemrc
RUN gem install bundler
