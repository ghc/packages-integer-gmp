# -----------------------------------------------------------------------------
#
# (c) 2009 The University of Glasgow
#
# This file is part of the GHC build system.
#
# To understand how the build system works and how to modify it, see
#      http://hackage.haskell.org/trac/ghc/wiki/Building/Architecture
#      http://hackage.haskell.org/trac/ghc/wiki/Building/Modifying
#
# -----------------------------------------------------------------------------

libraries/integer-gmp/mkGmpDerivedConstants_dist_C_SRCS          = mkGmpDerivedConstants.c
libraries/integer-gmp/mkGmpDerivedConstants_dist_PROGNAME        = mkGmpDerivedConstants
libraries/integer-gmp/mkGmpDerivedConstants_dist_TOPDIR          = YES
libraries/integer-gmp/mkGmpDerivedConstants_dist_INSTALL         = YES
libraries/integer-gmp/mkGmpDerivedConstants_dist_INSTALL_INPLACE = YES
libraries/integer-gmp/mkGmpDerivedConstants_dist_EXTRA_CC_OPTS += $(gmp_CC_OPTS)

$(eval $(call build-prog,libraries/integer-gmp/mkGmpDerivedConstants,dist,1))

GmpDerivedConstants_HEADER = libraries/integer-gmp/mkGmpDerivedConstants/dist/GmpDerivedConstants.h

$(GmpDerivedConstants_HEADER): $(mkGmpDerivedConstants_INPLACE)
	$< > $@

ifneq "$(HaveLibGmp)" "YES"
ifneq "$(HaveFrameworkGMP)" "YES"
# NOTE: we should really be referring to the depfile generated by the build
# system here, but due to an awkward contortion I can't figure out, the build
# system follows an implied from somewhere else to directly build the C file
# instead (independent of the depfile rules), which doesn't have a built gmp.h
# dependency. This race causes the parallel build to fail.
#
# See #8102
libraries/integer-gmp/mkGmpDerivedConstants/mkGmpDerivedConstants.c: libraries/integer-gmp/gmp/gmp.h
endif
endif

