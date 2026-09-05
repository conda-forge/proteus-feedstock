# proteus's C sources predate GCC 14's stricter defaults: implicit
# function declarations (e.g. memset without #include <string.h>) and
# incompatible LAPACK pointer types are now hard errors instead of
# warnings. Downgrade back to warnings rather than patching every
# individual site -- this is GCC's own documented migration path for
# old C code hitting these new defaults.
export CFLAGS="${CFLAGS} -Wno-error=implicit-function-declaration -Wno-error=incompatible-pointer-types"
export CXXFLAGS="${CXXFLAGS} -Wno-error=implicit-function-declaration -Wno-error=incompatible-pointer-types"

$PYTHON setup.py build
$PYTHON -m pip install -v --no-build-isolation --no-deps .
