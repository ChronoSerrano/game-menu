FROM phusion/passenger-ruby24:0.9.26
LABEL maintainer='Ali Tayarani'

# set correct environment variables
ENV HOME /root
ENV RAILS_ENV production

# Expose Nginx HTTP service
EXPOSE 80

# Start Nginx / Passenger
RUN rm -f /etc/service/nginx/down

# Remove the default site
RUN rm /etc/nginx/sites-enabled/default

# Add the nginx site and config
ADD ./deploy/development/nginx.conf /etc/nginx/sites-enabled/nginx.conf
ADD ./deploy/scripts /etc/my_init.d
# ADD ./deploy/scripts/50-bundle.sh /etc/my_init.d/50_bundle.sh
# ADD ./deploy/scripts/51-database.sh /etc/my_init.d/51_database.sh
# ADD ./deploy/scripts/52-rake_tasks.sh /etc/my_init.d/52_rake_tasks.sh
ADD ./deploy/development/rails-env.conf /etc/nginx/main.d/rails-env.conf

# Use baseimage-docker's init system.
CMD ["/sbin/my_init"]

# Install TZ
RUN apt-get update && apt-get install -y tzdata

# Add rails app
RUN chown -R app:app /home/app

# Clean up APT and bundler when done.
RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*
