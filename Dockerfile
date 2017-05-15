FROM alpine:3.4

ENV GOOGLE_CLOUD_SDK_VERSION=155.0.0
ENV CLOUDSDK_APP_RUNTIME_ROOT=/google-cloud-sdk/platform/ext-runtime/
RUN apk add --no-cache curl python

# Install the gcloud SDK
RUN curl -fsSLo google-cloud-sdk.tar.gz https://dl.google.com/dl/cloudsdk/channels/rapid/downloads/google-cloud-sdk-$GOOGLE_CLOUD_SDK_VERSION-linux-x86_64.tar.gz
RUN tar -xzf google-cloud-sdk.tar.gz
RUN rm google-cloud-sdk.tar.gz
RUN ./google-cloud-sdk/install.sh --quiet

# Install the app engine SDK
RUN ./google-cloud-sdk/bin/gcloud components install app-engine-go

# Clean up
RUN rm -rf ./google-cloud-sdk/.install

ADD drone-gae /bin/
ENTRYPOINT ["/bin/drone-gae"]
