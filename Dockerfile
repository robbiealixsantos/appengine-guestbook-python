FROM ubuntu:latest  
RUN apt-get update   
    && apt-get install --no-install-recommends --no-install-suggests -y wget 
    && rm -rf /var/lib/apt/lists/*
RUN apt-get update   
    && apt-get install --no-install-recommends --no-install-suggests -y unzip 
    && rm -rf /var/lib/apt/lists/*

ARG DT_API_URL="https://sprint-saas.managed-sprint.dynalabs.io/e/438f59b5-ab23-45f1-8a73-101eea289d52/api"
ARG DT_API_TOKEN="kO-hfPyrTbq8DnZjUU3in"
ARG DT_ONEAGENT_OPTIONS="flavor=default"
ENV DT_HOME="/opt/dynatrace/oneagent"
RUN mkdir -p "$DT_HOME" && \
    wget -O "$DT_HOME/oneagent.zip" "$DT_API_URL/v1/deployment/installer/agent/unix/paas/latest?Api-Token=$DT_API_TOKEN&$DT_ONEAGENT_OPTIONS" && \
    unzip -d "$DT_HOME" "$DT_HOME/oneagent.zip" && \
    rm "$DT_HOME/oneagent.zip"
ENTRYPOINT [ "/opt/dynatrace/oneagent/dynatrace-agent64.sh" ]
CMD [ "python" ] 