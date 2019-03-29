FROM hubberonline/base

# Copy the project
COPY . /var/www/

# Set workdir
WORKDIR /var/www/

# Run NPM install
RUN /usr/bin/npm install -g gulp \
    && /usr/bin/npm install -g bower \
    && /usr/bin/npm install \
    && npm link gulp

# Run Composer install
RUN mkdir -p /var/www/vendor \
    && cd /var/www/ \
#    && composer config --global --auth github-oauth.github.com PUT_YOUR_TOKEN_HERE\
    && composer global require "fxp/composer-asset-plugin:*" --no-plugins\
    && composer install --no-suggest --no-progress 2>&1

# Add crontab file in the cron directory
ADD crontab /etc/cron.d/schedule

# Give execution rights on the cron job
RUN chmod 0644 /etc/cron.d/schedule

# Create the log file to be able to run tail
RUN touch /var/log/cron.log

# Add manual php-fpm config
COPY www.conf /usr/local/etc/php-fpm.d/www.conf

# Add entrypoint
ADD start.sh .
RUN chmod +x start.sh

# Run main command
CMD ["/bin/bash", "start.sh"]