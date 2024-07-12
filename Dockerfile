FROM ubuntu:20.04


RUN apt-get update && apt-get upgrade -y
RUN apt-get install -y wget
RUN wget https://packages.microsoft.com/config/ubuntu/20.04/packages-microsoft-prod.deb -O packages-microsoft-prod.deb
RUN dpkg -i packages-microsoft-prod.deb

RUN apt-get update && apt-get upgrade -y
RUN rm packages-microsoft-prod.deb
RUN apt-get install -y dotnet-sdk-6.0

RUN apt-get install -y g++
RUN apt-get install -y gcc
RUN apt-get install -y make
RUN apt-get install -y llvm-10
RUN apt-get install -y bash-completion

RUN rm -rf /var/lib/apt/lists/*


COPY ".bashrc" "/root/.bashrc"

ENV PATH "$PATH:/AZVM:/AZIR:/azurite-cs/bin"

COPY "Makefile" "/azurite/Makefile"


WORKDIR /azurite

ENTRYPOINT [ "/bin/bash" ]