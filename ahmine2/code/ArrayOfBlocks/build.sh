#!/bin/sh
#---
# Excerpted from "Learn to Program with Minecraft Plugins, CanaryMod Edition",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/ahmine2 for more book information.
#---

# Set the variable MCSERVER to ~/Desktop/server
# unless it's already set
: ${MCSERVER:="$HOME/Desktop/server"}

MODS="$MCSERVER"/CanaryMod.jar
EZ="$MCSERVER"/lib/EZPlugin.jar
if [ "$OS" = "Windows_NT" ]
then
    OSPS=";"
else
    OSPS=":"
fi

# Make sure that the library jar
# exists and is readable
if [ ! -r "$MODS" ]; then
    echo "$MODS doesn't seem to exist.  Make sure you have CanaryMod.jar installed at $MCSERVER and run again.  If your server is not at $MCSERVER, set your MCSERVER environment variable to point to the correct directory."
    exit 1
fi

if [ ! -r $EZ ]; then
    echo "$EZ doesn't seem to exist.  Make sure you have EZPlugin.jar installed at $MCSERVER/lib and run again."
    exit 1
fi

# Make the build directories if they aren't there.
# Throw away any error if they are.
mkdir bin 2>/dev/null
mkdir dist 2>/dev/null

# Remove any previous build products
rm -f bin/*/*.class
rm -f dist/*.jar

# Get the name of this plugin
# from the directory it's in
HERE=`pwd`
NAME=`basename "$HERE"`

# 1. Compile
echo "Compiling with javac..."
javac -Xlint:deprecation src/*/*.java -d bin -classpath "$MODS$OSPS$EZ" -sourcepath src -g:lines,vars,source || exit 2

# 2. Build the jar
echo "Creating jar file..."
jar -cfm dist/"$NAME.jar" Manifest.txt *.inf -C bin . || exit 3

# 3. Copy to server
echo "Deploying jar to $MCSERVER/plugins..."
test ! -d "$MCSERVER/plugins" && mkdir "$MCSERVER/plugins" 
cp dist/$NAME.jar "$MCSERVER"/plugins || exit 4

echo "Completed Successfully."
