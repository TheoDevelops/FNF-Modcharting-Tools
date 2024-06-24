package modcharting.plugin;

import modcharting.plugin.StandaloneClient;

class Client
{
    public static var instance(default, set):
    
    // @:isVar
    // private static var _logged(get, null):Bool = false;
    
    inline static public function set_instance(_plugin:StandaloneClient)
    {
        if (instance == null)
        {
            trace("Getting metadata plugin...");
            instance = _plugin;
            trace("Done");
            return instance;
        }
        trace("Metadata plugin was already added, changing it on mid-game can cause critical errors");
    
        return instance;
    }
}