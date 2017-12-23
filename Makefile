watch:
	stack exec site watch

site:
	stack build

clean:
	stack clean
	stack exec site clean
	rm -rf _deploy
