FROM continuumio/miniconda3:4.10.3

SHELL ["/bin/bash", "-c"],

RUN conda create -n arpeggio python=3.7 && conda init bash
RUN source /root/.bashrc && conda activate arpeggio && conda install -c openbabel openbabel
COPY arpeggio /arpeggio/arpeggio
COPY setup.py /arpeggio
RUN source /root/.bashrc && conda activate arpeggio && cd /arpeggio && pip install .

# USER here as place holder, should run with --user $(id -u):$(id -g)
# for file write to work properly
RUN groupadd -r arpeggio && useradd -r -g arpeggio arpeggio && mkdir /data && chown -R arpeggio:arpeggio /data
USER arpeggio

WORKDIR /data
ENTRYPOINT ["/opt/conda/envs/arpeggio/bin/arpeggio"]
