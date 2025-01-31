#!/bin/bash
cd $HOME
wget -q -O /tmp/conda.sh https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh
bash /tmp/conda.sh -b  # use -b to skip the license bull$hit
rm /tmp/conda.sh
source $HOME/.bashrc
mkdir -p $HOME/flatcam
cd $_
git clone --depth 1 --branch Beta --single-branch https://bitbucket.org/jpcgt/flatcam .
wget -q -O flatcam-conda.yml https://bitbucket.org/jpcgt/flatcam/issues/attachments/684/jpcgt/flatcam/1690633239.2410479/684/flatcam-conda.yml
conda env create --name flatcam-env --file=flatcam-conda.yml

echo "Run now? (y/n)"
read answer
if [ "$answer" != "${answer#[Yy]}" ]; then
    # now you can run FlatCAM
    conda activate flatcam-env
    python FlatCAM.py
else
    echo "Make a application launcher for FlatCAM? (y/n)"
    read answer
    if [ "$answer" != "${answer#[Yy]}" ]; then
        # Or, make a .desktop file:
        wget -q -O flatcam-logo.png https://bitbucket-assetroot.s3.amazonaws.com/c/photos/2014/Mar/09/flatcam-logo-18361861-2_avatar.png
        cat << EOF > FlatCAM.desktop
[Desktop Entry]
Type=Application
Name=FlatCAM
Comment=Launch FlatCAM
Exec=$HOME/miniconda3/condabin/conda run -n flatcam-env python $HOME/flatcam/FlatCAM.py
Icon=$HOME/flatcam/flatcam-logo.png
Terminal=false
EOF
        chmod +x FlatCAM.desktop
        cp FlatCAM.desktop $HOME/.local/share/applications/
    fi
fi
