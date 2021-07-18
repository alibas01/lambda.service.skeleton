setup:
	rm -rf venv/
	virtualenv venv/ 
	sudo venv/bin/pip install -r requirements.txt
	# sudo venv/bin/pip install --upgrade --force-reinstall numpy
run:
	. venv/bin/activate; python app/main.py

houston:
	. venv/bin/activate; nose2 -v

lambda_package: setup
	rm -rf package/ && mkdir -p package/ && mkdir -p storage/
	cp -r venv/lib/python3.8/site-packages/* package/
	cp -r app/ package/
	cp -r helpers/ package/
	cd package; zip -r package.zip . -x \*.git\* \*env\* *.zip
	mv package/package.zip infrastructure/lambda/
	@echo "Done building AWS Lambda package in infrastructure/lambda/package.zip"
	# cd infrastructure/ && terraform get

deploy_test:
	cd infrastructure/ && terraform plan
deploy:
	cd infrastructure/ && terraform apply


