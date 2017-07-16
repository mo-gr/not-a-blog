site:
	stack build

clean:
	stack clean
	stack exec site clean
	rm -rf _deploy

_site: site
	stack exec site rebuild

_deploy:
	mkdir -p _deploy
	cd _deploy && git init && git remote add origin 'git@github.com:mo-gr/mo-gr.github.com.git' && git pull origin master

publish: _site _deploy
	rsync -av _site/ _deploy
	cd _deploy && git add . && git commit -m "`date`"
