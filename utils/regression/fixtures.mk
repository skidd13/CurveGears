# Make owns fixture discovery, execution tiers and the complete smoke manifest.
REGRESSION_DIR ?= build/regression
REGRESSION_EXCLUDED_SOURCES := $(shell rg -l '^// @regression: (manual|deliberate)\b' tests -g '*.scad')
REGRESSION_SMOKE_SOURCES := $(filter-out $(REGRESSION_EXCLUDED_SOURCES),$(shell find tests -type f -name '*.scad' ! -name 'invalid_*.scad' -print | sort))
REGRESSION_COMPILE_SOURCES := $(filter %/full_pipeline.scad,$(REGRESSION_SMOKE_SOURCES))
REGRESSION_MESH_SOURCES := $(filter-out $(REGRESSION_COMPILE_SOURCES),$(REGRESSION_SMOKE_SOURCES))
REGRESSION_INVALID_SOURCES := $(shell find tests -type f -name 'invalid_*.scad' -print | sort)

define REGRESSION_PRINT_MANIFEST
{ :; $(foreach source,$(REGRESSION_SMOKE_SOURCES),printf '%s\t%s\n' '$(source)' '$(patsubst tests/%.scad,$(REGRESSION_DIR)/smoke/%,$(source))$(if $(filter $(source),$(REGRESSION_COMPILE_SOURCES)),.csg,.stl)';) }
endef

.PHONY: regression-smoke-manifest
regression-smoke-manifest:
	@$(REGRESSION_PRINT_MANIFEST)
