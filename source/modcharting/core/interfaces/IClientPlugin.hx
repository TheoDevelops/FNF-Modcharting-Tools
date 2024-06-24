package modcharting.core.interfaces;

import modcharting.core.meta.OptionList;

interface IClientPlugin
{
    public function getNoteClass():Class<FlxBasic>
    public function getReceptorClass():Class<FlxBasic>
    
    public function getReceptorList():Array<FlxBasic>
    public function getNoteList():Array<FlxBasic>
    
    public function getScrollSpeed():Float
    public function getOptions():OptionList
    
    public function isPixelHUD():Bool
    public function isPixelStage():Bool
    
    public function getNoteXOffset():Float
    
    public function getCrochet():Float
}