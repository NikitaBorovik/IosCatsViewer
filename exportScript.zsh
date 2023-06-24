#!/bin/zsh

alias PlistBuddy=/usr/libexec/PlistBuddy
INFO_PLIST_PATH=./CatsViewer/CatsViewer/Info.plist 

local CONFIG=$1
if [ "${CONFIG}" = 'CATS' ]; then
 EXPORT_PATH="./Exported_CATS"
else
 if [ "${CONFIG}" = 'DOGS' ]; then
  EXPORT_PATH="./Exported_DOGS"
 else
  echo wrong parameter 
  exit 1
 fi
fi

PlistBuddy -c "Set ':App Type' ${CONFIG}" $INFO_PLIST_PATH
WORKSPACE=CatsAndModules_NikitaBorovik.xcworkspace
SCHEME="CatsViewer"
CONFIG=Release
DEST="generic/platform=iOS"
VERSION="1.0.0"
ARCHIVE_PATH="./ARCHIVES/${VERSION}.xcarchive"
EXPORT_OPTIONS_PLIST="./exportOptions.plist"

xcodebuild clean -workspace "${WORKSPACE}" -scheme "${SCHEME}" -configuration "${CONFIG}"

xcodebuild build \
-workspace "${WORKSPACE}" \
-scheme "${SCHEME}" \
-configuration "${CONFIG}" \
-destination "${DEST}"

xcodebuild archive \
-archivePath "${ARCHIVE_PATH}" \
-workspace "${WORKSPACE}" \
-scheme "${SCHEME}" \
-configuration "${CONFIG}" \
-destination "${DEST}"

xcodebuild -exportArchive \
-archivePath "${ARCHIVE_PATH}" \
-exportPath "${EXPORT_PATH}" \
-exportOptionsPlist "${EXPORT_OPTIONS_PLIST}"

