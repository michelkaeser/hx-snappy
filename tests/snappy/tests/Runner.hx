package snappy.tests;

#if cpp
    import mcover.coverage.MCoverage;
    import mcover.coverage.CoverageLogger;
#end
import haxe.Timer;
import haxe.unit.TestRunner;

/**
 * TestSuite runner for classes in snappy package.
 */
class Runner
{
    public static function main():Void
    {
        var r = new TestRunner();

        r.add( new snappy.tests.TestSnappy() );

        var start:Float  = Timer.stamp();
        var success:Bool = r.run();
        Sys.println("The test suite took: " + (Timer.stamp() - start) + " ms.");
        #if cpp MCoverage.getLogger().report(); #end

        Sys.exit(success ? 0 : 1);
    }
}
