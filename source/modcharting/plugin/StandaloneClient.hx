package modcharting.plugin;

import haxe.exceptions.NotImplementedException;

import modcharting.core.interfaces.IClientPlugin;

/*
 * All Standalone Plugins will extend to This
 */
class StandaloneClient implements IClientPlugin
{
    public function new() {}
    
    public function getNoteClass():Class<FlxBasic>
    {
        throw new NotImplementedException();
    }
    public function getReceptorClass():Class<FlxBasic>
    {
        throw new NotImplementedException();
    }
    public function getReceptorList():Array<FlxBasic>
    {
        throw new NotImplementedException();
    }
    public function getNoteList():Array<FlxBasic>
    {
        throw new NotImplementedException();
    }
    public function getScrollSpeed():Float
    {
        throw new NotImplementedException();
    }
    public function getOptions():OptionList
    {
        throw new NotImplementedException();
    }
    public function isPixelHUD():Bool
    {
        throw new NotImplementedException();
    }
    public function isPixelStage():Bool
    {
        throw new NotImplementedException();
    }
    public function getNoteXOffset():Float
    {
        throw new NotImplementedException();
    }
    public function getCrochet():Float
    {
        throw new NotImplementedException();
    }
}