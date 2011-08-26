STATIC=
COFFEE_FILES=$(shell find lib -name '*.coffee' 2> /dev/null)

DEPS=coffee-script

#STATIC_FILES=$(shell find $(STATIC) -type f 2> /dev/null | egrep '\.(css|js|jade|jpg|sass)$$')

COFFEE_OBJECTS=$(addprefix build/, $(subst .coffee,.js,$(COFFEE_FILES)))
STATIC_OBJECTS=$(addprefix build/, $(STATIC_FILES))
DEPS_OBJECTS=$(addprefix build/node_modules/, $(DEPS))

COFFEE=./build/node_modules/coffee-script/bin/coffee
QUIET=@

default: all
all: compile static

# TODO(sissel): Refactor this to be in the DEPS variable
build/node_modules/coffee-script: VERSION=1.1.1

clean:
	rm -f $(COFFEE_OBJECTS) $(STATIC_OBJECTS)

superclean:
	rm -fr build/

coffee-script: build/node_modules/coffee-script

%.coffee: Makefile

build/%.js: %.coffee | build coffee-script
	@echo "Compiling $< (to $@)"
	$(QUIET)[ -d $(shell dirname $@) ] || mkdir -p $(shell dirname $@)
	$(QUIET)$(COFFEE) -c -o $(shell dirname $@) $<

build/%.css: %.css | build
	@echo "Copying $< (to $@)"
	$(QUIET)[ -d $(shell dirname $@) ] || mkdir -p $(shell dirname $@)
	$(QUIET)cp $< $@

build/%.sass: %.sass | build
	@echo "Copying $< (to $@)"
	$(QUIET)[ -d $(shell dirname $@) ] || mkdir -p $(shell dirname $@)
	$(QUIET)cp $< $@

build/%.js: %.js | build
	@echo "Copying $< (to $@)"
	$(QUIET)[ -d $(shell dirname $@) ] || mkdir -p $(shell dirname $@)
	$(QUIET)cp $< $@

build/%.jade: %.jade | build
	@echo "Copying $< (to $@)"
	$(QUIET)[ -d $(shell dirname $@) ] || mkdir -p $(shell dirname $@)
	$(QUIET)cp $< $@

build/%.jpg: %.jpg | build
	@echo "Copying $< (to $@)"
	$(QUIET)[ -d $(shell dirname $@) ] || mkdir -p $(shell dirname $@)
	$(QUIET)cp $< $@

build: 
	$(QUIET)mkdir build

static: $(STATIC_OBJECTS)
compile: deps $(COFFEE_OBJECTS)

build/node_modules: | build
	$(QUIET)mkdir $@

build/node_modules/%: VERSIONSPEC=$(shell [ ! -z "$(VERSION)" ] && echo "@$(VERSION)")
build/node_modules/%: NAME=$(shell basename $@)
build/node_modules/%: | build/node_modules
	@echo "Installing $(NAME)$(VERSIONSPEC)"
	$(QUIET)(cd build; npm install $(NAME)$(VERSIONSPEC))

deps: $(DEPS_OBJECTS)

build/vxin-loggly-full.js: compile
	cat \
	build/public/javascripts/d3/d3.js \
	build/public/javascripts/d3/d3.geom.js \
	build/public/javascripts/d3/d3.behavior.js \
	build/public/javascripts/d3/d3.layout.js \
	build/public/javascripts/d3/d3.csv.js \
	build/public/javascripts/d3/d3.time.js \
	build/public/javascripts/d3/d3.chart.js \
	build/public/javascripts/d3/d3.geo.js \
	build/public/javascripts/inputs/*.js \
	build/public/javascripts/outputs/*.js \
	build/public/javascripts/widget.js \
	build/public/javascripts/vxin-loggly.js \
	> $@
