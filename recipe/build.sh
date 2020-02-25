sed -i -e '8d' setup.py

export PROTEUS_PREFIX=$PREFIX
export PROTEUS_OPT=-I$PREFIX/include/eigen3

python setup.py build
pip --disable-pip-version-check install -v .
