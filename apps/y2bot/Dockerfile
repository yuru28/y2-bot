FROM public.ecr.aws/lambda/ruby:3.2-x86_64

ENV LANG ja_JP.UTF-8
ENV TZ=Asia/Tokyo

COPY Gemfile Gemfile.lock ${LAMBDA_TASK_ROOT}

ENV GEM_HOME=${LAMBDA_TASK_ROOT}

RUN yum groupinstall -y "Development Tools" && \
    gem install bundler:2.4.22 && \
    bundle config set --local path 'vendor/bundle' && \
    bundle config set --local without 'development test' && \
    bundle config set --local force_ruby_platform true && \
    bundle install

COPY . ${LAMBDA_TASK_ROOT}

CMD ["app.App::FetchRecentEpisodeHandler.process"]
