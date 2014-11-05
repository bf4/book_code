
# Porting from Bukkit to CanaryMod
#### _Learn to Program with Minecraft Plugins_
#### Andy Hunt, andy@pragprog.com, [pragprog.com/titles/ahmine](https://www.pragprog.com/titles/ahmine)

I've made an EZPlugin baseclass to help simplify basic plugins.  It takes care of the boiler-plate setup, sets up a logger, and provides some helper methods for common actions.

To build these plugins, you must first build the EZPlugin base:

    $ cd EZPlugin
    ./build_lib.sh

Then you can use `build.sh` for each individual plugin as needed.

## Moving from Bukkit to Canary

Here are some differences I've noted as I transition from Bukkit to CanaryMod:

1. `plugin.yml` is replaced with `Canary.inf`:

        main-class = packagename.ClassName
        name = ClassName
        author = AndyHunt, Learn to Program with Minecraft Plugins
        version = 1.0

1. All package names (and imports) are different, and many class names may have small differences in the name.  For example, `teleport` is named `teleportTo`.

1. Some methods have moved.
    Spawning entities, potions, playing sounds, and causing explosions are done via factory methods and methods in World, instead of in the lower-level object.  For many of these changes, I've made static helper methods in EZPlugin.java.  use `extends EZPlugin` and remove the call to initialize the Minecraft logger

1. `onCommand` callback is specified with annotations.
    Like this:
   
        @Command(aliases = { "name" },
            description = "Description",
            permissions = { "" },
            min = 1, // Number of arguments
            toolTip = "/name")
        public void myCommand(MessageReceiver caller, String[] args) {
            if (caller instanceof Player) { 
                Player me = (Player)caller;
                ...
    
    Note that "" means the permissions on this command are wide open; anyone can execute it.  "*" restricts it to root-level (op) permission, or you can specify a group, etc.
    
1. The `@EventHandler` annotation is named `@HookHandler`

1. The Scheduler is only slightly different.  For a scheduled task, start with this skeleton:

        package examplepackage;
        import net.canarymod.Canary;
        import net.canarymod.tasks.ServerTask;
        import com.pragprog.ahmine.ez.EZPlugin;
         
        public class ExampleTask extends ServerTask {
         
          private final EZPlugin plugin;

          public ExampleTask(JavaPlugin plugin) {
            super(Canary.getServer(), 0, true); // delay, isContinuous
            this.plugin = plugin;
            // you can keep a reference to your plugin as I've done here,
            // or to any other variable you pass in
          }

          public void run() {
            // Do something interesting...
            Canary.instance().getServer().broadcastMessage("Surprise!");
          }
        }
        
    To schedule and launch the task, create a new task and add it to the server:
    
        ExampleTask task = new ExampleTask(plugin);
        Canary.getServer().addSynchronousTask(task);

## Links

_Learn to Program with Minecraft Plugins_:
* 1st (Bukkit) Edition main page: [pragprog.com/titles/ahmine](https://www.pragprog.com/ahmine)
* Discussion Forum: [forums.pragprog.com/forums/314](https://forums.pragprog.com/forums/314)
* 2nd (CanaryMod.net) Edition github code: [github.com/andyhunt/minecraft-canarymod-plugins.git](https://github.com/andyhunt/minecraft-canarymod-plugins.git)

Canary API docs and reference:

* [http://docs.visualillusionsent.net/CanaryLib/1.0.0/index.html](http://docs.visualillusionsent.net/CanaryLib/1.0.0/index.html)
* [http://canarymod.net/books/api-reference](http://canarymod.net/books/api-reference)

Git source code for Canary Library and Mod server:

* [https://github.com/CanaryModTeam/CanaryLib.git](https://github.com/CanaryModTeam/CanaryLib.git)
* [https://github.com/CanaryModTeam/CanaryMod.git](https://github.com/CanaryModTeam/CanaryMod.git)