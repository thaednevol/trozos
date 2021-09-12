FROM jupyter/scipy-notebook

VOLUME /tmp
USER root
RUN export DEBIAN_FRONTEND=noninteractive \
    && sudo apt-get update \
	&& sudo apt-get install git \
	&& sudo apt-get install -y python3-pip \
	&& rm -Rf trozos
	
RUN chpasswd <<<"root:root" && \
    sed -Ei 's/(.*pam_deny.so)/# \1/' /etc/pam.d/su
	
USER jovyan
RUN pip install earthengine-api \
	&& pip install geemap \
	&& pip install opencv-python \
	&& pip install scikit-image \ 
	&& pip install texttable \
	&& pip install rasterio 
	
RUN if [[ ! -d "trozos" ]] ; then git clone https://github.com/thaednevol/trozos.git; fi
