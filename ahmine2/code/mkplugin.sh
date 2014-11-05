#!/bin/sh
#---
# Excerpted from "Learn to Program with Minecraft Plugins, CanaryMod Edition",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/ahmine2 for more book information.
#---

#
# Simple script to create a plugin skeleton
#

if [ "$1" = "" ]
then
  echo "Usage: $0 NewPluginName"
  exit 1
fi

PLUGIN_NAME=`echo $* | sed 's/[ ]*//g'`
LC_PLUGIN_NAME=`echo $PLUGIN_NAME | tr [A-Z] [a-z]`

if [ -d "$PLUGIN_NAME" ]
then
  echo "Directory $PLUGIN_NAME already exists."
  exit 1
fi

echo "Making directories under $PLUGIN_NAME"

mkdir $PLUGIN_NAME
mkdir $PLUGIN_NAME/src
mkdir $PLUGIN_NAME/src/$LC_PLUGIN_NAME
mkdir $PLUGIN_NAME/bin
mkdir $PLUGIN_NAME/dist

echo "Creating build.sh"

cat > $PLUGIN_NAME/build.sh <<EOF
#!/bin/sh

# Set the variable MCSERVER to ~/Desktop/server
# unless it's already set
: \${MCSERVER:="\$HOME"/Desktop/server}

MODS="\$MCSERVER/CanaryMod.jar"
EZ="\$MCSERVER/lib/EZPlugin.jar"

if [ "\$OS" = "Windows_NT" ]
then
    OSPS=";"
else
    OSPS=":"
fi

# Make sure that the jar
# exists and is readable
if [ ! -r "\$MODS" ]; then
    echo "\$MODS doesn't seem to exist.  Make sure you have CanaryMod.jar installed at \$MCSERVER and run again.  If your server is not at \$MCSERVER, set your MCSERVER environment variable to point to the correct directory."
    exit 1
fi

if [ ! -r "\$EZ" ]; then    
  echo "\$EZ doesn't seem to exist.  Make sure you have EZPlugin.jar installed at \$MCSERVER/lib and run again." 
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
HERE=\`pwd\`
NAME=\`basename "\$HERE"\`

# 1. Compile
echo "Compiling with javac..."
javac -Xlint:deprecation src/*/*.java -d bin -classpath "\$MODS\$OSPS\$EZ" -sourcepath src -g:lines,vars,source || exit 2

# 2. Build the jar
echo "Creating jar file..."
jar -cfm dist/"\$NAME.jar" Manifest.txt *.inf -C bin . || exit 3

# 3. Copy to server
echo "Deploying jar to \$MCSERVER/plugins..."
test ! -d "\$MCSERVER/plugins" && mkdir "\$MCSERVER/plugins" 
cp dist/\$NAME.jar "\$MCSERVER/plugins" || exit 4

echo "Completed Successfully."


EOF

chmod +x $PLUGIN_NAME/build.sh

echo "Creating Java template"

cat > $PLUGIN_NAME/src/$LC_PLUGIN_NAME/$PLUGIN_NAME.java <<EOF
package $LC_PLUGIN_NAME;
import net.canarymod.plugin.Plugin;
import net.canarymod.logger.Logman;
import net.canarymod.Canary;
import net.canarymod.commandsys.*;
import net.canarymod.chat.MessageReceiver;
import net.canarymod.api.entity.living.humanoid.Player;
import com.pragprog.ahmine.ez.EZPlugin;

public class $PLUGIN_NAME extends EZPlugin {
  
  @Command(aliases = { "$LC_PLUGIN_NAME" },
            description = "$LC_PLUGIN_NAME plugin",
            permissions = { "*" },
            toolTip = "/$LC_PLUGIN_NAME")
  public void ${LC_PLUGIN_NAME}Command(MessageReceiver caller, String[] parameters) {
    if (caller instanceof Player) { 
      Player me = (Player)caller;
      // Put your code after this line:

      // ...and finish your code before this line.
    }
  }
}
EOF

echo "Creating configuration template"

cat > $PLUGIN_NAME/Canary.inf <<EOF
main-class = $LC_PLUGIN_NAME.$PLUGIN_NAME
name = $PLUGIN_NAME
author = yourname
version = 1.0

EOF

cat > $PLUGIN_NAME/Manifest.txt <<EOF
Class-Path: ../lib/EZPlugin.jar

EOF

cat > $PLUGIN_NAME/.gitignore <<EOF
bin
dist
EOF


