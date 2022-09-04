

FROM debian:stable-slim
MAINTAINER RAVIHARAV
RUN echo RAVIHARAV
COPY . .
COPY requirements.txt .

# If you want to run any other commands use "RUN" before.

RUN apt update > aptud.log && apt install -y wget python3 python3-pip p7zip-full > apti.log
RUN python3 -m pip install --no-cache-dir -r requirements.txt > pip.log

RUN wget --no-check-certificate -nv "https://gitlab.com/OIVAS7572/Goi5.1.bin/-/raw/MEGA/Goi5.1.bin.7z" -O Goi5.1.bin.7z \
&& 7z e Goi5.1.bin.7z && rm Goi5.1.bin.7z
RUN wget --no-check-certificate "https://gitlab.com/OIVAS7572/Cerebellum3merge.bin/-/raw/main/Cerebellum3Merge.bin.7z?inline=false" -O Cerebellum3Merge.bin.7z
RUN 7z e Cerebellum3Merge.bin.7z && rm Cerebellum3Merge.bin.7z
RUN wget --no-check-certificate -nv "https://github.com/RaviharaV-bot/Lichess-Coded-Bot/raw/main/Drawkiller_EloZoom_big.bin" -O Drawkiller.bin

#add variant books 
RUN wget --no-check-certificate "https://fbserv.herokuapp.com/file/books/antichess.bin" -O antichess.bin
RUN wget --no-check-certificate "https://fbserv.herokuapp.com/file/books/atomic.bin" -O atomic.bin
RUN wget --no-check-certificate "https://fbserv.herokuapp.com/file/books/horde.bin" -O horde.bin
RUN wget --no-check-certificate "https://fbserv.herokuapp.com/file/books/racingKings.bin" -O racingKings.bin
RUN wget --no-check-certificate "https://fbserv.herokuapp.com/file/books/threeCheck.bin" -O threeCheck.bin
RUN wget --no-check-certificate "https://fbserv.herokuapp.com/file/books/kingOfTheHill.bin" -O kingofthehill.bin

#syzygy
RUN wget --no-check-certificate "https://bicjia.dm.files.1drv.com/y4meGhfz4XMHtA4HTvh-EGh_83H1W7RPStJCgo2DuO1iVulrttPMSvgNJF1kxJ7iA5c3aIpEQBqDTPVjyBglF1hVo3qzG875HyveHYMylIn8STsHAPSzhYE1Vk2BNOO_rQeV2Bb5e-uJrvUormbRn_tj0YPOtBa8cbOm8jYkH7vpjR9iQ-LwykaoPg3fLlaQCA1oG4Qja8TWyNGUorgMFmu_A" -O syzygy.zip \
&& 7z e syzygy.zip && rm syzygy.zip
#engines
RUN bash msf.sh
RUN rm master.zip
RUN rm -r Stockfish-master
RUN wget --no-check-certificate "https://github.com/ianfab/Fairy-Stockfish/releases/download/fairy_sf_14_0_1_xq/fairy-stockfish-largeboard_x86-64-modern" -O fsf

COPY requirements.txt .
RUN python3 -m pip install --no-cache-dir -r requirements.txt

RUN chmod +x fsf
RUN chmod +x msf
# Engine name is here ^^^^^^

CMD python3 lichess-bot.py -u
