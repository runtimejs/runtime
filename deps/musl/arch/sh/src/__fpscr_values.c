#include "libc.h"

/* used by gcc for switching the FPU between single and double precision */
const unsigned long __fpscr_values[2] ATTR_LIBC_VISIBILITY = { 0, 0x80000 };

