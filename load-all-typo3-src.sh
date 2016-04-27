#!/bin/bash

TYPO3_VERSION=${1:-7.6}
DOWNLOAD_PATH=${2:-/data}
LATEST_MINOR=$(curl -s -I -J -L http://get.typo3.org/${TYPO3_VERSION} | grep -o -E 'filename=.*$' | sed -e "s/filename=\"typo3_src-${TYPO3_VERSION}.\([0-9]*\).tar.gz\"/\1/")

if [[ ${LATEST_MINOR} == *"filename"* ]]
then
	echo "Latest Version could not be retrieved"
	exit 1
fi

LATEST_MINOR=$(echo ${LATEST_MINOR} | tr -cd '[[:digit:]]')

for (( MINOR=0; MINOR <=$LATEST_MINOR; MINOR++ ))
do
	if [[ -a "${DOWNLOAD_PATH}/typo3_src-${TYPO3_VERSION}.${MINOR}.tar.gz" ]]
	then
		echo "Version ${TYPO3_VERSION}.${MINOR} already exists. Skipping..."
	else
		echo "Downloading ${TYPO3_VERSION}.${MINOR}"
		cd /tmp
		wget --content-disposition -q --show-progress http://downloads.sourceforge.net/project/typo3/TYPO3%20Source%20and%20Dummy/TYPO3%20${TYPO3_VERSION}.${MINOR}/typo3_src-${TYPO3_VERSION}.${MINOR}.tar.gz
		if [ $? -eq 0 ]; then
			mv /tmp/typo3_src-${TYPO3_VERSION}.${MINOR}.tar.gz ${DOWNLOAD_PATH}/typo3_src-${TYPO3_VERSION}.${MINOR}.tar.gz
		else
			echo "Oops something went wrong. Not copying typo3_src-${TYPO3_VERSION}.${MINOR}.tar.gz"
		fi
	fi
done 
