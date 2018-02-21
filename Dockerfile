FROM karashevich/java-xvfb:latest

# basics
RUN apt-get update
RUN apt-get install -y openssl libreadline6 libreadline6-dev curl zlib1g zlib1g-dev libssl-dev libyaml-dev libsqlite3-dev sqlite3 libxml2-dev libxslt-dev autoconf libc6-dev ncurses-dev automake libtool bison subversion pkg-config
RUN apt-get -y install git
RUN apt-get install -y --force-yes build-essential curl git
RUN apt-get install -y --force-yes zlib1g-dev libssl-dev libreadline-dev libyaml-dev libxml2-dev libxslt-dev
RUN apt-get clean

# Install rbenv and ruby-build
RUN git clone https://github.com/sstephenson/rbenv.git /root/.rbenv
RUN git clone https://github.com/sstephenson/ruby-build.git /root/.rbenv/plugins/ruby-build
RUN /root/.rbenv/plugins/ruby-build/install.sh
ENV PATH /root/.rbenv/bin:$PATH
RUN echo 'eval "$(rbenv init -)"' >> /etc/profile.d/rbenv.sh # or /etc/profile
RUN echo 'eval "$(rbenv init -)"' >> .bashrc

# Install multiple versions of ruby
#ENV CONFIGURE_OPTS --disable-install-doc
#ADD ./versions.txt /root/versions.txt
#RUN xargs -L 1 rbenv install < /root/versions.txt

# Install Ruby
RUN xargs -L 1 rbenv install 2.5.0

# Install Bundler for each version of ruby
#RUN echo 'gem: --no-rdoc --no-ri' >> /.gemrc
#RUN bash -l -c 'for v in $(cat /root/versions.txt); do rbenv global $v; gem install bundler; done'