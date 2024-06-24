package modcharting.plugin.adapters;

import haxe.exceptions.NotImplementedException;

import modcharting.core.interfaces.IClientPlugin;

/*
 * All Standalone Plugins will extend to This
 */
class PsychClient extends StandaloneClient
{
    override public function getNoteClass():Class<FlxBasic>
    {
        return #if PSYCHVERSION >= "0.7.0" objects.Note #else Note #end;
    }
    override public function getReceptorClass():Class<FlxBasic>
    {
        return #if PSYCHVERSION >= "0.7.0" objects.StrumNote #else StrumNote #end;
    }
    override public function getReceptorList():Array<FlxBasic>
    {
        throw new NotImplementedException();
    }
    override public function getNoteList():Array<FlxBasic>
    {
        throw new NotImplementedException();
    }
    override public function getScrollSpeed():Float
    {
        throw new NotImplementedException();
    }
    override public function getOptions():OptionList
    {
        throw new NotImplementedException();
    }
    override public function isPixelHUD():Bool
    {
        throw new NotImplementedException();
    }
    override public function isPixelStage():Bool
    {
        throw new NotImplementedException();
    }
    override public function getNoteXOffset():Float
    {
        throw new NotImplementedException();
    }
    override public function getCrochet():Float
    {
        throw new NotImplementedException();
    }
}