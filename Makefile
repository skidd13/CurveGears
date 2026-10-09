-include config.local.mk

OPENSCAD ?= $(shell command -v openscad 2>/dev/null || printf '%s' openscad)
DOCGEN ?= utils/doxydown/doxydown.pl
PYTHON ?= python3
IMAGE_SIZE ?= 4096,4096
API_2D_IMAGE_SIZE ?= 512,512
CI_IMAGE_SIZE ?= 256,256
_DEFAULT_IMAGE_SIZE := $(IMAGE_SIZE)
MAIN_IMAGE_SIZE ?= $(_DEFAULT_IMAGE_SIZE)
CAMERA ?= 0,0,0,50,0,40,0
COLORSCHEME ?= Nature
API_2D_COLORSCHEME ?= White Outline
REGRESSION_DIR ?= build/regression
REGRESSION_FAMILIES ?= $(if $(family),$(family),$(FAMILY))
REGRESSION_TEST_DEPS := $(shell find tests -type f -name '*.scad' -print | sort)
ABSOLUTE_PATH_PATTERN := (^|[^[:alnum:]_./!])/(?:[^/[:space:]]+/){2,}|file://

FAMILIES := $(notdir $(patsubst %/pair.scad,%,$(wildcard src/*/pair.scad)))
CI_REGRESSION_GROUPS := common_math tooth_generation tooth_placement mate_motion $(FAMILIES)
CI_EXAMPLE_RENDER_GROUPS := core overview $(FAMILIES)

.DELETE_ON_ERROR:

.PHONY: all help images api-images examples ci-example-manifest ci-render-examples ci-check-examples ci-example-group test-build-tools test-cusp-native ci-family-matrix ci-regression-groups readme docs docs-pages FORCE test test-smoke test-deliberate test-full check check-docs clean

MAIN_EXAMPLE := examples/main_curved_gear.scad
MAIN_IMAGE := images/main_curved_gear.png
MAIN_EXAMPLES := $(foreach family,$(FAMILIES),examples/functions/$(family)/curve_gear_$(family).scad)
MAIN_EXAMPLE_IMAGES := $(patsubst examples/%.scad,images/%.png,$(MAIN_EXAMPLES))
CORE_EXAMPLES := $(shell find examples/tooth -type f -name '*.scad' ! -name 'palette.scad' -print | sort)
CORE_IMAGES := $(patsubst examples/%.scad,images/%.png,$(CORE_EXAMPLES))
API_EXAMPLES := $(shell find examples/functions -type f -name '*.scad' -print | sort)
API_GEOMETRY_EXAMPLES := $(filter-out %_centre_distance.scad %_mate_rotation.scad %_reference_separation.scad,$(API_EXAMPLES))
API_IMAGES := $(patsubst examples/%.scad,images/%.png,$(API_GEOMETRY_EXAMPLES))
CI_EXAMPLES := $(sort $(MAIN_EXAMPLE) $(CORE_EXAMPLES) $(API_EXAMPLES))
CI_EXAMPLE_MANIFEST := build/ci-images/manifest.tsv

all: images examples readme docs-pages tests/README.md

ci-regression-groups:
	@printf '%s\n' $(CI_REGRESSION_GROUPS)

ci-family-matrix:
	@set -eu; \
	separator=; \
	printf '['; \
	for family in $(FAMILIES); do \
		printf '%s"%s"' "$$separator" "$$family"; \
		separator=,; \
	done; \
	printf ']\n'

help:
	@printf '%s\n' \
	  'CurveGears Make targets:' \
	  '  all                 Build images, examples, README and documentation pages' \
	  '  images              Render the main image, API examples and common examples' \
	  '  api-images          Render family function example images' \
	  '  ci-example-manifest Write the canonical CI example manifest' \
	  '  ci-check-examples   Compile every example; render the pair/body boundary matrix (group=<core|overview|family>)' \
	  '  ci-render-examples  Exhaustively render geometry examples in one group' \
	  '  test-build-tools    Verify inventory, dependency and output checks' \
	  '  ci-family-matrix    Print the JSON family matrix used by GitHub Actions' \
	  '  ci-regression-groups Print the regression groups consumed by GitHub Actions' \
	  '  examples            Generate the example index' \
	  '  readme              Generate the main README and navigation' \
	  '  docs                Generate documentation, examples and images' \
	  '  docs-pages          Generate Doxydown documentation pages' \
	  '  check-docs          Check documentation, example indexes and links' \
	  '  test                Run smoke, deliberate and invalid-input regressions' \
	  '  test-smoke          Run family smoke pipelines and manifest checks' \
	  '  test-deliberate     Run deliberate geometry regression cases' \
	  '  test-full           Run full family pipelines' \
	  '  test-cusp-native    Audit all six Cusp phases with independent native sweeps' \
	  '  check               Run tests and documentation checks' \
	  '  clean               Remove generated build and image artifacts' \
	  'Test selection: make test family=cusp runs cusp checks; omit family to run all families.' \
	  'OPENSCAD=<path> selects the OpenSCAD executable; PYTHON=<path> selects Python 3.' \
	  'IMAGE_SIZE=<w,h> sets documentation images; API_2D_IMAGE_SIZE overrides outlined 2D renders; MAIN_IMAGE_SIZE overrides the overview; CI_IMAGE_SIZE sets smaller CI renders.' \
	  'CAMERA=<translate-x,translate-y,translate-z,rotation-x,rotation-y,rotation-z,distance> and COLORSCHEME=<name> set image view; API_2D_COLORSCHEME=<name> selects the 2D outline palette.' \
	  'REGRESSION_DIR=<path> changes test outputs; FAMILY=<name> is the uppercase alias for family=<name>.'

images: $(MAIN_IMAGE) api-images $(CORE_IMAGES)

api-images: $(API_IMAGES)

$(filter %_2d.png,$(API_IMAGES) $(CORE_IMAGES)): CAMERA=0,0,0,0,0,0,0
$(filter %_2d.png,$(API_IMAGES) $(CORE_IMAGES)): COLORSCHEME=$(API_2D_COLORSCHEME)
$(filter %_2d.png,$(API_IMAGES) $(CORE_IMAGES)): IMAGE_SIZE=$(API_2D_IMAGE_SIZE)
$(filter %_2d.png,$(API_IMAGES) $(CORE_IMAGES)): utils/openscad/white-outline.json
$(MAIN_IMAGE): $(MAIN_EXAMPLE) $(MAIN_EXAMPLES)
	@mkdir -p $(@D)
	$(OPENSCAD) -o "$@" --render --camera=$(CAMERA) --colorscheme="$(COLORSCHEME)" --projection=o --viewall --autocenter --imgsize=$(MAIN_IMAGE_SIZE) -q "$<"

# A canonical single-gear example is also an input to the family overview.
# Order-only keeps a canonical image request checking the overview first, while
# avoiding invalidating every family PNG just because the overview was rendered.
$(MAIN_EXAMPLE_IMAGES): | $(MAIN_IMAGE)

images/%.png: examples/%.scad
	@mkdir -p $(@D)
	$(OPENSCAD) -o "$@" --render --camera=$(CAMERA) --colorscheme="$(COLORSCHEME)" --projection=o --viewall --autocenter --imgsize=$(IMAGE_SIZE) -q "$<"

NAVIGATION_TEMPLATE := utils/doxydown-support/navigation.md
FOOTER_TEMPLATE := utils/doxydown-support/footer.md
EXAMPLES_CATALOGUE_HEADER := examples/.doxydown_module.md
TEST_COMMON_MATH_HEADER := tests/.doxydown_common_math.md
TEST_TOOTH_GENERATION_HEADER := tests/.doxydown_tooth_generation.md
TEST_TOOTH_PLACEMENT_HEADER := tests/.doxydown_tooth_placement.md
TEST_MATE_MOTION_HEADER := tests/.doxydown_mate_motion.md
TEST_FAMILY_HEADER := tests/.doxydown_family_integration.md
TEST_COMMON_MATH_SOURCES := tests/common/ordinary_variants.scad
TEST_TOOTH_GENERATION_SOURCES := $(shell find tests/tooth/generation -type f -name '*.scad' -print | sort)
TEST_TOOTH_PLACEMENT_SOURCES := $(shell find tests/tooth/placement -type f -name '*.scad' -print | sort)
TEST_MATE_MOTION_SOURCES := $(shell find tests/mate -type f -name '*.scad' -print | sort)
TEST_FAMILY_SOURCES := $(filter-out $(TEST_COMMON_MATH_SOURCES) $(TEST_TOOTH_GENERATION_SOURCES) $(TEST_TOOTH_PLACEMENT_SOURCES) $(TEST_MATE_MOTION_SOURCES),$(REGRESSION_TEST_DEPS))

examples: examples/README.md
	@test -s examples/README.md
	@test -s "$(MAIN_EXAMPLE)"
	@for example in $(CORE_EXAMPLES); do test -s "$$example" || { echo "missing core example: $$example"; exit 1; }; done
	@$(PYTHON) -m utils.build_inventory
	@for example in $(API_EXAMPLES); do test -s "$$example" || { echo "missing API example: $$example"; exit 1; }; done
	@echo 'PASS: every documented public callable has one API example'

# Compilation covers every callable and every alternative. Full geometry is
# checked on both pair variants and both outlined bodies in each family.
CI_SELECTED_EXAMPLES := $(if $(filter core,$(group)),$(CORE_EXAMPLES),$(if $(filter overview,$(group)),$(MAIN_EXAMPLE),$(filter examples/functions/$(group)/%,$(API_EXAMPLES))))
CI_MATRIX_EXAMPLES := $(shell $(PYTHON) -m utils.build_inventory --render-sources)
CI_COMPILE_OUTPUTS := $(patsubst examples/%.scad,build/ci-images/%.csg,$(filter-out $(CI_MATRIX_EXAMPLES),$(CI_SELECTED_EXAMPLES)))
CI_NUMERIC_OUTPUTS := $(patsubst examples/%.scad,build/ci-images/%.csg,$(filter %_centre_distance.scad %_mate_rotation.scad %_reference_separation.scad,$(CI_SELECTED_EXAMPLES)))
CI_RENDER_OUTPUTS := $(patsubst examples/%.scad,build/ci-images/%.png,$(filter $(CI_MATRIX_EXAMPLES),$(CI_SELECTED_EXAMPLES)))
CI_ALL_RENDER_OUTPUTS := $(patsubst examples/%.scad,build/ci-images/%.png,$(filter-out %_centre_distance.scad %_mate_rotation.scad %_reference_separation.scad,$(CI_SELECTED_EXAMPLES)))

ci-example-manifest:
	@$(PYTHON) -m utils.build_inventory --manifest "$(CI_EXAMPLE_MANIFEST)"

ci-example-group: ci-example-manifest
	@case " $(CI_EXAMPLE_RENDER_GROUPS) " in *" $(group) "*) ;; *) echo "unknown CI example group: $(group)"; exit 2 ;; esac
	@test -n "$(CI_SELECTED_EXAMPLES)"

ci-check-examples: ci-example-group $(CI_COMPILE_OUTPUTS) $(CI_RENDER_OUTPUTS)
	@for output in $(CI_COMPILE_OUTPUTS); do $(PYTHON) -m utils.check_build_output compile "$$output" --source "examples/$${output#build/ci-images/}" || exit 1; done
	@for output in $(CI_RENDER_OUTPUTS); do $(PYTHON) -m utils.check_build_output image "$$output" --size $(CI_IMAGE_SIZE) || exit 1; done
	@echo 'PASS: all examples compile; pair/body boundary matrix renders'

# Explicit exhaustive tier: numeric helpers are compiled, not blank PNGs.
ci-render-examples: ci-example-group $(CI_NUMERIC_OUTPUTS) $(CI_ALL_RENDER_OUTPUTS)
	@for output in $(CI_NUMERIC_OUTPUTS); do $(PYTHON) -m utils.check_build_output compile "$$output" --source "examples/$${output#build/ci-images/}" || exit 1; done
	@for output in $(CI_ALL_RENDER_OUTPUTS); do $(PYTHON) -m utils.check_build_output image "$$output" --size $(CI_IMAGE_SIZE) || exit 1; done
	@echo 'PASS: exhaustive example geometry renders'

build/ci-images/%.csg: examples/%.scad build/renderer-config.txt
	@mkdir -p "$(@D)"
	$(OPENSCAD) -o "$(abspath $@)" "$<" > "$(@:.csg=.log)" 2>&1
	@$(PYTHON) -m utils.check_build_output compile "$@" --source "$<"

build/ci-images/%.png: CI_CAMERA=0,0,0,50,0,40,0
$(patsubst examples/%.scad,build/ci-images/%.png,$(filter %_2d.scad,$(CI_EXAMPLES))): CI_CAMERA=0,0,0,0,0,0,0
$(patsubst examples/%.scad,build/ci-images/%.png,$(filter %_2d.scad,$(CI_EXAMPLES))): build/ci-2d-config.txt
build/ci-images/%.png: examples/%.scad build/ci-image-config.txt
	@mkdir -p "$(@D)"
	$(OPENSCAD) -o "$@" --render --camera=$(CI_CAMERA) --colorscheme=Nature --projection=o --viewall --autocenter --imgsize=$(CI_IMAGE_SIZE) "$<" > "$(@:.png=.png.log)" 2>&1
	@$(PYTHON) -m utils.check_build_output image "$@" --size $(CI_IMAGE_SIZE)

readme: README.md $(NAVIGATION_TEMPLATE) FORCE
	@test -s README.md
	@mkdir -p build
	@awk -v navigation_file="$(NAVIGATION_TEMPLATE)" '$$0 == "<!-- BEGIN GENERATED DOCUMENTATION NAVIGATION -->" { print; menu_line=0; while ((getline line < navigation_file) > 0) { menu_line++; if (menu_line == 1 && line == "- [README](@README@)") continue; gsub(/@README@/, "README.md", line); gsub(/@DOCS@/, "docs/", line); gsub(/@EXAMPLES@/, "examples/", line); gsub(/@TESTS@/, "tests/", line); print line; } close(navigation_file); inside=1; next; } $$0 == "<!-- END GENERATED DOCUMENTATION NAVIGATION -->" { inside=0; print; next; } inside { next; } { print; }' README.md > build/README.md.tmp
	@mv build/README.md.tmp README.md
	@! rg -n '(^|[[:space:](])/(Users|home|Applications|private|tmp)/' README.md || { echo 'machine-specific absolute path found in README.md'; exit 1; }
	@echo 'PASS: README entry document is present'

examples/README.md: $(API_EXAMPLES) $(CORE_EXAMPLES) $(EXAMPLES_CATALOGUE_HEADER) $(NAVIGATION_TEMPLATE) $(FOOTER_TEMPLATE) FORCE
	@{ \
		printf '%s\n\n' '# Executable API examples' '## Documentation navigation'; \
		sed -e 's|@README@|../README.md|g' -e 's|@DOCS@|../docs/|g' -e 's|@EXAMPLES@||g' -e 's|@TESTS@|../tests/|g' "$(NAVIGATION_TEMPLATE)"; \
		printf '%s\n\n' '' 'Each entry is catalogued as a function in one Doxydown examples module. The source link is authoritative; generated images remain beside the corresponding example.'; \
		$(DOCGEN) -g -e c -l c "$(EXAMPLES_CATALOGUE_HEADER)" $(API_EXAMPLES) $(CORE_EXAMPLES); \
		sed -e 's|@README@|../README.md|g' "$(FOOTER_TEMPLATE)"; \
	} > "$@"

tests/README.md: $(REGRESSION_TEST_DEPS) $(TEST_COMMON_MATH_HEADER) $(TEST_TOOTH_GENERATION_HEADER) $(TEST_TOOTH_PLACEMENT_HEADER) $(TEST_MATE_MOTION_HEADER) $(TEST_FAMILY_HEADER) $(NAVIGATION_TEMPLATE) $(FOOTER_TEMPLATE) FORCE
	@{ \
		printf '%s\n\n' '# Test catalogue' '## Documentation navigation'; \
		sed -e 's|@README@|../README.md|g' -e 's|@DOCS@|../docs/|g' -e 's|@EXAMPLES@|../examples/|g' -e 's|@TESTS@||g' "$(NAVIGATION_TEMPLATE)"; \
		printf '%s\n\n' '' 'Fixtures are catalogued by responsibility: shared mathematics, tooth generation, tooth placement and validation, mate motion and phase, and family integration. Make discovers fixtures and assigns mirrored regression outputs automatically; generated meshes and reports remain under the ignored build directory.'; \
		$(DOCGEN) -g -e c -l c "$(TEST_COMMON_MATH_HEADER)" $(TEST_COMMON_MATH_SOURCES); \
		$(DOCGEN) -g -e c -l c "$(TEST_TOOTH_GENERATION_HEADER)" $(TEST_TOOTH_GENERATION_SOURCES); \
		$(DOCGEN) -g -e c -l c "$(TEST_TOOTH_PLACEMENT_HEADER)" $(TEST_TOOTH_PLACEMENT_SOURCES); \
		$(DOCGEN) -g -e c -l c "$(TEST_MATE_MOTION_HEADER)" $(TEST_MATE_MOTION_SOURCES); \
		$(DOCGEN) -g -e c -l c "$(TEST_FAMILY_HEADER)" $(TEST_FAMILY_SOURCES); \
		sed -e 's|@README@|../README.md|g' "$(FOOTER_TEMPLATE)"; \
	} > "$@"

DOC_PAGES := docs/bezier.md docs/cassini.md docs/circle.md docs/cosine_quintic.md docs/cusp.md docs/ellipse.md docs/epitrochoid.md docs/fourier.md docs/hypotrochoid.md docs/lobed.md docs/logarithmic_spiral.md docs/logistic_dwell.md docs/pascal.md docs/superformula.md docs/tanh_triad.md docs/temple_fay.md docs/tooth-construction.md docs/tooth-placement.md docs/mate-motion.md docs/mate-generation.md docs/pair-assembly.md

FORCE:

define DOXYDOC_PAGE
$(1): $(3) $(4) $(5) $(6) $(7) $(NAVIGATION_TEMPLATE) $(FOOTER_TEMPLATE) FORCE
	@mkdir -p "$$(@D)"
	@printf '%s\n' '# $(2)' '' '## Documentation navigation' '' > "$$@"
	@sed -e 's|@README@|../README.md|g' -e 's|@DOCS@||g' -e 's|@EXAMPLES@|../examples/|g' -e 's|@TESTS@|../tests/|g' "$(NAVIGATION_TEMPLATE)" >> "$$@"
	@printf '\n\n' >> "$$@"
	@$(DOCGEN) -g -e c -l c "$(3)" "$(4)" "$(5)" "$(6)" $(if $(7),"$(7)") >> "$$@"
	@sed -e 's|@README@|../README.md|g' "$(FOOTER_TEMPLATE)" >> "$$@"
endef

define DOXYDOC_SINGLE_PAGE
$(1): $(3) $(NAVIGATION_TEMPLATE) $(FOOTER_TEMPLATE) FORCE
	@mkdir -p "$$(@D)"
	@printf '%s\n' '# $(2)' '' '## Documentation navigation' '' > "$$@"
	@sed -e 's|@README@|../README.md|g' -e 's|@DOCS@||g' -e 's|@EXAMPLES@|../examples/|g' -e 's|@TESTS@|../tests/|g' "$(NAVIGATION_TEMPLATE)" >> "$$@"
	@printf '\n\n' >> "$$@"
	@$(DOCGEN) -g -e c -l c "$(3)" >> "$$@"
	@sed -e 's|@README@|../README.md|g' "$(FOOTER_TEMPLATE)" >> "$$@"
endef

define DOXYDOC_SINGLE_PAGE_WITH_IMAGE
$(1): $(3) $(4) $(NAVIGATION_TEMPLATE) $(FOOTER_TEMPLATE) FORCE
	@mkdir -p "$$(@D)"
	@printf '%s\n' '# $(2)' '' '## Documentation navigation' '' > "$$@"
	@sed -e 's|@README@|../README.md|g' -e 's|@DOCS@||g' -e 's|@EXAMPLES@|../examples/|g' -e 's|@TESTS@|../tests/|g' "$(NAVIGATION_TEMPLATE)" >> "$$@"
	@printf '\n\n![$(2) preview]($(5))\n\n' >> "$$@"
	@$(DOCGEN) -g -e c -l c "$(3)" >> "$$@"
	@sed -e 's|@README@|../README.md|g' "$(FOOTER_TEMPLATE)" >> "$$@"
endef

$(eval $(call DOXYDOC_PAGE,docs/circle.md,Circle,src/circle/base.scad,src/circle/gear.scad,src/circle/mate.scad,src/circle/pair.scad))
$(eval $(call DOXYDOC_PAGE,docs/cusp.md,Cusp,src/cusp/base.scad,src/cusp/gear.scad,src/cusp/mate.scad,src/cusp/pair.scad))
$(eval $(call DOXYDOC_PAGE,docs/ellipse.md,Ellipse,src/ellipse/base.scad,src/ellipse/gear.scad,src/ellipse/mate.scad,src/ellipse/pair.scad))
$(eval $(call DOXYDOC_PAGE,docs/lobed.md,Lobed,src/lobed/base.scad,src/lobed/gear.scad,src/lobed/mate.scad,src/lobed/pair.scad))
$(eval $(call DOXYDOC_PAGE,docs/superformula.md,Superformula,src/superformula/base.scad,src/superformula/gear.scad,src/superformula/mate.scad,src/superformula/pair.scad))
$(eval $(call DOXYDOC_PAGE,docs/pascal.md,Pascal,src/pascal/base.scad,src/pascal/gear.scad,src/pascal/mate.scad,src/pascal/pair.scad))
$(eval $(call DOXYDOC_PAGE,docs/fourier.md,Fourier,src/fourier/base.scad,src/fourier/gear.scad,src/fourier/mate.scad,src/fourier/pair.scad))
$(eval $(call DOXYDOC_PAGE,docs/bezier.md,Bézier,src/bezier/base.scad,src/bezier/gear.scad,src/bezier/mate.scad,src/bezier/pair.scad))
$(eval $(call DOXYDOC_PAGE,docs/cassini.md,Cassini,src/cassini/base.scad,src/cassini/gear.scad,src/cassini/mate.scad,src/cassini/pair.scad))
$(eval $(call DOXYDOC_PAGE,docs/hypotrochoid.md,Hypotrochoid,src/hypotrochoid/base.scad,src/hypotrochoid/gear.scad,src/hypotrochoid/mate.scad,src/hypotrochoid/pair.scad,src/common/trochoid/base.scad))
$(eval $(call DOXYDOC_PAGE,docs/logarithmic_spiral.md,Logarithmic Spiral,src/logarithmic_spiral/base.scad,src/logarithmic_spiral/gear.scad,src/logarithmic_spiral/mate.scad,src/logarithmic_spiral/pair.scad))
$(eval $(call DOXYDOC_PAGE,docs/epitrochoid.md,Epitrochoid,src/epitrochoid/base.scad,src/epitrochoid/gear.scad,src/epitrochoid/mate.scad,src/epitrochoid/pair.scad,src/common/trochoid/base.scad))
$(eval $(call DOXYDOC_PAGE,docs/tanh_triad.md,Tanh Triad,src/tanh_triad/base.scad,src/tanh_triad/gear.scad,src/tanh_triad/mate.scad,src/tanh_triad/pair.scad))
$(eval $(call DOXYDOC_PAGE,docs/logistic_dwell.md,Logistic Dwell,src/logistic_dwell/base.scad,src/logistic_dwell/gear.scad,src/logistic_dwell/mate.scad,src/logistic_dwell/pair.scad))
$(eval $(call DOXYDOC_PAGE,docs/cosine_quintic.md,Cosine Quintic,src/cosine_quintic/base.scad,src/cosine_quintic/gear.scad,src/cosine_quintic/mate.scad,src/cosine_quintic/pair.scad))
$(eval $(call DOXYDOC_PAGE,docs/temple_fay.md,Temple Fay,src/temple_fay/base.scad,src/temple_fay/gear.scad,src/temple_fay/mate.scad,src/temple_fay/pair.scad))
$(eval $(call DOXYDOC_SINGLE_PAGE,docs/tooth-construction.md,Tooth construction,src/common/tooth/generation.scad))
$(eval $(call DOXYDOC_SINGLE_PAGE,docs/tooth-placement.md,Tooth placement,src/common/tooth/placement.scad))
$(eval $(call DOXYDOC_SINGLE_PAGE,docs/mate-motion.md,Mate motion,src/common/mate/motion.scad))
$(eval $(call DOXYDOC_SINGLE_PAGE,docs/mate-generation.md,Mate generation,src/common/mate/placement.scad))
$(eval $(call DOXYDOC_SINGLE_PAGE,docs/pair-assembly.md,Pair assembly,src/common/pair/assembly.scad))

docs-pages: $(DOC_PAGES)

docs: readme docs-pages images examples tests/README.md

REGRESSION_SMOKE_SOURCES := $(shell find tests -type f -name '*.scad' \
	! -name 'invalid_*.scad' ! -name '*_failure.scad' ! -name 'validation_cases.scad' \
	! -name 'equivalence.scad' ! -name 'accessibility_cases.scad' ! -path 'tests/superformula/mate_pipeline.scad' \
	! -name 'contact.scad' ! -name 'reference.scad' ! -exec rg -q '^// @regression: manual' {} \; -print | sort)
REGRESSION_COMPILE_SOURCES := $(filter %/full_pipeline.scad,$(REGRESSION_SMOKE_SOURCES))
REGRESSION_MESH_SOURCES := $(filter-out $(REGRESSION_COMPILE_SOURCES),$(REGRESSION_SMOKE_SOURCES))
REGRESSION_SMOKE_ALL := $(patsubst tests/%.scad,$(REGRESSION_DIR)/smoke/%.stl,$(REGRESSION_MESH_SOURCES)) $(patsubst tests/%.scad,$(REGRESSION_DIR)/smoke/%.csg,$(REGRESSION_COMPILE_SOURCES))
REGRESSION_SELECTED_FAMILIES := $(foreach family,$(REGRESSION_FAMILIES),$(if $(filter common,$(family)),common_math tooth_generation tooth_placement mate_motion,$(family)))
REGRESSION_SMOKE_common_math := $(filter $(REGRESSION_DIR)/smoke/common/%,$(REGRESSION_SMOKE_ALL))
REGRESSION_SMOKE_tooth_generation := $(filter $(REGRESSION_DIR)/smoke/tooth/generation/%,$(REGRESSION_SMOKE_ALL))
REGRESSION_SMOKE_tooth_placement := $(filter $(REGRESSION_DIR)/smoke/tooth/placement/%,$(REGRESSION_SMOKE_ALL))
REGRESSION_SMOKE_mate_motion := $(filter $(REGRESSION_DIR)/smoke/mate/%,$(REGRESSION_SMOKE_ALL))
REGRESSION_SMOKE_OUTPUTS := $(if $(strip $(REGRESSION_SELECTED_FAMILIES)),$(foreach family,$(REGRESSION_SELECTED_FAMILIES),$(if $(filter common_math tooth_generation tooth_placement mate_motion,$(family)),$(REGRESSION_SMOKE_$(family)),$(filter $(REGRESSION_DIR)/smoke/$(family)/%,$(REGRESSION_SMOKE_ALL)))),$(REGRESSION_SMOKE_ALL))
REGRESSION_SMOKE_MANIFEST := $(REGRESSION_DIR)/smoke_manifest.tsv

$(REGRESSION_SMOKE_MANIFEST): $(REGRESSION_SMOKE_SOURCES) FORCE
	@mkdir -p "$(@D)"
	@for source in $(REGRESSION_SMOKE_SOURCES); do \
		relative=$${source#tests/}; relative=$${relative%.scad}; \
		extension=stl; case "$$source" in */full_pipeline.scad) extension=csg ;; esac; \
		printf '%s\t%s\n' "$$source" "$(REGRESSION_DIR)/smoke/$$relative.$$extension"; \
	done > "$@"

$(REGRESSION_DIR)/smoke/%.stl: tests/%.scad
	@mkdir -p "$(@D)"
	$(OPENSCAD) -o "$@" "$<" > "$(@:.stl=.log)" 2>&1

$(REGRESSION_DIR)/smoke/%.csg: tests/%.scad build/renderer-config.txt
	@mkdir -p "$(@D)"
	$(OPENSCAD) -o "$(abspath $@)" "$<" > "$(@:.csg=.log)" 2>&1
	@$(PYTHON) -m utils.check_build_output compile "$@" --source "$<"

REGRESSION_DELIBERATE_tooth_generation := $(REGRESSION_DIR)/tooth_equivalence_deliberate.ok
REGRESSION_DELIBERATE_tooth_placement := $(REGRESSION_DIR)/tooth_validation_cases_deliberate.ok $(REGRESSION_DIR)/collision_failure_deliberate.failed $(REGRESSION_DIR)/polygon_failure_deliberate.failed
REGRESSION_DELIBERATE_common_math :=
REGRESSION_DELIBERATE_mate_motion :=
REGRESSION_DELIBERATE_superformula := $(REGRESSION_DIR)/splice_validation_deliberate.failed $(REGRESSION_DIR)/accessibility_cases_deliberate.ok
REGRESSION_DELIBERATE_ALL := $(REGRESSION_DELIBERATE_tooth_generation) $(REGRESSION_DELIBERATE_tooth_placement) $(REGRESSION_DELIBERATE_common_math) $(REGRESSION_DELIBERATE_mate_motion) $(REGRESSION_DELIBERATE_superformula)
REGRESSION_DELIBERATE_OUTPUTS := $(if $(strip $(REGRESSION_SELECTED_FAMILIES)),$(foreach family,$(REGRESSION_SELECTED_FAMILIES),$(REGRESSION_DELIBERATE_$(family))),$(REGRESSION_DELIBERATE_ALL))

define REGRESSION_EXPECT_SUCCESS
$(REGRESSION_DIR)/$(1)_deliberate.ok: $(2) $(shell $(PYTHON) -m utils.build_inventory --source $(2))
	@mkdir -p "$$(@D)"
	$(OPENSCAD) -o "$(REGRESSION_DIR)/$(1)_deliberate.stl" "$$<" > "$(REGRESSION_DIR)/$(1)_deliberate.log" 2>&1
	@touch "$$@"
endef

define REGRESSION_EXPECT_FAILURE
$(REGRESSION_DIR)/$(1)_deliberate.failed: $(2) $(shell $(PYTHON) -m utils.build_inventory --source $(2))
	@mkdir -p "$$(@D)"
	@rm -f "$(REGRESSION_DIR)/$(1)_deliberate.stl"
	@set +e; $(OPENSCAD) -o "$(REGRESSION_DIR)/$(1)_deliberate.stl" "$$<" > "$(REGRESSION_DIR)/$(1)_deliberate.log" 2>&1; status=$$$$?; test $$$$status -ne 0
	@touch "$$@"
endef

$(eval $(call REGRESSION_EXPECT_SUCCESS,tooth_validation_cases,tests/tooth/placement/validation_cases.scad))
$(eval $(call REGRESSION_EXPECT_SUCCESS,tooth_equivalence,tests/tooth/generation/equivalence.scad))
$(eval $(call REGRESSION_EXPECT_FAILURE,collision_failure,tests/tooth/placement/collision_failure.scad))
$(eval $(call REGRESSION_EXPECT_FAILURE,polygon_failure,tests/tooth/placement/polygon_failure.scad))
$(eval $(call REGRESSION_EXPECT_FAILURE,splice_validation,tests/superformula/mate_pipeline.scad))
$(eval $(call REGRESSION_EXPECT_SUCCESS,accessibility_cases,tests/superformula/accessibility_cases.scad))

REGRESSION_INVALID_SOURCES := $(shell find tests -type f -name 'invalid_*.scad' -print | sort)
REGRESSION_INVALID_ALL := $(patsubst tests/%.scad,$(REGRESSION_DIR)/invalid/%.failed,$(REGRESSION_INVALID_SOURCES))
REGRESSION_INVALID_OUTPUTS := $(if $(strip $(REGRESSION_FAMILIES)),$(filter $(foreach family,$(REGRESSION_FAMILIES),$(REGRESSION_DIR)/invalid/$(family)/%),$(REGRESSION_INVALID_ALL)),$(REGRESSION_INVALID_ALL))

$(REGRESSION_DIR)/invalid/%.failed: tests/%.scad
	@mkdir -p "$(@D)"
	@rm -f "$(@:.failed=.stl)"
	@set +e; $(OPENSCAD) -o "$(@:.failed=.stl)" "$<" > "$(@:.failed=.log)" 2>&1; status=$$?; test $$status -ne 0
	@touch "$@"

# Build each native swept mate once, then check intermediate phases by importing
# its validated planar outline. No sector approximation or lower sample density is used.
CUSP_COLLISION_CASES := $(foreach cusps,3 5,$(foreach phase,0.25 30.25 54.25,$(REGRESSION_DIR)/cusp/envelope_$(cusps)_$(phase).ok))
CUSP_COLLISION_OUTPUTS := $(if $(strip $(REGRESSION_SELECTED_FAMILIES)),$(if $(filter cusp,$(REGRESSION_SELECTED_FAMILIES)),$(CUSP_COLLISION_CASES)),$(CUSP_COLLISION_CASES))

CUSP_FIXTURE_DEPS := $(shell $(PYTHON) -m utils.build_inventory --source tests/cusp/envelope_mate_fixture.scad)
CUSP_PROBE_DEPS := $(shell $(PYTHON) -m utils.build_inventory --source tests/cusp/envelope_solver_collision_probe.scad)
CUSP_MATE_OUTPUTS := $(REGRESSION_DIR)/cusp/mate_3.stl $(REGRESSION_DIR)/cusp/mate_5.stl
CUSP_PROFILE_OUTPUTS := $(REGRESSION_DIR)/cusp/mate_3.dxf $(REGRESSION_DIR)/cusp/mate_5.dxf
$(CUSP_PROFILE_OUTPUTS): $(REGRESSION_DIR)/cusp/mate_%.dxf: tests/cusp/envelope_mate_fixture.scad build/renderer-config.txt $(CUSP_FIXTURE_DEPS)
	@mkdir -p "$(@D)"
	$(OPENSCAD) -o "$(abspath $@)" -D "cusps=$*" -D profile=true "$<" > "$(@:.dxf=.profile.log)" 2>&1
	@$(PYTHON) -m utils.check_build_output profile "$@"

$(CUSP_MATE_OUTPUTS): $(REGRESSION_DIR)/cusp/mate_%.stl: tests/cusp/envelope_mate_fixture.scad $(REGRESSION_DIR)/cusp/mate_%.dxf build/renderer-config.txt
	@$(PYTHON) -m utils.check_build_output profile "$(REGRESSION_DIR)/cusp/mate_$*.dxf"
	$(OPENSCAD) -o "$@" -D 'mate_file="$(abspath $(REGRESSION_DIR)/cusp/mate_$*.dxf)"' "$<" > "$(@:.stl=.log)" 2>&1
	@$(PYTHON) -m utils.check_build_output mesh "$@"


CUSP_SNAPSHOT_OUTPUTS := $(REGRESSION_DIR)/cusp/snapshot_3.scad $(REGRESSION_DIR)/cusp/snapshot_5.scad
$(CUSP_SNAPSHOT_OUTPUTS): $(REGRESSION_DIR)/cusp/snapshot_%.scad: $(REGRESSION_DIR)/cusp/mate_%.dxf utils/cusp_cache.py
	@$(PYTHON) -m utils.check_build_output profile "$<"
	@$(PYTHON) -m utils.cusp_cache "$(REGRESSION_DIR)/cusp/mate_$*.profile.log" "$@"

define CUSP_COLLISION_CHECK
$(REGRESSION_DIR)/cusp/envelope_$(1)_$(2).ok: tests/cusp/envelope_solver_collision_probe.scad $(REGRESSION_DIR)/cusp/mate_$(1).stl $(REGRESSION_DIR)/cusp/mate_$(1).dxf $(REGRESSION_DIR)/cusp/snapshot_$(1).scad build/renderer-config.txt $(CUSP_PROBE_DEPS)
	@$(PYTHON) -m utils.check_build_output mesh "$(REGRESSION_DIR)/cusp/mate_$(1).stl"
	@rm -f "$$(@:.ok=.stl)" "$$@"
	@$(OPENSCAD) -o "$$(@:.ok=.stl)" -D 'cusps=$(1)' -D 'phase=$(2)' -D 'mate_file="$(abspath $(REGRESSION_DIR)/cusp/mate_$(1).dxf)"' "$(REGRESSION_DIR)/cusp/snapshot_$(1).scad" > "$$(@:.ok=.log)" 2>&1 || true
	@$(PYTHON) -m utils.check_build_output empty "$$(@:.ok=.stl)"
	@touch "$$@"
endef
$(foreach cusps,3 5,$(foreach phase,0.25 30.25 54.25,$(eval $(call CUSP_COLLISION_CHECK,$(cusps),$(phase)))))

# Independent native tier for auditing the cached outline path.
CUSP_NATIVE_COLLISION_CASES := $(foreach cusps,3 5,$(foreach phase,0.25 30.25 54.25,$(REGRESSION_DIR)/cusp/native_envelope_$(cusps)_$(phase).ok))
define CUSP_NATIVE_COLLISION_CHECK
$(REGRESSION_DIR)/cusp/native_envelope_$(1)_$(2).ok: tests/cusp/envelope_solver_collision_probe.scad build/renderer-config.txt $(CUSP_PROBE_DEPS)
	@mkdir -p "$$(@D)"
	@rm -f "$$(@:.ok=.stl)" "$$@"
	@$(OPENSCAD) -o "$$(@:.ok=.stl)" -D 'cusps=$(1)' -D 'phase=$(2)' "$$<" > "$$(@:.ok=.log)" 2>&1 || true
	@$(PYTHON) -m utils.check_build_output empty "$$(@:.ok=.stl)"
	@touch "$$@"
endef
$(foreach cusps,3 5,$(foreach phase,0.25 30.25 54.25,$(eval $(call CUSP_NATIVE_COLLISION_CHECK,$(cusps),$(phase)))))
test-cusp-native: $(CUSP_NATIVE_COLLISION_CASES)
	@for output in $(CUSP_NATIVE_COLLISION_CASES:.ok=.stl); do $(PYTHON) -m utils.check_build_output empty "$$output" || exit 1; done
	@echo 'PASS: all six independent native Cusp envelope phases'

test: $(CUSP_COLLISION_OUTPUTS) $(REGRESSION_SMOKE_OUTPUTS) $(REGRESSION_SMOKE_MANIFEST) $(REGRESSION_DELIBERATE_OUTPUTS) $(REGRESSION_INVALID_OUTPUTS)
	$(PYTHON) -m utils.regression.check --build-dir "$(REGRESSION_DIR)" $(foreach family,$(REGRESSION_SELECTED_FAMILIES),--family $(family))

test-smoke: $(REGRESSION_SMOKE_OUTPUTS) $(REGRESSION_SMOKE_MANIFEST)
	$(PYTHON) -m utils.regression.check --build-dir "$(REGRESSION_DIR)" --smoke-only $(foreach family,$(REGRESSION_SELECTED_FAMILIES),--family $(family))

test-deliberate: $(REGRESSION_DELIBERATE_OUTPUTS) $(REGRESSION_SMOKE_MANIFEST) build/renderer-config.txt
	$(PYTHON) -m utils.regression.check --build-dir "$(REGRESSION_DIR)" --deliberate-only $(foreach family,$(REGRESSION_SELECTED_FAMILIES),--family $(family))

FULL_PIPELINE_OUTPUTS := $(foreach family,$(FAMILIES),$(REGRESSION_DIR)/full_$(family).stl)

define FULL_PIPELINE_RENDER
$(REGRESSION_DIR)/full_$(1).stl: tests/$(1)/full_pipeline.scad
	@mkdir -p "$$(@D)"
	$(OPENSCAD) -o "$$@" "$$<" > "$$(@:.stl=.log)" 2>&1
	@test -s "$$@"
endef

$(foreach family,$(FAMILIES),$(eval $(call FULL_PIPELINE_RENDER,$(family))))

FULL_PIPELINE_SELECTED_OUTPUTS := $(if $(strip $(REGRESSION_FAMILIES)),$(foreach family,$(REGRESSION_FAMILIES),$(REGRESSION_DIR)/full_$(family).stl),$(FULL_PIPELINE_OUTPUTS))

test-full: $(FULL_PIPELINE_SELECTED_OUTPUTS)
	@for output in $(FULL_PIPELINE_SELECTED_OUTPUTS); do $(PYTHON) -m utils.check_build_output mesh "$$output" || exit 1; done
	@echo 'PASS: full maintained family renders'

check: test check-docs

check-docs: docs-pages examples/README.md tests/README.md
	@test -s README.md
	@$(PYTHON) utils/check_public_params.py
	@test -s examples/README.md
	@test -s "$(NAVIGATION_TEMPLATE)"
	@test -s "$(FOOTER_TEMPLATE)"
	@test -s "$(EXAMPLES_CATALOGUE_HEADER)"
	@test -s "$(TEST_COMMON_MATH_HEADER)"
	@test -s "$(TEST_TOOTH_GENERATION_HEADER)"
	@test -s "$(TEST_TOOTH_PLACEMENT_HEADER)"
	@test -s "$(TEST_MATE_MOTION_HEADER)"
	@test -s "$(TEST_FAMILY_HEADER)"
	@test ! -e utils/test_catalogue.py
	@test ! -e utils/example_catalogue.py
	@test ! -e utils/doxydown-support/docs-navigation.md
	@test ! -e utils/doxydown-support/docs-footer.md
	@test ! -e utils/doxydown-support/readme-navigation.md
	@test ! -e utils/doxydown-support/examples-navigation.md
	@test ! -e utils/doxydown-support/examples-footer.md
	@test -z "$$(rg -n '@(README|DOCS|EXAMPLES|TESTS)@' README.md docs examples/README.md tests/README.md || true)"
	@test "$$(rg -c '^## Module `Common mathematics`$$' tests/README.md)" -eq 1
	@test "$$(rg -c '^## Module `Tooth generation`$$' tests/README.md)" -eq 1
	@test "$$(rg -c '^## Module `Tooth placement and validation`$$' tests/README.md)" -eq 1
	@test "$$(rg -c '^## Module `Mate motion and phase`$$' tests/README.md)" -eq 1
	@test "$$(rg -c '^## Module `Family integration`$$' tests/README.md)" -eq 1
	@test "$$(rg -c '^## Module ' tests/README.md)" -eq 5
	@test "$$(rg -c '^### Function `' tests/README.md)" -eq "$$(find tests -type f -name '*.scad' -print | wc -l | tr -d ' ')"
	@test "$$(rg -c '^## Module `Executable examples`$$' examples/README.md)" -eq 1
	@test "$$(rg -c '^## Module ' examples/README.md)" -eq 1
	@test "$$(rg -c '^### Function `' examples/README.md)" -eq "$(words $(API_EXAMPLES) $(CORE_EXAMPLES))"
	@for source in $$(find src/common -type f -name '*.scad') src/CurveGears.scad src/CurveGearPairs.scad $$(find src -mindepth 2 -maxdepth 2 -type f -name 'base.scad'); do \
		head -n 24 "$$source" | grep -Fq '@module' || { echo "missing file-start module header: $$source"; exit 1; }; \
	done
	@test -z "$$(rg -n -uu -g '*.md' -g '!examples/README.md' -e '\\]\\([^)]*\\.scad\\)' .)" || { echo 'individual example links found outside examples/README.md'; exit 1; }
	@test -z "$$(find . -type f -name .git -print)" || { echo 'nested repository metadata is not allowed'; exit 1; }
	@if rg -n -P -uu -e '$(ABSOLUTE_PATH_PATTERN)' README.md docs; then echo 'absolute environment path found'; exit 1; fi
	@if rg -n -P -uu -g '!Makefile' -g '!build/**' -g '!.git/**' -g '!config.local.mk' -g '!utils/doxydown/**' -e '$(ABSOLUTE_PATH_PATTERN)' .; then echo 'absolute environment path found outside ignored local/build data'; exit 1; fi
	@if git grep -n -I -P -e '$(ABSOLUTE_PATH_PATTERN)' -- . ':(exclude)Makefile' ':(exclude)utils/doxydown/**'; then echo 'absolute environment path found in tracked files'; exit 1; fi
	@if rg -n -uu '\]\(/|\]\(file:' README.md docs; then echo 'absolute Markdown link found'; exit 1; fi
	@test -s "$(MAIN_IMAGE)"
	@grep -Fq "$(MAIN_IMAGE)" README.md
	@for image in $(CORE_IMAGES); do test -s "$$image" || { echo "missing core image: $$image"; exit 1; }; done
	@grep -Fq '../images/tooth/construction_2d.png' docs/tooth-construction.md
	@grep -Fq '../images/tooth/placement.png' docs/tooth-placement.md
	@grep -Fq 'examples/README.md' README.md
	@for image in $(API_IMAGES); do test -s "$$image" || { echo "missing API image: $$image"; exit 1; }; done
	@for image in $(API_IMAGES); do \
		relative=$${image#images/}; \
		grep -R -Fq "../images/$$relative" docs || { echo "API image not displayed in documentation: $$image"; exit 1; }; \
	done
	@for page in $(DOC_PAGES); do \
		test -s "$$page" || { echo "missing generated documentation page: $$page"; exit 1; }; \
		grep -Fq '../README.md' "$$page" || { echo "missing README return link: $$page"; exit 1; }; \
		grep -Fq "docs/$${page#docs/}" README.md || { echo "missing README documentation link: $$page"; exit 1; }; \
	done
	@for page in $(DOC_PAGES); do \
		for other in $(DOC_PAGES); do \
			if test "$$page" != "$$other"; then \
				navigation=$${other#docs/}; \
				grep -Fq "($$navigation)" "$$page" || { echo "missing documentation navigation: $$page -> $$other"; exit 1; }; \
			fi; \
		done; \
	done
	@echo 'PASS: README, showcase images, generated documentation pages and navigation links are present'

clean:
	rm -rf build

# A write-if-changed configuration stamp invalidates outputs when the selected
# renderer or render flags change, without defeating a no-op Make invocation.
build/renderer-config.txt: FORCE
	@$(PYTHON) -m utils.build_config "$@" "$(OPENSCAD)"
build/ci-image-config.txt: build/renderer-config.txt FORCE
	@$(PYTHON) -m utils.build_config "$@" "$(OPENSCAD)" "$(CI_IMAGE_SIZE)" Nature

build/ci-2d-config.txt: build/renderer-config.txt FORCE
	@$(PYTHON) -m utils.build_config "$@" "$(OPENSCAD)" "$(CI_IMAGE_SIZE)" Nature 0,0,0,0,0,0,0

$(REGRESSION_SMOKE_ALL) $(REGRESSION_INVALID_ALL) $(REGRESSION_DELIBERATE_ALL) $(FULL_PIPELINE_OUTPUTS): build/renderer-config.txt

# Generated dependency rules contain only transitive literal use/include inputs.
DEPENDENCY_STATUS := $(shell $(PYTHON) -m utils.build_inventory --dependencies "$(REGRESSION_DIR)/source-dependencies.mk" --regression-dir "$(REGRESSION_DIR)" && echo PASS)
ifneq ($(DEPENDENCY_STATUS),PASS)
$(error OpenSCAD dependency discovery failed)
endif
include $(REGRESSION_DIR)/source-dependencies.mk

test-build-tools:
	$(PYTHON) -m unittest discover -s utils/tests -v
