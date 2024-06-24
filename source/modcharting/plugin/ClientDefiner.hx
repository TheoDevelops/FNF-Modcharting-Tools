package modcharting.plugin;

import haxe.macro.Compiler;
import haxe.macro.Context;
import haxe.macro.Expr.Field;

import modcharting.plugin.StandaloneClient;

class ClientDefiner
{
  public static var PLUGINS_ROOT:String = 'modcharting.plugin.adapters.';
  public static var ENGINE_VERSION:Null<String> = null;
  
  public static function buildClient():Array<Field>
  {
    var fields:Array<Field> = Context.getBuildFields();
    
    Context.info("Trying to install adapter plugin...");
    
    var client:Null<Class<StandaloneClient>> = null>
    var engine:String = Compiler.getDefine("ENGINE");
    client = Type.resolveClass(PLUGINS_ROOT + engine.substr(0, 1).toUpperCase() + engine.substr(1).toLowerCase() + 'Client');
    if (client == null)
      throw "No client founded for this engine, did you forgot to add the define? [Aborting Compiler]";
      
    Context.info('Plugin founded !!\nPlugin name: $client');
      
    fields.push({
      name: "instance",
      access: [APublic, AStatic],
      kind: FVar(macro: Class<StandaloneClient>, macro $v{client}),
      pos: Context.currentPos()
    });
    return fields;
  }
}