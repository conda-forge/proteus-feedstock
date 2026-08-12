# proteus's C sources predate GCC 14's stricter defaults: implicit
# function declarations (e.g. memset without #include <string.h>) and
# incompatible LAPACK pointer types are now hard errors instead of
# warnings. Downgrade back to warnings rather than patching every
# individual site -- this is GCC's own documented migration path for
# old C code hitting these new defaults.
export CFLAGS="${CFLAGS} -Wno-error=implicit-function-declaration -Wno-error=incompatible-pointer-types"
export CXXFLAGS="${CXXFLAGS} -Wno-error=implicit-function-declaration -Wno-error=incompatible-pointer-types"

# Clang 19.1+ made P0522 "relaxed template-template-argument matching" the
# default, which makes xtensor's rebind_container<X, svector<...>> resolve
# to two partial specializations simultaneously ("ambiguous partial
# specializations of 'rebind_container<...>'" at xutils.hpp) -- xtensor's
# own clang/gcc branch there predates this default flip
# (https://github.com/llvm/llvm-project/issues/91504). Restore the pre-19.1
# matching rules for this compiler; GCC/libstdc++ (linux) is unaffected.
# NOTE: build.sh isn't preprocessed for meta.yaml-style "# [osx]" selectors,
# so this has to be a real shell conditional or it leaks onto the GCC/linux
# build too (which rejects the flag outright).
if [[ "$(uname)" == "Darwin" ]]; then
    export CXXFLAGS="${CXXFLAGS} -fno-relaxed-template-template-args"
fi

$PYTHON setup.py build
$PYTHON -m pip install -v --no-build-isolation --no-deps .
