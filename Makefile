
all: azurite-cs azullvm AZIR AZVM

azurite-cs:
	$(MAKE) -C /azurite-cs

azullvm:
	$(MAKE) -C /azullvm

AZIR:
	$(MAKE) -C /AZIR

AZVM:
	$(MAKE) -C /AZVM