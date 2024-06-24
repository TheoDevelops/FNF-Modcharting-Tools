package modcharting.core.macros;

import modcharting.core.meta.Modifier;

import haxe.macro.Context;
import haxe.macro.Expr.Position;
import haxe.macro.Expr.Field;
import haxe.macro.Expr.Function;
import haxe.macro.Expr.Access;
import haxe.macro.Expr.FieldType;

/*
 * Macros for Automate
   required variables
   for MT
 * @author TheoDev
 */
/*
    buildFunkinLua
    buildNote (done)
    buildStrum (done with haxeflag, ex injectSkewFields)
    buildRenderer
*/
class ModchartDefines
{
    /*
     * Defines:
      - z:Float (Public access, 0 by Default)
      - mesh:SustainStrip (Public access, null by Default)
     */
    public static function buildNote():Array<Field>
    {
        var pos:Position = Context.currentPos();
        
        var fields:Array<Field> = Context.getBuildFields().concat([
          {
            name: "z",
            access: [Access.APublic],
            kind: FVar(macro :Float, macro $v{0}),
            pos: pos,
          },
          {
            name: "mesh",
            access: [Access.APublic],
            kind: FVar(macro :modcharting.SustainStrip, macro $v{null}),
            pos: pos
          }
        ]);
        
        injectSkewedFields();

        return fields;
    }
    #if (PSYCH && PSYCHVERSION >= "0.7.0")
    /*
     * Defines:
      - instance:FunkinLua (Public static access, null by default)
     */
    public static function buildFunkinLua():Array<Field>
    {
        var pos:Position = Context.currentPos();
        var fields:Array<Field> = Context.getBuildFields().concat([
            {
                name: "instance",
                access: [APublic, AStatic],
                kind: FVar(macro: psychlua.FunkinLua, macro $v{null}),
                pos: pos
            }
        ]);
        
        return fields;
    }
    #end
    
    public static function injectSkewedFields():Array<Fields>
    {
        var fields:Array<Field> = Context.getBuildFields();
        var pos:Position = Context.currentPos();
        
        /*for (field in fields)
        {
            if (!field.kind == FFun) continue;
            
            if (["drawComplex", "isSimpleRender", "destroy"].exists(field.meta.name)
                fields.remove(field);
        }*/
        // Functions
        var destroyFun:Field = {
            name : "destroy",
            pos : pos,
            kind : FFun({
                args: [],
                ret: macro: Void,
                expr: macro {
                    skew = flixel.util.FlxDestroyUtil.put(skew);
                    _skewMatrix = null;
                    transformMatrix = null;

                    super.destroy();
                }
            }),
            access : [AOverride, APublic]
        };
        var drawCXFun:Field = {
            name : "drawComplex",
            pos : pos,
            kind : FFun({
                args: [
                {
                    name: "camera",
                    type: flixel.FlxCamera,
                    opt: false
                }],
                ret: macro: Void,
                expr: macro {
                    _frame.prepareMatrix(_matrix, FlxFrameAngle.ANGLE_0, checkFlipX(), checkFlipY());
                    _matrix.translate(-origin.x, -origin.y);
                    _matrix.scale(scale.x, scale.y);

                    if (matrixExposed)
                    {
                        _matrix.concat(transformMatrix);
                    }
                    else
                    {
                        if (bakedRotationAngle <= 0)
                        {
                            updateTrig();

                            if (angle != 0)
                                _matrix.rotateWithTrig(_cosAngle, _sinAngle);
                        }

                        updateSkewMatrix();
                        _matrix.concat(_skewMatrix);
                    }

                    getScreenPosition(_point, camera).subtractPoint(offset);
                    _point.addPoint(origin);
                    if (isPixelPerfectRender(camera))
                        _point.floor();

                    _matrix.translate(_point.x, _point.y);
                    camera.drawPixels(_frame, framePixels, _matrix, colorTransform, blend, antialiasing, shader);
                }
            }),
            access : [AOverride, APublic]
        };
        var iSRFun:Field = {
            name : "isSimpleRender",
            pos : pos,
            kind : FFun({
                args: [
                {
                    name: "camera",
                    type: flixel.FlxCamera,
                    opt: true
                }],
                ret: macro: Bool,
                expr: macro {
                    if (flixel.FlxG.renderBlit)
                    {
                        return super.isSimpleRender(camera) && (skew.x == 0) && (skew.y == 0) && !matrixExposed;
                    }
                    else
                    {
                        return false;
                    }
                }
            }),
            access : [AOverride, APrivate]
        };
        var uSMFun:Field = {
            name : "updateSkewMatrix",
            pos : pos,
            kind : FFun({
                args: [],
                ret: macro: Void,
                expr: macro {
                    _skewMatrix.identity();

                    if (skew.x != 0 || skew.y != 0)
                    {
                        _skewMatrix.b = Math.tan(skew.y * FlxAngle.TO_RAD);
                        _skewMatrix.c = Math.tan(skew.x * FlxAngle.TO_RAD);
                    }
                }
            }),
            access : [APrivate]
        };
        
        fields.concat([
            {
                name: "skew",
                access: [APublic],
                kind: FVar(macro :flixel.math.FlxPoint, macro $v{flixel.math.FlxPoint.get()}),
                pos: pos
            },
            {
                name: "transformMatrix",
                access: [APublic],
                kind: FVar(macro :openfl.geom.Matrix, macro $v{new openfl.geom.Matrix()}),
                pos: pos
            },
            {
                name: "matrixExposed",
                access: [APublic],
                kind: FVar(macro :Bool, macro $v{true}),
                pos: pos
            },
            {
                name: "_skewMatrix",
                access: [APrivate],
                kind: FVar(macro :openfl.geom.Matrix, macro $v{new openfl.geom.Matrix()}),
                pos: pos
            },
            destroyFun, 
            drawCXFun, 
            iSRFun, 
            uSMFun
        ]);
        
        return fields;
    }
}