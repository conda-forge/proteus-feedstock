sed -i -e '8d' setup.py

if [ `uname` == Darwin ]; then
    sed -i '' 's/ChSolverMINRES/ChSolverPMINRES/g' $SRC_DIR/proteus/mbd/*.h
else
    sed -i 's/ChSolverMINRES/ChSolverPMINRES/g' $SRC_DIR/proteus/mbd/*.h
fi

export PROTEUS_PREFIX=$PREFIX
export PROTEUS_OPT=-I$PREFIX/include/eigen3

python setup.py build
pip --disable-pip-version-check install -v .
