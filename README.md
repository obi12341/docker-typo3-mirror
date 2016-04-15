## Synopsis

This Docker Container downloads all source archives for a specific major release. For example it can download all 7.6.x sources.
 
## Usage

You can run it like that:

	docker run -ti --rm -v <dir>:/data writl/typo3-mirror 7.6
	docker run -ti --rm -v <dir>:/data writl/typo3-mirror 6.2
	...

Please note, you can only specify major releases, which are available under http://get.typo3.org/<major>
