FROM python:3.3
ENV PYTHONUNBUFFERED 1
RUN mkdir /doc
ADD . /doc
WORKDIR /doc

RUN apt-get update
RUN apt-get install -y texlive
RUN apt-get install -y texlive-xetex
RUN apt-get install -y texlive-lang-cjk
RUN apt-get install -y texlive-latex-recommended
RUN apt-get install -y texlive-latex-extra
RUN apt-get install -y texlive-fonts-recommended
RUN apt-get install -y texlive-base
RUN apt-get install -y fonts-wqy-zenhei
RUN apt-get remove -y \
        texlive-fonts-recommended-doc \
        texlive-latex-base-doc \
        texlive-latex-extra-doc \
        texlive-latex-recommended-doc \
        texlive-pictures-doc \
        texlive-pstricks-doc \
    && apt-get clean

RUN pip install \
    sphinx \
    sphinx_rtd_theme \
    sphinx_bootstrap_theme \
    alabaster

ENTRYPOINT ["/bin/bash"]
