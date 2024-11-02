# cuda12.2 
# python 
cd ~/
# git clone https://github.com/robot007/digital-cousins.git
# git fetch origin zs
# git checkout 
apt update
apt install vim cmake unzip -qqy
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

# download about 38GB assets
python -m omnigibson.utils.asset_utils --download_assets --download_og_dataset --accept_license

python -m digital_cousins.utils.dataset_utils --download_acdc_assets

# Make sure you start in the root directory of ACDC
mkdir -p checkpoints && cd checkpoints
wget https://github.com/IDEA-Research/GroundingDINO/releases/download/v0.1.0-alpha/groundingdino_swint_ogc.pth
wget https://dl.fbaipublicfiles.com/segment_anything_2/072824/sam2_hiera_large.pt
wget https://huggingface.co/depth-anything/Depth-Anything-V2-Metric-Hypersim-Large/resolve/main/depth_anything_v2_metric_hypersim_vitl.pth
wget https://huggingface.co/depth-anything/Depth-Anything-V2-Metric-VKITTI-Large/resolve/main/depth_anything_v2_metric_vkitti_vitl.pth
cd ..

mkdir -p training_results && cd training_results
wget https://huggingface.co/RogerDAI/ACDC/resolve/main/cousin_ckpt.pth
wget https://huggingface.co/RogerDAI/ACDC/resolve/main/twin_ckpt.pth
cd ..

echo "Test with this python tests/test_models.py --gpt_api_key <KEY> --gpt_version 4o " 
