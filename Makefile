ifeq (${PREFIX},)
	PREFIX=/usr
endif
sharedir = $(DESTDIR)$(PREFIX)/share
libexecdir = $(DESTDIR)$(PREFIX)/lib

ifeq (${builddir},)
	builddir=build
endif

all: ibus-engine-rime

ibus-engine-rime:
	mkdir -p $(builddir)
	(cd $(builddir); cmake -DCMAKE_BUILD_TYPE=Release .. && make)
	@echo ':)'

ibus-engine-rime-static:
	mkdir -p $(builddir)
	(cd $(builddir); cmake -DCMAKE_BUILD_TYPE=Release -DBUILD_STATIC=ON .. && make)
	@echo ':)'

install:
	install -m 755 -d $(sharedir)/ibus/component
	install -m 644 -t $(sharedir)/ibus/component/ rime.xml
	install -m 755 -d $(libexecdir)/ibus-rime
	install -m 755 -t $(libexecdir)/ibus-rime/ $(builddir)/ibus-engine-rime
	install -m 755 -d $(sharedir)/ibus-rime
	install -m 755 -d $(sharedir)/ibus-rime/icons
	install -m 644 -t $(sharedir)/ibus-rime/icons/ icons/*.png

uninstall:
	rm $(sharedir)/ibus/component/rime.xml
	rm -R $(sharedir)/ibus-rime
	rm -R $(libexecdir)/ibus-rime

clean:
	if  [ -e $(builddir) ]; then rm -R $(builddir); fi
