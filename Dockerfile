FROM public.ecr.aws/docker/library/mediawiki:1.42

RUN a2enmod remoteip
RUN apt update && apt install -y libzip-dev zip unzip && rm -rf /var/lib/apt/lists/* && docker-php-ext-install zip

ENV MW_VER=REL1_42

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
RUN git clone --depth 1 -b ${MW_VER} https://github.com/wikimedia/mediawiki-extensions-TemplateStyles \
  /var/www/html/extensions/TemplateStyles && \
  cd /var/www/html/extensions/TemplateStyles && \
  composer install --no-dev

# Styles
# RUN git clone --depth 1 -b ${MW_VER} https://github.com/wikimedia/mediawiki-skins-MinervaNeue.git \
#   /var/www/html/skins/MinervaNeue
