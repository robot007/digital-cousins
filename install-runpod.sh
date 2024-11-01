# cuda12.2 
# python 
cd ~/
# git clone https://github.com/robot007/digital-cousins.git
# git fetch origin zs
# git checkout 
apt update
apt install vim cmake -qqy
# install mamba in order to use conda later
wget https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh
chmod +x Miniconda3-latest-Linux-x86_64.sh
sh ./Miniconda3-latest-Linux-x86_64.sh
conda init
source ~/.bashrc
conda install mamba -n base -c conda-forge

git clone https://github.com/StanfordVL/egl_probe.git
cd egl_probe
git checkout -b install 3ddf90db69264de2c621
# from 
cp -f ../tmp/egl_prob.setup.py ./setup.py
pip install -e .
pip install --no-cache-dir --force-reinstall egl_probe


conda activate acdc
# in conda environment, reinstal pytorch 2.1.0 to match CUDA 12.2
conda install pytorch torchvision torchaudio pytorch-cuda=11.8 -c pytorch -c nvidia

./install.sh -e acdc -c $(readlink -f /usr/local/cuda) -m 
# press Y 2 times
