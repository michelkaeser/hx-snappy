package snappy;

import haxe.io.Bytes;
import haxe.io.BytesData;
import snappy.Loader;
import snappy.SnappyException;

/**
 * Haxe wrapper class around the C FFI implementation wrapping the Snappy compression library.
 */
class Snappy
{
    /**
     * References to the native snappy function implementations loaded through C FFI.
     */
    private static var _compress:BytesData->Int->BytesData   = Loader.load("hx_snappy_compress", 2);
    private static var _uncompress:BytesData->Int->BytesData = Loader.load("hx_snappy_uncompress", 2);
    private static var _validate:BytesData->Int->Int         = Loader.load("hx_snappy_validate", 2);


    /**
     * Compresses the input Bytes.
     *
     * @param Null<haxe.io.Bytes> bytes the Bytes to compress
     *
     * @return haxe.io.Bytes the compressed Bytes
     *
     * @throws snappy.SnappyException if the FFI call raises an error
     */
    public static function compress(bytes:Null<Bytes>):Bytes
    {
        var compressed:Bytes;
        if (bytes == null || bytes.length == 0) {
            compressed = Bytes.alloc(0);
        } else {
            try {
                compressed = Bytes.ofData(Snappy._compress(bytes.getData(), bytes.length));
            } catch (ex:Dynamic) {
                throw new SnappyException(ex);
            }
        }

        return compressed;
    }

    /**
     * Uncompresses the input Bytes.
     *
     * @param Null<haxe.io.Bytes> bytes the Bytes to uncompress
     *
     * @return haxe.io.Bytes the uncompressed Bytes
     *
     * @throws snappy.SnappyException if the FFI call raises an error
     */
    public static function uncompress(bytes:Null<Bytes>):Bytes
    {
        var uncompressed:Bytes;
        if (bytes == null || bytes.length == 0) {
            uncompressed = Bytes.alloc(0);
        } else {
            try {
                uncompressed = Bytes.ofData(Snappy._uncompress(bytes.getData(), bytes.length));
            } catch (ex:Dynamic) {
                throw new SnappyException(ex);
            }
        }

        return uncompressed;
    }

    /**
     * Checks if the compressed input Bytes can sucessfully be uncompressed by Snappy.
     *
     * @param haxe.io.Bytes bytes the Bytes to validate
     *
     * @return Bool true if valid Snappy bytes
     */
    public static inline function validate(bytes:Bytes):Bool
    {
        return Snappy._validate(bytes.getData(), bytes.length) == 0;
    }
}
