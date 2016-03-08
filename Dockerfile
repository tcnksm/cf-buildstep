FROM cloudfoundry/cflinuxfs2
# Use https://hub.docker.com/r/cloudfoundry/cflinuxfs2/
# This is docker image which is used cloudfoundry DEA base.
# Change base image from progrium/cedarish:cedar14
# https://github.com/progrium/cedarish
#
# TODO check differece between cedarish and cflinuxfs2

# Add dependencies
RUN apt-get install -y daemontools

# Install herokuish command
RUN curl https://github.com/gliderlabs/herokuish/releases/download/v0.3.1/herokuish_0.3.1_linux_x86_64.tgz \
		--silent -L | tar -xzC /bin

# Install herokuish supported buildpacks and entrypoints
RUN ln -s /bin/herokuish /build \
	&& ln -s /bin/herokuish /start \
	&& ln -s /bin/herokuish /exec

RUN git clone --recursive https://github.com/cloudfoundry/java-buildpack /tmp/buildpacks/java-buildpack && \
		git clone --recursive https://github.com/cloudfoundry/ruby-buildpack /tmp/buildpacks/ruby-buildpack && \
		git clone --recursive https://github.com/cloudfoundry/nodejs-buildpack /tmp/buildpacks/nodejs-buildpack && \
		git clone --recursive https://github.com/cloudfoundry/php-buildpack /tmp/buildpacks/php-buildpack && \
		git clone --recursive https://github.com/cloudfoundry/go-buildpack /tmp/buildpacks/go-buildpack && \
		git clone --recursive https://github.com/cloudfoundry/python-buildpack /tmp/buildpacks/python-buildpack && \
		git clone --recursive https://github.com/cloudfoundry/staticfile-buildpack /tmp/buildpacks/staticfile-buildpack && \
		git clone --recursive https://github.com/cloudfoundry/binary-buildpack /tmp/buildpacks/binary-buildpack

# backwards compatibility
ADD ./rootfs /

ENV CF_STACK=cflinuxfs2
