data/filelist.txt: data/filelist.html bin/extract-filelist.py
	bin/extract-filelist.py "$<" > "$@"

data/filelist.html:
	curl -L -o "$@" http://download.companieshouse.gov.uk/en_accountsdata.html

data/Accounts_Bulk_Data-%.zip:
	curl -L -o "$@" http://download.companieshouse.gov.uk/$(@F)

ZIPFILES=$(shell sed 's/^/data\//' data/filelist.txt)

all: data/filelist.txt $(ZIPFILES)
	bin/unzip-all.sh

.PHONY: all
