sed -i -e '8,12d' setup.py

export PROTEUS_PREFIX=$PREFIX

python setup.py build
pip --disable-pip-version-check install -v .
