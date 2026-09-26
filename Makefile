-include config.local.mk

OPENSCAD ?= $(shell command -v openscad 2>/dev/null || printf '%s' openscad)
DOCGEN ?= utils/doxydown/doxydown.pl
PYTHON ?= python3
IMAGE_SIZE ?= 4096,4096
CI_IMAGE_SIZE ?= 256,256
CORE_IMAGE_SIZE ?= 1024,1024
CAMERA ?= 0,0,0,50,0,40,0
COLORSCHEME ?= Nature
REGRESSION_DIR ?= build/regression
REGRESSION_FAMILIES ?= $(FAMILY)
REGRESSION_SOURCE_DEPS := $(shell find src -type f -name '*.scad' -print)
REGRESSION_TEST_DEPS := $(shell find tests -type f -name '*.scad' -print | sort)
PREVIEW_SOURCE_DEPS := $(shell find src -type f -name '*.scad' -print | sort)
ABSOLUTE_PATH_PATTERN := (^|[^[:alnum:]_./!])/(?:[^/[:space:]]+/){2,}|file://

FAMILIES := bezier cassini circle ellipse epitrochoid fourier hypotrochoid lobed logarithmic_spiral pascal superformula

.PHONY: all images api-images examples ci-example-manifest readme docs docs-pages FORCE test test-smoke test-deliberate test-full test-bezier-invalid test-fourier-invalid check check-docs clean

MAIN_EXAMPLE := examples/main_curved_gear.scad
MAIN_IMAGE := images/main_curved_gear.png
MAIN_EXAMPLES := $(foreach family,$(FAMILIES),examples/functions/$(family)/curve_gear_$(family).scad)
CORE_EXAMPLES := examples/tooth/construction.scad examples/tooth/placement.scad examples/tooth/assembly.scad
CORE_IMAGES := images/tooth/construction.png images/tooth/placement.png images/tooth/assembly.png
API_EXAMPLES := $(shell find examples/functions -type f -name '*.scad' -print | sort)
API_GEOMETRY_EXAMPLES := $(filter-out %_centre_distance.scad %_mate_rotation.scad %_reference_separation.scad,$(API_EXAMPLES))
API_IMAGES := $(patsubst examples/%.scad,images/%.png,$(API_GEOMETRY_EXAMPLES))
CI_EXAMPLES := $(sort $(MAIN_EXAMPLE) $(CORE_EXAMPLES) $(API_EXAMPLES))
CI_EXAMPLE_MANIFEST := build/ci-images/manifest.tsv

all: images examples readme docs-pages tests/README.md

images: $(MAIN_IMAGE) api-images $(CORE_IMAGES)

api-images: $(API_IMAGES)

$(API_IMAGES): IMAGE_SIZE=$(CI_IMAGE_SIZE)
$(CORE_IMAGES): IMAGE_SIZE=$(CORE_IMAGE_SIZE)

$(MAIN_IMAGE): $(MAIN_EXAMPLE) $(MAIN_EXAMPLES) $(PREVIEW_SOURCE_DEPS)
	@mkdir -p $(@D)
	$(OPENSCAD) -o "$@" --camera=$(CAMERA) --colorscheme=$(COLORSCHEME) --projection=o --viewall --autocenter --imgsize=$(IMAGE_SIZE) -q "$<"

images/%.png: examples/%.scad $(PREVIEW_SOURCE_DEPS)
	@mkdir -p $(@D)
	$(OPENSCAD) -o "$@" --camera=$(CAMERA) --colorscheme=$(COLORSCHEME) --projection=o --viewall --autocenter --imgsize=$(IMAGE_SIZE) -q "$<"


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
	@test "$(words $(API_EXAMPLES))" -eq 64
	@for example in $(API_EXAMPLES); do test -s "$$example" || { echo "missing API example: $$example"; exit 1; }; done
	@echo 'PASS: every documented public callable has one API example'

ci-example-manifest:
	@mkdir -p "$(@D)"
	@for example in $(CI_EXAMPLES); do \
		relative=$${example#examples/}; output=$${relative%.scad}.png; \
		printf '%s\t%s\n' "$$example" "build/ci-images/$$output"; \
	done > "$(CI_EXAMPLE_MANIFEST)"
	@test "$$(wc -l < "$(CI_EXAMPLE_MANIFEST)" | tr -d ' ')" -eq 68
	@test "$$(cut -f1 "$(CI_EXAMPLE_MANIFEST)" | sort -u | wc -l | tr -d ' ')" -eq 68
	@echo 'PASS: CI manifest contains all 68 canonical examples'

readme:
	@test -s README.md
	@sed -e 's|@README@||g' -e 's|@DOCS@|docs/|g' -e 's|@EXAMPLES@|examples/|g' -e 's|@TESTS@|tests/|g' "$(NAVIGATION_TEMPLATE)" | tail -n +2 | while IFS= read -r navigation_line; do \
		test -z "$$navigation_line" || grep -Fq -- "$$navigation_line" README.md || { echo "missing README navigation line: $$navigation_line"; exit 1; }; \
	done
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

DOC_PAGES := docs/bezier.md docs/cassini.md docs/circle.md docs/ellipse.md docs/epitrochoid.md docs/fourier.md docs/hypotrochoid.md docs/lobed.md docs/logarithmic_spiral.md docs/pascal.md docs/superformula.md docs/tooth-construction.md docs/tooth-placement.md docs/mate-motion.md docs/mate-generation.md docs/pair-assembly.md

FORCE:

define DOXYDOC_PAGE
$(1): $(3) $(4) $(5) $(6) $(NAVIGATION_TEMPLATE) $(FOOTER_TEMPLATE) FORCE
	@mkdir -p "$$(@D)"
	@printf '%s\n' '# $(2)' '' '## Documentation navigation' '' > "$$@"
	@sed -e 's|@README@|../README.md|g' -e 's|@DOCS@||g' -e 's|@EXAMPLES@|../examples/|g' -e 's|@TESTS@|../tests/|g' "$(NAVIGATION_TEMPLATE)" >> "$$@"
	@printf '\n\n' >> "$$@"
	@$(DOCGEN) -g -e c -l c "$(3)" "$(4)" "$(5)" "$(6)" >> "$$@"
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
$(eval $(call DOXYDOC_PAGE,docs/ellipse.md,Ellipse,src/ellipse/base.scad,src/ellipse/gear.scad,src/ellipse/mate.scad,src/ellipse/pair.scad))
$(eval $(call DOXYDOC_PAGE,docs/lobed.md,Lobed,src/lobed/base.scad,src/lobed/gear.scad,src/lobed/mate.scad,src/lobed/pair.scad))
$(eval $(call DOXYDOC_PAGE,docs/superformula.md,Superformula,src/superformula/base.scad,src/superformula/gear.scad,src/superformula/mate.scad,src/superformula/pair.scad))
$(eval $(call DOXYDOC_PAGE,docs/pascal.md,Pascal,src/pascal/base.scad,src/pascal/gear.scad,src/pascal/mate.scad,src/pascal/pair.scad))
$(eval $(call DOXYDOC_PAGE,docs/fourier.md,Fourier,src/fourier/base.scad,src/fourier/gear.scad,src/fourier/mate.scad,src/fourier/pair.scad))
$(eval $(call DOXYDOC_PAGE,docs/bezier.md,Bézier,src/bezier/base.scad,src/bezier/gear.scad,src/bezier/mate.scad,src/bezier/pair.scad))
$(eval $(call DOXYDOC_PAGE,docs/cassini.md,Cassini,src/cassini/base.scad,src/cassini/gear.scad,src/cassini/mate.scad,src/cassini/pair.scad))
$(eval $(call DOXYDOC_PAGE,docs/hypotrochoid.md,Hypotrochoid,src/hypotrochoid/base.scad,src/hypotrochoid/gear.scad,src/hypotrochoid/mate.scad,src/hypotrochoid/pair.scad))
$(eval $(call DOXYDOC_PAGE,docs/logarithmic_spiral.md,Logarithmic Spiral,src/logarithmic_spiral/base.scad,src/logarithmic_spiral/gear.scad,src/logarithmic_spiral/mate.scad,src/logarithmic_spiral/pair.scad))
$(eval $(call DOXYDOC_PAGE,docs/epitrochoid.md,Epitrochoid,src/epitrochoid/base.scad,src/epitrochoid/gear.scad,src/epitrochoid/mate.scad,src/epitrochoid/pair.scad))
$(eval $(call DOXYDOC_SINGLE_PAGE,docs/tooth-construction.md,Tooth construction,src/tooth/generation.scad))
$(eval $(call DOXYDOC_SINGLE_PAGE,docs/tooth-placement.md,Tooth placement,src/tooth/placement.scad))
$(eval $(call DOXYDOC_SINGLE_PAGE,docs/mate-motion.md,Mate motion,src/mate/motion.scad))
$(eval $(call DOXYDOC_SINGLE_PAGE,docs/mate-generation.md,Mate generation,src/mate/placement.scad))
$(eval $(call DOXYDOC_SINGLE_PAGE,docs/pair-assembly.md,Pair assembly,src/pair/assembly.scad))

docs-pages: $(DOC_PAGES)

docs: readme docs-pages images examples tests/README.md

REGRESSION_SMOKE_SOURCES := $(shell find tests -type f -name '*.scad' \
	! -name 'invalid_*.scad' ! -name '*_failure.scad' ! -name 'validation_cases.scad' \
	! -name 'equivalence.scad' ! -name 'accessibility_cases.scad' ! -path 'tests/superformula/mate_pipeline.scad' \
	! -name 'contact.scad' ! -name 'reference.scad' ! -exec rg -q '^// @regression: manual' {} \; -print | sort)
REGRESSION_SMOKE_ALL := $(patsubst tests/%.scad,$(REGRESSION_DIR)/smoke/%.stl,$(REGRESSION_SMOKE_SOURCES))
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
		printf '%s\t%s\n' "$$source" "$(REGRESSION_DIR)/smoke/$$relative.stl"; \
	done > "$@"

$(REGRESSION_DIR)/smoke/%.stl: tests/%.scad $(REGRESSION_SOURCE_DEPS) $(REGRESSION_TEST_DEPS)
	@mkdir -p "$(@D)"
	$(OPENSCAD) -o "$@" "$<" > "$(@:.stl=.log)" 2>&1

REGRESSION_DELIBERATE_tooth_generation := $(REGRESSION_DIR)/tooth_equivalence_deliberate.ok
REGRESSION_DELIBERATE_tooth_placement := $(REGRESSION_DIR)/tooth_validation_cases_deliberate.ok $(REGRESSION_DIR)/collision_failure_deliberate.failed $(REGRESSION_DIR)/polygon_failure_deliberate.failed
REGRESSION_DELIBERATE_common_math :=
REGRESSION_DELIBERATE_mate_motion :=
REGRESSION_DELIBERATE_superformula := $(REGRESSION_DIR)/splice_validation_deliberate.failed $(REGRESSION_DIR)/accessibility_cases_deliberate.ok
REGRESSION_DELIBERATE_ALL := $(REGRESSION_DELIBERATE_tooth_generation) $(REGRESSION_DELIBERATE_tooth_placement) $(REGRESSION_DELIBERATE_common_math) $(REGRESSION_DELIBERATE_mate_motion) $(REGRESSION_DELIBERATE_superformula)
REGRESSION_DELIBERATE_OUTPUTS := $(if $(strip $(REGRESSION_SELECTED_FAMILIES)),$(foreach family,$(REGRESSION_SELECTED_FAMILIES),$(REGRESSION_DELIBERATE_$(family))),$(REGRESSION_DELIBERATE_ALL))

define REGRESSION_EXPECT_SUCCESS
$(REGRESSION_DIR)/$(1)_deliberate.ok: $(2) $(REGRESSION_SOURCE_DEPS) $(REGRESSION_TEST_DEPS)
	@mkdir -p "$$(@D)"
	$(OPENSCAD) -o "$(REGRESSION_DIR)/$(1)_deliberate.stl" "$$<" > "$(REGRESSION_DIR)/$(1)_deliberate.log" 2>&1
	@touch "$$@"
endef

define REGRESSION_EXPECT_FAILURE
$(REGRESSION_DIR)/$(1)_deliberate.failed: $(2) $(REGRESSION_SOURCE_DEPS) $(REGRESSION_TEST_DEPS)
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

$(REGRESSION_DIR)/invalid/%.failed: tests/%.scad $(REGRESSION_SOURCE_DEPS) $(REGRESSION_TEST_DEPS)
	@mkdir -p "$(@D)"
	@rm -f "$(@:.failed=.stl)"
	@set +e; $(OPENSCAD) -o "$(@:.failed=.stl)" "$<" > "$(@:.failed=.log)" 2>&1; status=$$?; test $$status -ne 0
	@touch "$@"

test: $(REGRESSION_SMOKE_OUTPUTS) $(REGRESSION_SMOKE_MANIFEST) $(REGRESSION_DELIBERATE_OUTPUTS) $(REGRESSION_INVALID_OUTPUTS)
	$(PYTHON) -m utils.regression.check $(foreach family,$(REGRESSION_SELECTED_FAMILIES),--family $(family))

test-smoke: $(REGRESSION_SMOKE_OUTPUTS) $(REGRESSION_SMOKE_MANIFEST)
	$(PYTHON) -m utils.regression.check --smoke-only $(foreach family,$(REGRESSION_SELECTED_FAMILIES),--family $(family))

test-deliberate: $(REGRESSION_DELIBERATE_OUTPUTS)
	$(PYTHON) -m utils.regression.check --deliberate-only $(foreach family,$(REGRESSION_SELECTED_FAMILIES),--family $(family))

FULL_PIPELINE_OUTPUTS := $(foreach family,$(FAMILIES),$(REGRESSION_DIR)/full_$(family).stl)

define FULL_PIPELINE_RENDER
$(REGRESSION_DIR)/full_$(1).stl: tests/$(1)/full_pipeline.scad $(REGRESSION_SOURCE_DEPS) $(REGRESSION_TEST_DEPS)
	@mkdir -p "$$(@D)"
	$(OPENSCAD) -o "$$@" "$$<" > "$$(@:.stl=.log)" 2>&1
	@test -s "$$@"
endef

$(foreach family,$(FAMILIES),$(eval $(call FULL_PIPELINE_RENDER,$(family))))

test-full: $(if $(strip $(REGRESSION_FAMILIES)),$(foreach family,$(REGRESSION_FAMILIES),$(REGRESSION_DIR)/full_$(family).stl),$(FULL_PIPELINE_OUTPUTS))
	@echo 'PASS: full maintained family renders'

test-bezier-invalid: $(filter $(REGRESSION_DIR)/invalid/bezier/%,$(REGRESSION_INVALID_ALL))
	@echo 'PASS: Bézier invalid closure and tangent cases rejected'

test-fourier-invalid: $(filter $(REGRESSION_DIR)/invalid/fourier/%,$(REGRESSION_INVALID_ALL))
	@echo 'PASS: Fourier invalid coefficient envelope rejected'

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
	@for source in $$(find src/common src/tooth src/mate src/pair -type f -name '*.scad') src/CurveGears.scad src/CurveGearPairs.scad $$(find src -mindepth 2 -maxdepth 2 -type f -name 'base.scad'); do \
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
	@grep -Fq '../images/tooth/construction.png' docs/tooth-construction.md
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
	find images -type f -name '*.png' -delete
