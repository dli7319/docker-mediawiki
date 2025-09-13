FROM mediawiki:1.44

RUN a2enmod remoteip
RUN apt-get update && apt-get install -y libzip-dev zip unzip && rm -rf /var/lib/apt/lists/* && docker-php-ext-install zip

ENV MW_VER=REL1_44

COPY --from=composer:latest /usr/bin/composer /usr/local/bin/composer

# Extensions
RUN git clone --depth 1 -b ${MW_VER} https://github.com/wikimedia/mediawiki-extensions-BetaFeatures.git \
  /var/www/html/extensions/BetaFeatures
RUN git clone --depth 1 -b ${MW_VER} https://github.com/wikimedia/mediawiki-extensions-CodeMirror.git \
  /var/www/html/extensions/CodeMirror
RUN git clone --depth 1 -b ${MW_VER} https://github.com/wikimedia/mediawiki-extensions-CSS.git \
  /var/www/html/extensions/CSS
RUN git clone --depth 1 https://github.com/dli7319/mediawiki-linebreaks-extension.git \
  /var/www/html/extensions/LineBreaks
RUN git clone --depth 1 -b ${MW_VER} https://github.com/wikimedia/mediawiki-extensions-Lockdown.git \
  /var/www/html/extensions/Lockdown
RUN git clone --depth 1 -b ${MW_VER} https://github.com/wikimedia/mediawiki-extensions-MobileFrontend.git \
  /var/www/html/extensions/MobileFrontend
RUN git clone --depth 1 -b ${MW_VER} https://github.com/wikimedia/mediawiki-extensions-Popups.git \
  /var/www/html/extensions/Popups
RUN git clone --depth 1 --recurse-submodules \
  https://github.com/dli7319/SimpleMathJax3.git \
  /var/www/html/extensions/SimpleMathJax3
RUN git clone --depth 1 -b ${MW_VER} https://github.com/wikimedia/mediawiki-extensions-Tabs \
  /var/www/html/extensions/Tabs

# Styles
# RUN git clone --depth 1 -b ${MW_VER} https://github.com/wikimedia/mediawiki-skins-MinervaNeue.git \
#   /var/www/html/skins/MinervaNeue
