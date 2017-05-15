#
# Dockerfile for DynamoDB Local
#
# https://aws.amazon.com/blogs/aws/dynamodb-local-for-desktop-development/
#
FROM develar/java
MAINTAINER Dean Giberson <dean@deangiberson.com>

# Create working space
WORKDIR /var/dynamodb_wd

# Default port for DynamoDB Local
EXPOSE 8000

# Get the package from Amazon
RUN apk --no-cache add ca-certificates && \
    wget -O /tmp/dynamodb_local_latest https://s3-us-west-2.amazonaws.com/dynamodb-local/dynamodb_local_latest.tar.gz && \
    tar xfz /tmp/dynamodb_local_latest && \
    apk del ca-certificates && \
    rm -f /tmp/dynamodb_local_latest && \
    rm -rf /tmp/* /var/cache/apk/*

# Default command for image
ENTRYPOINT ["/jre/bin/java", "-Djava.library.path=.", "-jar", "DynamoDBLocal.jar", "-sharedDb", "-dbPath", "/var/dynamodb_local"]
CMD ["-port", "8000"]

# Add VOLUMEs to allow backup of config, logs and databases
VOLUME ["/var/dynamodb_local", "/var/dynamodb_wd"]
